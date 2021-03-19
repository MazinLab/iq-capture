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
const unsigned char burst_lev=BURST_LEN;

template <class Taxis, class T>
void fetch_data(hls::stream<Taxis> &resstream, const totalcapcount_t capturesize, const keep_t keep, hls::stream<T> &fetched, hls::stream<bool> &fetched_keep) {

	totalcapcount_t _capturesize=capturesize;
	keep_t _keep=keep;

	read: for(int i=0;i<_capturesize;i++) {
#pragma HLS PIPELINE II=1
		Taxis resin=resstream.read();
		fetched.write(resin.data);
		fetched_keep.write(_keep[resin.user]);
	}
}

template <class T>
void capture_data(hls::stream<T> &fetched, hls::stream<bool> &fetched_keep, const totalcapcount_t capturesize, hls::stream<T> &forwarded){
	totalcapcount_t _capturesize=capturesize;
	forward: for(int i=0;i<_capturesize;i++) {
#pragma HLS PIPELINE II=1
		T out=fetched.read();
		bool use=fetched_keep.read();
		if (use){
			forwarded.write(out);
		}
	}
}



template <class T>
void put_data_csize(hls::stream<T> &toout, const capcount_t capturesize, T *iqout){
	T* out_addr=(T*) iqout;
	capcount_t _capturesize=capturesize;
	write: for(int i=0;i<_capturesize;i++) {
#pragma HLS PIPELINE II=1
		out_addr[i]=toout.read();
	}
}


uint256_t pair_iq(const uint128_t i_in, const uint128_t q_in) {
#pragma HLS PIPELINE II=1
	uint256_t tmp;
	bundle: for (int i=0;i<N_IQ;i++){
		tmp.range(32*i+15, 32*i)=i_in.range(16*i+15, 16*i);
		tmp.range(32*i+31, 32*i+16)=q_in.range(16*i+15, 16*i);
	}
	return tmp;
}



void pair_iq_df(hls::stream<uint128_t> &i_in, hls::stream<uint128_t> &q_in, const capcount_t capturesize, hls::stream<uint256_t> &out) {

	capcount_t _capturesize= capturesize;
	read: for(int i=0;i<_capturesize;i++) {
#pragma HLS PIPELINE II=1
		out.write(pair_iq(i_in.read(), q_in.read()));
	}
}


void pair_iq_df_flat(hls::stream<uint128_t> &i_in, hls::stream<uint128_t> &q_in, const capcount_t capturesize, hls::stream<uint256_t> &out) {

	capcount_t _capturesize= capturesize;
	read: for(int i=0;i<_capturesize;i++) {
#pragma HLS PIPELINE II=1

		uint256_t dataout, paired;
		uint128_t ival=i_in.read();
		uint128_t qval=q_in.read();

		paired.range(127,0) = ival.range();
		paired.range(255,128) = qval.range();

		bundle: for (int i=0;i<N_IQ;i++){
			dataout.range(32*i+15, 32*i)=paired.range(16*i+15, 16*i);
			dataout.range(32*i+31, 32*i+16)=paired.range(16*i+15+128, 16*i+128);
		}

		out.write(dataout);
	}
}


//for 3func adc
//void read_df(hls::stream<uint128_t> &i_in, hls::stream<uint128_t> &q_in, const capcount_t capturesize, hls::stream<uint256_t> &out) {
//
//	capcount_t _capturesize= capturesize;
//	read: for(int i=0;i<_capturesize;i++) {
//#pragma HLS PIPELINE II=1
//		uint256_t dataout;
//		dataout.range(127,0) = i_in.read();
//		dataout.range(255,128) = q_in.read();
//		out.write(dataout);
//	}
//}
//
//void pair_df(hls::stream<uint256_t> &in, const capcount_t capturesize, hls::stream<uint256_t> &out) {
//
//	capcount_t _capturesize= capturesize;
//	read: for(int i=0;i<_capturesize;i++) {
//#pragma HLS PIPELINE II=1
//		uint256_t datin=in.read(), datout;
//		bundle: for (int i=0;i<N_IQ;i++){
//			datout.range(32*i+15, 32*i)=datin.range(16*i+15, 16*i);
//			datout.range(32*i+31, 32*i+16)=datin.range(16*i+15+128, 16*i);
//		}
//		out.write(datout);
//	}
//}


void adc_capture(hls::stream<uint128_t> &istream, hls::stream<uint128_t> &qstream,
		capcount_t capturesize, uint256_t *iqout) {
#pragma HLS DATAFLOW
#pragma HLS INTERFACE axis register port=istream depth=2048
#pragma HLS INTERFACE axis register port=qstream depth=2048
#pragma HLS INTERFACE m_axi port=iqout offset=slave depth=2048 max_read_burst_length=2 max_write_burst_length=128 num_read_outstanding=1 num_write_outstanding=2
#pragma HLS INTERFACE s_axilite port=iqout bundle=control
#pragma HLS INTERFACE s_axilite port=capturesize bundle=control
#pragma HLS INTERFACE s_axilite port=return bundle=control

	hls::stream<uint256_t> iq_in("fetch");
#pragma HLS STREAM variable=iq_in depth=4

	pair_iq_df_flat(istream, qstream, capturesize, iq_in);
	put_data_csize<uint256_t>(iq_in, capturesize, iqout);

}


//total_capturesize must be the number of samples to ingest to capture capturesize samples
//	given keep. bitsum(keep) uint256_t are captured per group of 256 inbound samples
//total_capturesize=(256-bitsum(keep)+1)*capturesize
void iq_capture(hls::stream<resstream_t> &resstream, keep_t keep, totalcapcount_t total_capturesize,
				capcount_t capturesize, uint256_t *iqout) {
#pragma HLS DATAFLOW
#pragma HLS INTERFACE axis register port=resstream depth=2048
#pragma HLS INTERFACE m_axi port=iqout offset=slave depth=2048 max_read_burst_length=2 max_write_burst_length=128 num_read_outstanding=1 num_write_outstanding=4
#pragma HLS INTERFACE s_axilite port=iqout bundle=control
#pragma HLS INTERFACE s_axilite port=keep bundle=control
#pragma HLS INTERFACE s_axilite port=capturesize bundle=control
#pragma HLS INTERFACE s_axilite port=total_capturesize bundle=control
#pragma HLS INTERFACE s_axilite port=return bundle=control

	hls::stream<uint256_t> fetched("fetch"), toout("toout");
	hls::stream<bool> fetched_keep("fetch2");
#pragma HLS STREAM variable=fetched_keep depth=2 dim=1


	fetch_data<resstream_t, uint256_t>(resstream, total_capturesize, keep, fetched, fetched_keep);
	capture_data<uint256_t>(fetched, fetched_keep, total_capturesize, toout);
	put_data_csize<uint256_t>(toout, capturesize, iqout);
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
