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
//#include <string.h>
#include <assert.h>

bool fetch_keep(keep_t keep, unsigned char grp){
#pragma HLS INLINE off
	return keep[grp];
}

bool fetch_keep(phasekeep_t keep, phasegroup_t grp){
#pragma HLS INLINE off
	return keep[grp];
}


void pair_iq(hls::stream<uint128_t> &i_in, hls::stream<uint128_t> &q_in, hls::stream<iqout_t> &out) {
#pragma HLS INTERFACE mode=axis register_mode=both port=i_in register
#pragma HLS INTERFACE mode=axis register_mode=both port=q_in register
#pragma HLS INTERFACE mode=axis register_mode=both port=out register
#pragma HLS INTERFACE mode=ap_ctrl_none port=return
#pragma HLS PIPELINE II=1

	uint256_t dataout, paired;
	iqout_t tmp;
	uint128_t ival=i_in.read();
	uint128_t qval=q_in.read();
	static unsigned char group=0;

	paired.range(127,0) = ival.range();
	paired.range(255,128) = qval.range();

	bundle: for (int i=0;i<N_IQ;i++){
		dataout.range(32*i+15, 32*i)=paired.range(16*i+15, 16*i);
		dataout.range(32*i+31, 32*i+16)=paired.range(16*i+15+128, 16*i+128);
	}
	tmp.data=dataout;
	tmp.last=group==255;
	tmp.user=group++;
	out.write(tmp);
}


void filter_iq(hls::stream<resstream_t> &instream, hls::stream<iqout_t> &outstream, keep_t keep, group_t lastgrp) {
#pragma HLS PIPELINE II=1
#pragma HLS INTERFACE mode=axis register port=instream depth=2048
#pragma HLS INTERFACE mode=axis register port=outstream depth=2048
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

	if (_keep)
		outstream.write(tmp);
}


void filter_phase(hls::stream<phasestream_t> &instream, hls::stream<phaseout_t> &outstream, phasekeep_t keep, phasegroup_t lastgrp) {
#pragma HLS PIPELINE II=1
#pragma HLS INTERFACE mode=axis register port=instream
#pragma HLS INTERFACE mode=axis register port=outstream
#pragma HLS INTERFACE mode=ap_ctrl_none port=return
#pragma HLS INTERFACE mode=s_axilite port=keep
#pragma HLS INTERFACE mode=s_axilite port=lastgrp

	phasestream_t in;
	phaseout_t tmp;
	bool _keep, _last;

	in = instream.read();

	_keep = fetch_keep(keep, phasegroup_t(in.user));
	_last = in.user==lastgrp;

	tmp.data = in.data;
	tmp.last = _last;

	if (_keep)
		outstream.write(tmp);
}



void write_axi256(hls::stream<iqout_t> &filtered, capcount_t capturesize, uint256_t *out) {
#pragma HLS INTERFACE axis register port=filtered depth=2048
#pragma HLS INTERFACE mode=m_axi depth=2048 max_read_burst_length=1 max_widen_bitwidth=256 max_write_burst_length=128 num_read_outstanding=1 num_write_outstanding=1 port=out offset=slave
#pragma HLS INTERFACE s_axilite port=out bundle=control
#pragma HLS INTERFACE s_axilite port=capturesize bundle=control
#pragma HLS INTERFACE s_axilite port=return bundle=control
#pragma HLS STABLE variable=capturesize
#pragma HLS STABLE variable=out

	iqout_t in;
	unsigned int _capturesize;

	_capturesize = capturesize>>1;
	assert (_capturesize>0);

	sync: do {
#pragma HLS PIPELINE II=1
		in = filtered.read();
	} while (!in.last);

	write: for (unsigned int i=0; i<_capturesize; i++) {
#pragma HLS PIPELINE II=2
		in = filtered.read();
		out[2*i]=in.data;
		in = filtered.read();
		out[2*i+1]=in.data;
	}

//	write: for (unsigned int i=0; i<_capturesize; i++) {
//#pragma HLS PIPELINE II=128
//		burst: for (unsigned int j=0; j<128; j++) {
//#pragma HLS UNROLL
//			in = filtered.read();
//			out[128*i+j]=in.data;
//		}
//	}

}

void write_axi64(hls::stream<phaseout_t> &filtered, capcount_t capturesize, uint64_t *out) {
#pragma HLS INTERFACE axis register port=filtered depth=2048
#pragma HLS INTERFACE mode=m_axi depth=2048 max_read_burst_length=1 max_widen_bitwidth=256 max_write_burst_length=128 num_read_outstanding=1 num_write_outstanding=1 port=out offset=slave
#pragma HLS INTERFACE s_axilite port=out bundle=control
#pragma HLS INTERFACE s_axilite port=capturesize bundle=control
#pragma HLS INTERFACE s_axilite port=return bundle=control
#pragma HLS STABLE variable=capturesize
#pragma HLS STABLE variable=out

	phaseout_t in;
	unsigned int _capturesize;

	_capturesize = capturesize.to_uint()>>1;
	assert (_capturesize>0);

	sync: do {
#pragma HLS PIPELINE II=1
		in = filtered.read();
	} while (!in.last);

	write: for (unsigned int i=0; i<_capturesize; i++) {
#pragma HLS PIPELINE II=2
		in = filtered.read();
		out[2*i]=in.data;
		in = filtered.read();
		out[2*i+1]=in.data;
	}

}
