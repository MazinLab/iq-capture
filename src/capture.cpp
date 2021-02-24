/* The DDR4 core can capture up to 2667MT/S on a 64 bit bus. I think this translates
 * to ~21336 MBPS
 * ADC stream is 512*32B ~16.3GB/s (8 IQ 2 bytes each @ 512MHz)
	- Could pack to 512*24B 12.2GB/s but unpacking in software would be a bear)
 * OPFB stream is 512M*64B ~ 32.7GB/s  (16 IQ 2 bytes each @ 512MHz)
 * Res Streams (selected bins and DDSed) are 512M*32B ~16.3GB/s (8 IQ 2 bytes each @ 512MHz)
 * LP Res Stream is 256M*32B ~8.2GB/s (8 IQ 2 bytes each @ 256MHz)
 * Phase Stream is 512M*8B ~4 GB/s (4 phase 2 bytes @ 512MHz)
*/
#include "capture.hpp"
#ifndef __SYNTHESIS__
#include <bitset>
#include <iostream>
using namespace std;
#endif
#include <string.h>
#include "ap_int.h"

#define SAMPLES 513

#define BURST_LEN 128

template <class Taxis, class T>
void fetch_data(hls::stream<Taxis> &resstream, const uint256_t keep, hls::stream<T> &fetched, hls::stream<bool> &fetched2, hls::stream<bool> &done) {
	bool aligned=false;

	read: while (true) {
#pragma HLS PIPELINE II=1
		if(resstream.empty()) {
			done.write(true);
			break;
		}
		Taxis resin=resstream.read();
		if (resin.user==0 || aligned) {
			fetched.write(resin.data);
			fetched2.write(keep[resin.user]);
			done.write(false);
			aligned=true;
		}
	}
}

template <class T>
void capture_data(hls::stream<T> &fetched, hls::stream<bool> &fetched2, hls::stream<bool> &done, hls::stream<T> &forwarded, hls::stream<capcount_t> &captured, hls::stream<bool> &done2){
	capcount_t _captured=0;
	forward: while(!done.read()){
#pragma HLS PIPELINE II=1
		T out=fetched.read();
		bool use=fetched2.read();
		if (use){
			forwarded.write(out);
			captured.write(_captured);
			done2.write(false);
			_captured++;
		}
	}
	done2.write(true);
}

template <class T>
void done_detect(hls::stream<T> &forwarded, hls::stream<capcount_t> &captured, hls::stream<bool> &donein, capcount_t const capturesize, hls::stream<T> &toout, hls::stream<bool> &done){
	bool _done=false;
	capcount_t _captured=0;
	forward: while(!donein.read()){
#pragma HLS PIPELINE II=1
		uint256_t out = forwarded.read();
		capcount_t _captured=captured.read();
		if (!_done) {
			_done = _captured==capturesize-1;
			toout.write(out);
			done.write(_done);
		}
	}
	if (!_done) {
		_done = true;
		toout.write(0);
		done.write(true);
	}
}

template <class T>
void put_data(hls::stream<T> &toout, hls::stream<bool> &done, T *iqout){
	T* out_addr=(T*) iqout;

	put: while(true) {
		bool _done=false;
//		T tmp[128];
		write: for(int i=0;i<BURST_LEN;i++) {
#pragma HLS PIPELINE II=1
			T out;
			if (_done) {
				out=0;
			} else {
				out = toout.read();
				_done = done.read();
			}
//			tmp[i]=out;
			*(out_addr+i)=out;
		}
//		memcpy(out_addr, tmp,  128*32);

		out_addr+=BURST_LEN;
		if(_done) break;
	}
}

//template <class Taxis, class T>
//void capture(hls::stream<Taxis> &stream, uint256_t keep, capcount_t capturesize, T *out) {
//#pragma HLS INLINE
//	hls::stream<T> fetched("fetch"), forwarded("fwd"), toout("toout");
//	hls::stream<bool> fetched2("fetch2"), done("done"), done2("done2"), last("last");
//	hls::stream<capcount_t> captured("cap");
//#pragma HLS STREAM variable=fetched depth=3
//#pragma HLS STREAM variable=forwarded depth=3
//#pragma HLS STREAM variable=fetched2 depth=3
//#pragma HLS STREAM variable=done depth=3
//#pragma HLS STREAM variable=done2 depth=3
//#pragma HLS STREAM variable=captured depth=3
//
//#pragma HLS STREAM variable=last depth=512
//#pragma HLS STREAM variable=tout depth=512
//
//	fetch_data<Taxis,T>(stream, keep, fetched, fetched2, done);
//	capture_data<T>(fetched, fetched2, done, forwarded, captured, done2);
//	done_detect<T>(forwarded, captured, done2, capturesize, toout, last);
//	put_data<T>(toout, last, out);
//}

void iq_capture(hls::stream<resstream_t> &resstream, uint256_t keep, capcount_t capturesize, uint256_t *iqout) {
#pragma HLS DATAFLOW
#pragma HLS INTERFACE axis register port=resstream depth=2048
#pragma HLS INTERFACE m_axi port=iqout offset=slave depth=1000 max_read_burst_length=2 max_write_burst_length=128 num_read_outstanding=1
#pragma HLS INTERFACE s_axilite port=iqout bundle=control
#pragma HLS INTERFACE s_axilite port=keep bundle=control
#pragma HLS INTERFACE s_axilite port=capturesize bundle=control
#pragma HLS INTERFACE s_axilite port=return bundle=control

	hls::stream<uint256_t> fetched("fetch"), forwarded("fwd"), toout("toout");
	hls::stream<bool> fetched2("fetch2"), done("done"), done2("done2"), last("last");
	hls::stream<capcount_t> captured("cap");
#pragma HLS STREAM variable=fetched depth=3
#pragma HLS STREAM variable=forwarded depth=3
#pragma HLS STREAM variable=fetched2 depth=3
#pragma HLS STREAM variable=done depth=3
#pragma HLS STREAM variable=done2 depth=3
#pragma HLS STREAM variable=captured depth=3

#pragma HLS STREAM variable=last depth=512
#pragma HLS STREAM variable=tout depth=512

	fetch_data<resstream_t, uint256_t>(resstream, keep, fetched, fetched2, done);
	capture_data<uint256_t>(fetched, fetched2, done, forwarded, captured, done2);
	done_detect<uint256_t>(forwarded, captured, done2, capturesize, toout, last);
	put_data<uint256_t>(toout, last, iqout);
}


//void phase_capture(phasestream_t &stream, uint256_t keep, capcount_t capturesize, phaseout_t *out) {
//#pragma HLS DATAFLOW
//#pragma HLS INTERFACE axis register port=stream depth=2048
//#pragma HLS INTERFACE m_axi port=out offset=slave depth=1000 max_read_burst_length=2 max_write_burst_length=64 num_read_outstanding=1 num_write_outstanding=4 latency=128
//#pragma HLS INTERFACE s_axilite port=out bundle=control
//#pragma HLS INTERFACE s_axilite port=keep bundle=control
//#pragma HLS INTERFACE s_axilite port=capturesize bundle=control
//#pragma HLS INTERFACE s_axilite port=return bundle=control
//
//	hls::stream<phaseout_t> fetched("fetch"), forwarded("fwd"), toout("toout");
//	hls::stream<bool> fetched2("fetch2"), done("done"), done2("done2"), last("last");
//	hls::stream<capcount_t> captured("cap");
//#pragma HLS STREAM variable=fetched depth=3
//#pragma HLS STREAM variable=forwarded depth=3
//#pragma HLS STREAM variable=fetched2 depth=3
//#pragma HLS STREAM variable=done depth=3
//#pragma HLS STREAM variable=done2 depth=3
//#pragma HLS STREAM variable=captured depth=3
//
//#pragma HLS STREAM variable=last depth=512
//#pragma HLS STREAM variable=tout depth=512
//
//	fetch_data<phasestream_t, phaseout_t>(stream, keep, fetched, fetched2, done);
//	capture_data<phaseout_t>(fetched, fetched2, done, forwarded, captured, done2);
//	done_detect<phaseout_t>(forwarded, captured, done2, capturesize, toout, last);
//	put_data<phaseout_t>(toout, last, out);
//}

uint256_t pair_iq(const uint128_t i_in, const uint128_t q_in) {
#pragma HLS PIPELINE II=1
	uint256_t tmp;
	bundle: for (int i=0;i<N_IQ;i++){
		tmp.range(32*i+15, 32*i)=i_in.range(16*i+15, 16*i);
		tmp.range(32*i+31, 32*i+16)=q_in.range(16*i+15, 16*i);
	}
	return tmp;
}

void adc_capture(hls::stream<uint128_t> &istream, hls::stream<uint128_t> &qstream, capcount_t capturesize, uint256_t *iqout) {
#pragma HLS INTERFACE axis register port=istream depth=2048
#pragma HLS INTERFACE axis register port=qstream depth=2048
#pragma HLS INTERFACE m_axi port=iqout offset=slave depth=1000 max_read_burst_length=2 max_write_burst_length=128 num_read_outstanding=1
#pragma HLS INTERFACE s_axilite port=iqout bundle=control
#pragma HLS INTERFACE s_axilite port=capturesize bundle=control
#pragma HLS INTERFACE s_axilite port=return bundle=control

	uint256_t* out_addr=iqout;
	capcount_t _capturesize=capturesize;
	out: for (int i=0;i< _capturesize; i++) {
#pragma HLS PIPELINE II=1
		uint128_t i_in = istream.read();
		uint128_t q_in = qstream.read();
		out_addr[i]=pair_iq(i_in, q_in);
	}

}
