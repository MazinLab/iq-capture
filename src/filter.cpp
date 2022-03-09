/* The DDR4 core can capture up to 2667MT/S on a 64 bit bus. I think this translates
 * to ~21336 MBPS
 * ADC stream is 512*32B ~16.3GB/s (8 IQ 2 bytes each @ 512MHz)
	- Could pack to 512*24B 12.2GB/s but unpacking in software would be a bear)
 * OPFB stream is 512M*64B ~ 32.7GB/s  (16 IQ 2 bytes each @ 512MHz)
 * Res Streams (selected bins and DDSed) are 512M*32B ~16.3GB/s (8 IQ 2 bytes each @ 512MHz)
 * LP Res Stream is 256M*32B ~8.2GB/s (8 IQ 2 bytes each @ 256MHz)
 * Phase Stream is 512M*8B ~4 GB/s (4 phase 2 bytes @ 512MHz)
*/
#include "filter.hpp"
#ifndef __SYNTHESIS__
#include <bitset>
#include <iostream>
using namespace std;
#endif
#include <assert.h>

bool fetch_keep(keep_t keep, unsigned char grp){
#pragma HLS INLINE off
	return keep[grp];
}

bool fetch_keep(phasekeep_t keep, phasegroup_t grp){
#pragma HLS INLINE off
	return keep[grp];
}


bool fetch_keep(pkeep256_t keep, pgroup256_t grp){
#pragma HLS INLINE off
	return keep[grp];
}

void _pair(uint128_t iin, uint128_t qin, uint256_t &iq){
#pragma HLS INLINE
	uint256_t dataout;
	bundle: for (int i=0;i<N_IQ;i++){
#pragma HLS UNROLL
		iq.range(32*i+15, 32*i)=iin.range(16*i+15, 16*i);
		iq.range(32*i+31, 32*i+16)=qin.range(16*i+15, 16*i);
	}
}

void pair_iq(hls::stream<uint128_t> &i_in, hls::stream<uint128_t> &q_in, hls::stream<iqout_t> &out) {
#pragma HLS PIPELINE II=1 REWIND
#pragma HLS INTERFACE mode=axis port=i_in register_mode=off //register
#pragma HLS INTERFACE mode=axis port=q_in register_mode=off //register
#pragma HLS INTERFACE mode=axis port=out register_mode=off //register
#pragma HLS INTERFACE mode=ap_ctrl_none port=return

	static ap_uint<8> group=0;
//	while (true) {
//#pragma HLS PIPELINE II=1
		iqout_t tmp;

		_pair(i_in.read(), q_in.read(), tmp.data);

		tmp.last=group==255;
		tmp.user=group;
		tmp.keep=-1;
		group++;
		out.write(tmp);
//	}
}

void pair_iq512(hls::stream<uint128_t> &i_in, hls::stream<uint128_t> &q_in, hls::stream<out512_t> &out) {
#pragma HLS INTERFACE mode=axis register_mode=off port=i_in //register
#pragma HLS INTERFACE mode=axis register_mode=off port=q_in //register
#pragma HLS INTERFACE mode=axis register_mode=off port=out //register
#pragma HLS INTERFACE mode=ap_ctrl_none port=return
#pragma HLS PIPELINE II=2 REWIND

	uint256_t  paired;
	uint512_t dataout;
	out512_t tmp;

	static ap_uint<7> group=0;

	_pair(i_in.read(), q_in.read(), paired);
	dataout.range(255,0) = paired.range();
	_pair(i_in.read(), q_in.read(), paired);
	dataout.range(511, 256) = paired.range();

	tmp.data=dataout;
	tmp.last=group==127;
	tmp.user=group++;
	tmp.keep=-1;
	out.write(tmp);
}


void filter_iq(hls::stream<resstream_t> &instream, hls::stream<iqout_t> &outstream, keep_t keep, group_t lastgrp) {
#pragma HLS PIPELINE II=1
#pragma HLS INTERFACE mode=axis port=instream depth=2048 register_mode=off //register
#pragma HLS INTERFACE mode=axis port=outstream depth=2048 register_mode=off //register
#pragma HLS INTERFACE mode=ap_ctrl_none port=return
#pragma HLS INTERFACE mode=s_axilite port=keep
#pragma HLS INTERFACE mode=s_axilite port=lastgrp

	resstream_t in;
	iqout_t tmp;
	bool _keep, _last;

	in = instream.read();

	_keep = fetch_keep(keep, in.user.to_uchar());
	_last = in.user==lastgrp;

	tmp.data = in.data;
	tmp.last = _last;
	tmp.keep=-1;
	if (_keep) outstream.write(tmp);
}



void filter_phase(hls::stream<phasestream_t> &instream, hls::stream<out256_t> &outstream, pkeep256_t keep, pgroup256_t lastgrp){
#pragma HLS PIPELINE II=4
#pragma HLS INTERFACE mode=axis port=instream register_mode=off //register
#pragma HLS INTERFACE mode=axis port=outstream register_mode=off //register
#pragma HLS INTERFACE mode=ap_ctrl_none port=return
#pragma HLS INTERFACE mode=s_axilite port=keep
#pragma HLS INTERFACE mode=s_axilite port=lastgrp

	phasestream_t in;
	pgroup256_t grp;
	out256_t tmp;
	bool _keep,_aligne;

	in = instream.read();
	_aligne = in.user.range(1,0)!=0;
	grp=pgroup256_t(in.user>>2);
	_keep = fetch_keep(keep, grp);

	tmp.data.range(63, 0) = in.data.range();
	if (!_aligne) {
		in = instream.read();
		tmp.data.range(127, 64) = in.data.range();
		in = instream.read();
		tmp.data.range(191, 128) = in.data.range();
		in = instream.read();
		tmp.data.range(255, 192) = in.data.range();
	}
	tmp.last=lastgrp== grp;
	tmp.keep=-1;
	if (_keep && !_aligne) outstream.write(tmp);
}
