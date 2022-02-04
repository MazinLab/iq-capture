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
#pragma HLS INTERFACE mode=axis port=i_in register_mode=off //register
#pragma HLS INTERFACE mode=axis port=q_in register_mode=off //register
#pragma HLS INTERFACE mode=axis port=out register_mode=off //register
#pragma HLS INTERFACE mode=ap_ctrl_none port=return

	iqout_t tmp;
	static unsigned char group=0;

	_pair(i_in.read(), q_in.read(), tmp.data);

	tmp.last=group==255;
	tmp.user=group;
	tmp.keep=-1;
	group++;
	out.write(tmp);
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


void filter_phase64(hls::stream<phasestream_t> &instream, hls::stream<phaseout_t> &outstream, phasekeep_t keep, phasegroup_t lastgrp) {
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
		outstream.write_nb(tmp);
}


//filter_phase_256_ii1_v2
void filter_phase(hls::stream<phasestream_t> &instream, hls::stream<out256_t> &outstream, pkeep256_t keep, pgroup256_t lastgrp) {
#pragma HLS PIPELINE II=1
#pragma HLS INTERFACE mode=axis port=instream register_mode=off //register
#pragma HLS INTERFACE mode=axis port=outstream register_mode=off //register
#pragma HLS INTERFACE mode=ap_ctrl_none port=return
#pragma HLS INTERFACE mode=s_axilite port=keep
#pragma HLS INTERFACE mode=s_axilite port=lastgrp

	phasestream_t in;
	pgroup256_t grp;
	out256_t tmp;
	bool _keep;
	ap_uint<2> subgrpin;

	in = instream.read();

	subgrpin.range() = in.user.range(1,0);
	grp.range() = in.user.range(8,2);

	if (subgrpin==0)
		tmp.data.range(63, 0) = in.data.range();
	else if (subgrpin==1)
		tmp.data.range(127, 64) = in.data.range();
	else if (subgrpin==2)
		tmp.data.range(191, 128) = in.data.range();
	else
		tmp.data.range(255, 192) = in.data.range();

	_keep = fetch_keep(keep, grp);

	tmp.last=lastgrp==grp;
	tmp.keep=-1;

	if (_keep && subgrpin==3)
		outstream.write(tmp);

}


void filter_phase_256(hls::stream<phasestream_t> &instream, hls::stream<out256_t> &outstream, pkeep256_t keep, pgroup256_t lastgrp) {
#pragma HLS PIPELINE II=4
#pragma HLS INTERFACE mode=axis port=instream register_mode=off //register
#pragma HLS INTERFACE mode=axis port=outstream register_mode=off //register
#pragma HLS INTERFACE mode=ap_ctrl_none port=return
#pragma HLS INTERFACE mode=s_axilite port=keep
#pragma HLS INTERFACE mode=s_axilite port=lastgrp

	phasestream_t in;
	pgroup256_t grp;
	out256_t tmp;
	bool _keep;

	for (int i=0; i<4; i++) {
#pragma HLS UNROLL
		in = instream.read();
		tmp.data.range((i+1)*(N_PHASE*16)-1, i*(N_PHASE*16)) = in.data.range();
	}

	grp=pgroup256_t(in.user>>2);
	_keep = fetch_keep(keep, grp);
	tmp.last = lastgrp== grp;
	tmp.keep=-1;
	if (_keep) outstream.write(tmp);
}

void filter_phase_autoalign(hls::stream<phasestream_t> &instream, hls::stream<out256_t> &outstream, pkeep256_t keep, pgroup256_t lastgrp) {
#pragma HLS PIPELINE II=4
#pragma HLS INTERFACE mode=axis port=instream register_mode=off //register
#pragma HLS INTERFACE mode=axis port=outstream register_mode=off //register
#pragma HLS INTERFACE mode=ap_ctrl_none port=return
#pragma HLS INTERFACE mode=s_axilite port=keep
#pragma HLS INTERFACE mode=s_axilite port=lastgrp

	phasestream_t in;
	pgroup256_t grp;
	out256_t tmp;
	bool _keep, aligned;

	in = instream.read();
	aligned=(in.user&0x3)==0;
	tmp.data.range(N_PHASE*16-1, 0) = in.data.range();
	for (int i=1; i<3; i++) {
#pragma HLS UNROLL
		if (aligned)
			in = instream.read();
		tmp.data.range((i+1)*(N_PHASE*16)-1, i*(N_PHASE*16)) = in.data.range();
	}

	grp=pgroup256_t(in.user>>2);
	_keep = fetch_keep(keep, grp);
	tmp.last = lastgrp==grp;
	tmp.keep=-1;
	if (_keep&&aligned) outstream.write(tmp);
}



void write_axi256_one(hls::stream<iqout_t> &filtered, capcount_t capturesize, uint256_t *out) {
#pragma HLS INTERFACE axis register port=filtered depth=4096
#pragma HLS INTERFACE mode=m_axi depth=4096 max_write_burst_length=128 port=out offset=slave max_read_burst_length=1 num_read_outstanding=1 num_write_outstanding=8 max_widen_bitwidth=256  //num_read_outstanding=1 num_write_outstanding=1
#pragma HLS INTERFACE s_axilite port=out bundle=control
#pragma HLS INTERFACE s_axilite port=capturesize bundle=control
#pragma HLS INTERFACE s_axilite port=return bundle=control
#pragma HLS STABLE variable=capturesize
#pragma HLS STABLE variable=out

	iqout_t in;
	unsigned int _capturesize;

	sync: do {
#pragma HLS PIPELINE II=1
#pragma HLS LOOP_TRIPCOUNT min=1 max=255
		in = filtered.read();
	} while (!in.last);

	_capturesize = capturesize>>1;
	assert (_capturesize>0);

	write: for (unsigned int i=0; i<_capturesize; i++) {
#pragma HLS PIPELINE II=2
#pragma HLS LOOP_TRIPCOUNT min=1 max=67108864
		in = filtered.read();
		out[2*i]=in.data;
		in = filtered.read();
		out[2*i+1]=in.data;
	}


}

void write_axi256_rewind(hls::stream<iqout_t> &filtered, capcount_t capturesize, uint256_t *out) {
#pragma HLS INTERFACE axis register port=filtered depth=4096
#pragma HLS INTERFACE mode=m_axi depth=4096 max_write_burst_length=128 port=out offset=slave max_read_burst_length=1 num_read_outstanding=1 num_write_outstanding=8 max_widen_bitwidth=256  //num_read_outstanding=1 num_write_outstanding=1
#pragma HLS INTERFACE s_axilite port=out bundle=control
#pragma HLS INTERFACE s_axilite port=capturesize bundle=control
#pragma HLS INTERFACE s_axilite port=return bundle=control
#pragma HLS STABLE variable=capturesize
#pragma HLS STABLE variable=out

	iqout_t in;
	unsigned int _capturesize;

	sync: do {
#pragma HLS PIPELINE II=1 REWIND
#pragma HLS LOOP_TRIPCOUNT min=1 max=255
		in = filtered.read();
	} while (!in.last);

	_capturesize=capturesize>>7;
	assert (_capturesize>0);
	write: for (unsigned int i=0; i<_capturesize; i++) {
#pragma HLS LOOP_TRIPCOUNT min=1 max=1048576
		burst: for (int j = 0; j < 128; j++) {
			#pragma HLS PIPELINE REWIND
			iqout_t x;
			x=filtered.read();
			out[i*128+j] = x.data;
		}
	}

}


void write_axi256_dowhile(hls::stream<iqout_t> &filtered, capcount_t capturesize, uint256_t *out) {
#pragma HLS INTERFACE axis register port=filtered depth=4096
#pragma HLS INTERFACE mode=m_axi depth=4096 max_write_burst_length=128 port=out offset=slave max_read_burst_length=1 num_read_outstanding=1 num_write_outstanding=8 max_widen_bitwidth=256  //num_read_outstanding=1 num_write_outstanding=1
#pragma HLS INTERFACE s_axilite port=out bundle=control
#pragma HLS INTERFACE s_axilite port=capturesize bundle=control
#pragma HLS INTERFACE s_axilite port=return bundle=control
#pragma HLS STABLE variable=capturesize
#pragma HLS STABLE variable=out

	unsigned int _capturesize, i=0;
	bool sync=false;
	_capturesize=capturesize>>7;
	assert (_capturesize>0);

	write: do {
//#pragma HLS PIPELINE II=128
#pragma HLS LOOP_TRIPCOUNT min=1 max=1048576
		iqout_t x;
		if (!sync)
			x=filtered.read();
		if (sync){
			burst: for (int j = 0; j < 128; j++) {
				#pragma HLS PIPELINE REWIND
				out[i*128+j] = x.data;
				x=filtered.read();
			}
		}
		i=sync ? i+1:0;
		sync|=x.last;
	} while (i<_capturesize);

}


void getinstream(hls::stream<iqout_t >& in_stream, capcount_t capturesize, hls::stream<uint256_t> &out_stream){
#pragma HLS STABLE variable=capturesize
    iqout_t in;
    bool sync=false, last1, done=false;
    int _capturesize, count=0;
    _capturesize=capturesize,
    assert (_capturesize>127);
	sync: do {
#pragma HLS PIPELINE II=2
#pragma HLS LOOP_TRIPCOUNT min=1 max=67109120

		in = in_stream.read();
		last1=in.last;
		if (sync) {
			out_stream.write_nb(in.data);
		}

		in = in_stream.read();
		if ((sync|last1) && (count<_capturesize-1)) {
			out_stream.write_nb(in.data);
		}

		if (sync) {
			done=count>=_capturesize-2;
			count+=2;
		} else if (last1) {
			done=false;//count==1;
			count+=1;
		} else {
			done=false;
			count=0;
		}
		sync|=last1|in.last;

	} while (!done);

}


void s2mm_rewind(hls::stream<uint256_t> &in_stream, capcount_t capturesize, uint256_t  *out_memory){
#pragma HLS STABLE variable=capturesize
#pragma HLS STABLE variable=out_memory
	uint256_t* _out_memory;
	int _capturesize;
	_capturesize=capturesize>>7;
	_out_memory=out_memory;
	assert (_capturesize>0);
	write: for (unsigned int i=0; i<_capturesize; i++) {
#pragma HLS LOOP_TRIPCOUNT min=1 max=1048576
		burst: for (int j = 0; j < 128; j++) {
			#pragma HLS PIPELINE REWIND
			_out_memory[j] = in_stream.read();
		}
		_out_memory+=128;
	}
}


void s2mm(hls::stream<uint256_t> &in_stream, capcount_t capturesize, uint256_t  *out_memory){
//#pragma HLS STABLE variable=capturesize
//#pragma HLS STABLE variable=out_memory
	int _capturesize=capturesize>>7;
	assert (_capturesize>0);
	write: for (unsigned int i=0; i<_capturesize; i++) {
#pragma HLS LOOP_TRIPCOUNT min=1 max=1048576
		burst: for (int j = 0; j < 128; j++) {
			#pragma HLS PIPELINE
			out_memory[i*128+j] = in_stream.read();
		}
	}
}


//void s2mm_worestrict(hls::stream<uint256_t> &in_stream, capcount_t capturesize, uint256_t  *out_memory){
//	//This core does maximal bursts then one final oddball
//	int _capturesize=capturesize>>7;
//	int oddball = capturesize-(_capturesize<<7);
//	assert (_capturesize>1);
//	write: for (unsigned int i=0; i<_capturesize; i++) {
//		burst: for (int j = 0; j < 128; j++) {
//			#pragma HLS PIPELINE
//			out_memory[j] = in_stream.read();
//		}
//		out_memory+=128;
//	}
//	finalburst: for (int j = 0; j < oddball; j++) {
//		#pragma HLS PIPELINE
//		out_memory[j] = in_stream.read();
//	}
//}

//void write_axi256_dfsync(hls::stream<iqout_t> &filtered, capcount_t capturesize, uint256_t *out) {
//#pragma HLS INTERFACE axis register port=filtered depth=4096
//#pragma HLS INTERFACE mode=m_axi depth=4096 max_write_burst_length=128 port=out offset=slave max_read_burst_length=1 num_read_outstanding=1 num_write_outstanding=8 max_widen_bitwidth=256  //num_read_outstanding=1 num_write_outstanding=1
//#pragma HLS INTERFACE s_axilite port=out bundle=control
//#pragma HLS INTERFACE s_axilite port=capturesize bundle=control
//#pragma HLS INTERFACE s_axilite port=return bundle=control
////#pragma HLS STABLE variable=capturesize
////#pragma HLS STABLE variable=out
//#pragma HLS DATAFLOW
//
//  hls::stream<uint256_t> buf;
//#pragma HLS STREAM type=fifo variable=buf
//
//  getinstream(filtered, capturesize, buf);
//  s2mm(buf, capturesize, out);
//}

void write_axi256_dfsync_rewind(hls::stream<iqout_t> &filtered, capcount_t capturesize, uint256_t *out) {
#pragma HLS INTERFACE axis register port=filtered depth=4096
#pragma HLS INTERFACE mode=m_axi depth=4096 latency=16 max_read_burst_length=1 max_widen_bitwidth=256 max_write_burst_length=128 num_read_outstanding=1 num_write_outstanding=8 port=out  //num_read_outstanding=1 num_write_outstanding=1
#pragma HLS INTERFACE s_axilite port=out bundle=control
#pragma HLS INTERFACE s_axilite port=capturesize bundle=control
#pragma HLS INTERFACE s_axilite port=return bundle=control
#pragma HLS STABLE variable=capturesize
#pragma HLS STABLE variable=out
#pragma HLS DATAFLOW

  hls::stream<uint256_t> buf;
#pragma HLS STREAM type=fifo variable=buf depth=4

  getinstream(filtered, capturesize, buf);
  s2mm_rewind(buf, capturesize, out);
}




//
//
//#include "hls_burst_maxi.h"
//
//void write(hls::stream<uint256_t> &data, capcount_t capturesize, hls::burst_maxi<uint256_t> out) {
//
//	int size = capturesize>>7;
//	assert(size>1);
//
//	for (int i = 0; i < size; i++) {
//#pragma HLS PIPELINE II=128
//		out.write_request(128*i, 128);
//		for (int j = 0; j < 128; j++) {
//			#pragma HLS PIPELINE II=1 rewind
//			out.write(data.read());
//		}
//		out.write_response();
//	}
//}
//
//void write_axi256_manb(hls::stream<iqout_t> &filtered, capcount_t capturesize, hls::burst_maxi<uint256_t> out) {
//#pragma HLS INTERFACE axis register port=filtered depth=2048
//#pragma HLS INTERFACE mode=m_axi depth=2048 max_write_burst_length=128 port=out offset=slave max_read_burst_length=1 num_read_outstanding=1 num_write_outstanding=8 max_widen_bitwidth=256  //num_read_outstanding=1 num_write_outstanding=1
//#pragma HLS INTERFACE s_axilite port=out bundle=control
//#pragma HLS INTERFACE s_axilite port=capturesize bundle=control
//#pragma HLS INTERFACE s_axilite port=return bundle=control
//#pragma HLS STABLE variable=capturesize
////#pragma HLS STABLE variable=out
//#pragma HLS DATAFLOW
//
//hls::stream<uint256_t> buf;
//#pragma HLS STREAM type=fifo variable=buf
//
//  getinstream(filtered, capturesize, buf);//, count);
//  write(buf, capturesize, out);
//
//}




//void readinput(hls::stream<iqout_t> &in, const capcount_t capturesize, hls::stream<uint256_t> &out) {
//#pragma HLS STABLE variable=capturesize
//	unsigned int _capturesize;
//	_capturesize=capturesize>>1;
////	cout<<"Cap size: "<<capturesize<<" "<<_capturesize<<endl;
//	assert (_capturesize>0);
//	readloop: for(int i=0;i<_capturesize;i++) {
//#pragma HLS LOOP_TRIPCOUNT min=1 max=67108864
//#pragma HLS PIPELINE II=2
//		iqout_t val;
//		val=in.read();
//		out.write(val.data);
//		val=in.read();
//		out.write(val.data);
//	}
//}

void readinput(hls::stream<iqout_t> &in, const capcount_t capturesize, hls::stream<uint256_t> &out) {
#pragma HLS STABLE variable=capturesize
	unsigned int _capturesize;
	_capturesize=capturesize>>7;
	assert (_capturesize>0);
	read: for (unsigned int i=0; i<_capturesize; i++) {
#pragma HLS LOOP_TRIPCOUNT min=1 max=1048576
		inner: for (int j = 0; j < 128; j++) {
#pragma HLS PIPELINE REWIND
			iqout_t val;
			val=in.read();
			out.write(val.data);
		}
	}
}


void write_axi256(hls::stream<iqout_t> &stream, capcount_t capturesize, uint256_t *iqout) {
#pragma HLS DATAFLOW
#pragma HLS INTERFACE axis register port=stream depth=2048
#pragma HLS INTERFACE m_axi port=iqout latency=0 depth=2048 max_read_burst_length=2 max_write_burst_length=128 num_read_outstanding=1 num_write_outstanding=4
#pragma HLS INTERFACE s_axilite port=iqout bundle=control
#pragma HLS INTERFACE s_axilite port=capturesize bundle=control
#pragma HLS INTERFACE s_axilite port=return bundle=control
#pragma HLS STABLE variable=capturesize
#pragma HLS STABLE variable=iqout

	hls::stream<uint256_t> iq_in("fetch");
#pragma HLS STREAM variable=iq_in depth=8

	readinput(stream, capturesize, iq_in);
	s2mm_rewind(iq_in, capturesize, iqout);

}


void dumbread(hls::stream<iqout_t> &in, const capcount_t capturesize, hls::stream<uint256_t> &out) {
//#pragma HLS STABLE variable=capturesize
	capcount_t _capturesize;
	_capturesize=capturesize;//>>1;
	//assert (_capturesize>0);
	read: for (unsigned int i=0; i<_capturesize; i+=2) {
#pragma HLS LOOP_TRIPCOUNT min=64 max=67108864
#pragma HLS PIPELINE II=2
		iqout_t val;
		val=in.read();
		out.write(val.data);
		val=in.read();
		out.write(val.data);
	}
}
void dumbwrite(hls::stream<uint256_t> &in_stream, const capcount_t capturesize, uint256_t  *out_memory){
//#pragma HLS STABLE variable=capturesize
//#pragma HLS STABLE variable=out_memory
	capcount_t _capturesize=capturesize;//>>1;
	uint256_t* out_addr=out_memory;
	//assert (_capturesize>0);
	write: for (unsigned int i=0; i<_capturesize; i+=2) {
#pragma HLS LOOP_TRIPCOUNT min=64 max=67108864
#pragma HLS PIPELINE II=2
		out_addr[i] = in_stream.read();
		out_addr[i+1] = in_stream.read();
	}
}


void write_axi256_dumb(hls::stream<iqout_t> &stream, capcount_t capturesize, uint256_t *iqout) {
#pragma HLS DATAFLOW
#pragma HLS INTERFACE axis register port=stream depth=2048
#pragma HLS INTERFACE m_axi port=iqout latency=0 depth=2048 max_read_burst_length=2 max_write_burst_length=128 num_read_outstanding=1 num_write_outstanding=2
#pragma HLS INTERFACE s_axilite port=iqout bundle=control
#pragma HLS INTERFACE s_axilite port=capturesize bundle=control
#pragma HLS INTERFACE s_axilite port=return bundle=control
#pragma HLS STABLE variable=capturesize
#pragma HLS STABLE variable=iqout

	hls::stream<uint256_t> iq_in("fetch");
#pragma HLS STREAM variable=iq_in depth=8

	dumbread(stream, capturesize, iq_in);
	dumbwrite(iq_in, capturesize, iqout);

}
