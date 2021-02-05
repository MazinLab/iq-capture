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

//void phase_capture(phasestream_t &phasestream, uint256_t keep, capcount_t capturesize, const streamid_t streamid, bool configure, phaseout_t &phaseout) {
//#pragma HLS INTERFACE ap_ctrl_none port=return
//#pragma HLS PIPELINE II=1
//#pragma HLS INTERFACE axis register port=phasestream
//#pragma HLS INTERFACE axis register port=phaseout
//#pragma HLS INTERFACE s_axilite port=keep bundle=control// clock=ctrl_clk
//#pragma HLS INTERFACE s_axilite port=capturesize bundle=control
//#pragma HLS INTERFACE ap_stable port=streamid
//#pragma HLS INTERFACE s_axilite port=configure bundle=control
//
//	static capcount_t _remaining=0;
//	static bool _aligned=false;
//	phasestream_t phasein;
//	phaseout_t phasetmp;
//
//	phasein=phasestream;
//
//	setdata: for (int i=0;i<N_PHASE;i++) phasetmp.data[i]=phasein.data[i];
//	phasetmp.dest=streamid;
//	phasetmp.last=_remaining==1;
//
//	if (configure) {
//		_remaining=capturesize;
//		_aligned=false;
//		#ifndef __SYNTHESIS__
//			cout<<"Configured core"<<endl;
//		#endif
//	} else {
//
//		_aligned=_aligned || phasein.user==0;
//
//		#ifndef __SYNTHESIS__
//			cout<<"Capture "<<capturesize<<" groups from stream "<<streamid.to_uint()<<" user="<<phasein.user.to_uint()<<endl;
//			cout<<"Aligned "<<_aligned<<". Remaining "<<_remaining<<" Keep this: "<<keep[phasein.user].to_bool()<<endl;
//		#endif
//
//		if (_remaining>0 && _aligned && keep[phasein.user]) {
//			#ifndef __SYNTHESIS__
//				cout<<"Sending data";
//				if (phasetmp.last) cout<<" with TLAST";
//				cout<<endl;
//			#endif
//
//			phaseout=phasetmp;
//			_remaining--;
//		}
//	}
//}
#define SAMPLES 513

#define BURST_LEN 128

void fetch_data(hls::stream<resstream_t> &resstream, const uint256_t keep, hls::stream<uint256_t> &fetched, hls::stream<bool> &fetched2, hls::stream<bool> &done) {
	bool aligned=false;

	read: while (true) {
#pragma HLS PIPELINE II=1
		if(resstream.empty()) {
			done.write(true);
			break;
		}
		resstream_t resin=resstream.read();
		if (resin.user==0 || aligned) {
			fetched.write(resin.data);
			fetched2.write(keep[resin.user]);
			done.write(false);
			aligned=true;
		}

	}

}


//void capture_data(hls::stream<uint256_t> &fetched, hls::stream<bool> &fetched2, const capcount_t capturesize, hls::stream<uint256_t> &forwarded){
//	capcount_t captured=0;
//	bool more=true;
//	forward: while(!fetched.empty()){
//#pragma HLS PIPELINE II=1
//		uint256_t out=fetched.read();
//		bool use=fetched2.read();
//		if (more && use){
//			forwarded.write(out);
//			captured++;
//		}
//		more=captured<capturesize;
//	}
//
//}

void capture_data2(hls::stream<uint256_t> &fetched, hls::stream<bool> &fetched2, hls::stream<bool> &done, hls::stream<uint256_t> &forwarded, hls::stream<capcount_t> &captured, hls::stream<bool> &done2){
	capcount_t _captured=0;
	forward: while(!done.read()){
#pragma HLS PIPELINE II=1
		uint256_t out=fetched.read();
		bool use=fetched2.read();
		if (use){
			forwarded.write(out);
			captured.write(_captured);
			done2.write(false);
//			cout<<"cap:"<<_captured<<" "<<out<<endl;
			_captured++;

		}
	}
	done2.write(true);

}





void done_detect(hls::stream<uint256_t> &forwarded, hls::stream<capcount_t> &captured, hls::stream<bool> &donein, capcount_t const capturesize, hls::stream<uint256_t> &toout, hls::stream<bool> &done){
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

//		cout<<"done:"<<_done<<" "<<out<<endl;
	}

}

void put_data(hls::stream<uint256_t> &toout, hls::stream<bool> &done, volatile uint256_t *iqout){
//140 clocks not reading
	uint256_t burstbuff[BURST_LEN];
	uint256_t* out_addr=(uint256_t*) iqout;
	put: while(true) {
		ap_uint<8> i=0;
		bool _done=false;

		loadbuff: while (true) {
#pragma HLS PIPELINE II=1
			_done = done.read();
			burstbuff[i]=toout.read();
			bool full= i==BURST_LEN-1;
			i++;
			if (_done || full ) break;
		}

		memcpy(out_addr, burstbuff , i*32);
		out_addr += BURST_LEN;
		if (_done) break;
	}
}

void put_data2(hls::stream<uint256_t> &toout, hls::stream<bool> &done, volatile uint256_t *iqout){
	uint256_t burstbuff[BURST_LEN];
	uint256_t* out_addr=(uint256_t*) iqout;
	bool _done=false, loading=true;
	ap_uint<8> i=0;
	put: while(true) {

		if (loading){
			_done = done.read();
			burstbuff[i]=toout.read();
			loading = i==BURST_LEN-1;
			i++;
		} else {
			memcpy(out_addr, burstbuff , i*32);
			out_addr += BURST_LEN;
			if (_done) break;
			loading=true;
		}

	}
}
void put_data3(hls::stream<uint256_t> &toout, hls::stream<bool> &done, volatile uint256_t *iqout){
//13 clocks down time
	uint256_t* out_addr=(uint256_t*) iqout;
	put: while(true) {
		bool _done=false;

		write: for(int i=0;i<BURST_LEN;i++) {
#pragma HLS PIPELINE II=1
			uint256_t out;
			if (_done) {
				out=0;
			} else {
				out = toout.read();
				_done = done.read();
			}
			*(out_addr+i)=out;
		}
		out_addr+=BURST_LEN;
		if (_done) break;
	}
}


void iq_capture(hls::stream<resstream_t> &resstream, uint256_t keep, capcount_t capturesize, volatile uint256_t *iqout) {
#pragma HLS INTERFACE s_axilite port=return bundle=control
//#pragma HLS INTERFACE ap_ctrl_none port=return  // not compatible with m_axi output approach
//#pragma HLS PIPELINE II=1
#pragma HLS DATAFLOW
#pragma HLS INTERFACE axis register port=resstream depth=2048
#pragma HLS INTERFACE m_axi port=iqout depth=1000 max_write_burst_length=128 num_write_outstanding=1 num_read_outstanding=1 max_read_burst_length=2 offset=slave latency=15
#pragma HLS INTERFACE s_axilite port=iqout bundle=control
#pragma HLS INTERFACE s_axilite port=keep bundle=control
#pragma HLS INTERFACE s_axilite port=capturesize bundle=control

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
	//	fetch_data2(resstream, keep, capturesize, forwarded);

	fetch_data(resstream, keep, fetched, fetched2, done);
//	capture_data(fetched, fetched2, capturesize, forwarded);
//	put_data(forwarded, iqout);
	capture_data2(fetched, fetched2, done, forwarded, captured, done2);
	done_detect(forwarded, captured, done2, capturesize, toout, last);
	put_data3(toout, last, iqout);
}


//void adc_capture(adcstream_t &istream, adcstream_t &qstream, capcount_t capturesize,  bool configure, iqout_t &adcout) {
//#pragma HLS INTERFACE ap_ctrl_none port=return
//#pragma HLS PIPELINE II=1
//#pragma HLS INTERFACE axis register port=istream
//#pragma HLS INTERFACE axis register port=qstream
//#pragma HLS INTERFACE axis register port=adcout
//#pragma HLS INTERFACE s_axilite port=capturesize bundle=control
////#pragma HLS INTERFACE s_axilite port=configure bundle=control
//#pragma HLS INTERFACE ap_none port=configure
//
//
//
//	static capcount_t _remaining;
//	adcstream_t iin, qin;
//	iqout_t iqtmp;
//
//	iin=istream;
//	qin=qstream;
//
//	for (int i=0;i<N_IQ;i++){
//		iqtmp.data[2*i]=iin.data[i];
//		iqtmp.data[2*i+1]=qin.data[i];
//	}
//	iqtmp.dest=0;
//	iqtmp.last=_remaining==1;
//
//
//	if (configure) {
//		_remaining=capturesize;
//		#ifndef __SYNTHESIS__
//			cout<<"Configured core"<<endl;
//		#endif
//	} else {
//
//		#ifndef __SYNTHESIS__
//			cout<<"Capture "<<capturesize<<" groups from stream 0. Remaining "<<_remaining<<endl;
//		#endif
//
//		if (_remaining>0) {
//			#ifndef __SYNTHESIS__
//				cout<<"Sending data";
//				if (iqtmp.last) cout<<" with TLAST";
//				cout<<endl;
//			#endif
//
//			adcout=iqtmp;
//			_remaining--;
//		}
//	}
//}
