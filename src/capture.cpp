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


void phase_capture(phasestream_t &phasestream, uint256_t keep, capcount_t capturesize, const streamid_t streamid, bool configure, phaseout_t &phaseout) {
#pragma HLS INTERFACE ap_ctrl_none port=return
#pragma HLS PIPELINE II=1
#pragma HLS INTERFACE axis register port=phasestream
#pragma HLS INTERFACE axis register port=phaseout
#pragma HLS INTERFACE s_axilite port=keep bundle=control// clock=ctrl_clk
#pragma HLS INTERFACE s_axilite port=capturesize bundle=control
#pragma HLS INTERFACE ap_stable port=streamid
#pragma HLS INTERFACE s_axilite port=configure bundle=control

	static capcount_t _remaining=0;
	static bool _aligned=false;
	phasestream_t phasein;
	phaseout_t phasetmp;

	phasein=phasestream;

	setdata: for (int i=0;i<N_PHASE;i++) phasetmp.data[i]=phasein.data[i];
	phasetmp.dest=streamid;
	phasetmp.last=_remaining==1;

	if (configure) {
		_remaining=capturesize;
		_aligned=false;
		#ifndef __SYNTHESIS__
			cout<<"Configured core"<<endl;
		#endif
	} else {

		_aligned=_aligned || phasein.user==0;

		#ifndef __SYNTHESIS__
			cout<<"Capture "<<capturesize<<" groups from stream "<<streamid.to_uint()<<" user="<<phasein.user.to_uint()<<endl;
			cout<<"Aligned "<<_aligned<<". Remaining "<<_remaining<<" Keep this: "<<keep[phasein.user].to_bool()<<endl;
		#endif

		if (_remaining>0 && _aligned && keep[phasein.user]) {
			#ifndef __SYNTHESIS__
				cout<<"Sending data";
				if (phasetmp.last) cout<<" with TLAST";
				cout<<endl;
			#endif

			phaseout=phasetmp;
			_remaining--;
		}
	}
}



void iq_capture(resstream_t &resstream, uint256_t keep, capcount_t capturesize, const streamid_t streamid, bool configure, iqout_t &iqout) {
#pragma HLS INTERFACE ap_ctrl_none port=return
//#pragma HLS INTERFACE s_axilite port=return bundle=control
#pragma HLS PIPELINE II=1
#pragma HLS INTERFACE axis register port=resstream
#pragma HLS INTERFACE axis register port=iqout
#pragma HLS INTERFACE s_axilite port=keep bundle=control
#pragma HLS INTERFACE s_axilite port=capturesize bundle=control
#pragma HLS INTERFACE ap_stable port=streamid
#pragma HLS INTERFACE s_axilite port=configure bundle=control


	static capcount_t _remaining=0;
	static bool _aligned=false;
	resstream_t resin;
	iqout_t iqtmp;

	resin=resstream;

	setdata: for (int i=0;i<N_IQ*2;i++) iqtmp.data[i]=resin.data[i];
	iqtmp.dest=streamid;
	iqtmp.last=_remaining==1;

	if (configure) {
		_remaining=capturesize;
		_aligned=false;
		#ifndef __SYNTHESIS__
			cout<<"Configured core"<<endl;
		#endif
	} else {

		_aligned=_aligned || resin.user==0;

		#ifndef __SYNTHESIS__
			cout<<"Capture "<<capturesize<<" groups from stream "<<streamid.to_uint()<<" user="<<resin.user.to_uint()<<endl;
			cout<<"Aligned "<<_aligned<<". Remaining "<<_remaining<<" Keep this: "<<keep[resin.user].to_bool()<<endl;
		#endif

		if (_remaining>0 && _aligned && keep[resin.user]) {
			#ifndef __SYNTHESIS__
				cout<<"Sending data";
				if (iqtmp.last) cout<<" with TLAST";
				cout<<endl;
			#endif

			iqout=iqtmp;
			_remaining=_remaining-1;
		}
	}

}

void adc_capture(adcstream_t &istream, adcstream_t &qstream, capcount_t capturesize,  bool configure, iqout_t &adcout) {
#pragma HLS INTERFACE ap_ctrl_none port=return
#pragma HLS PIPELINE II=1
#pragma HLS INTERFACE axis register port=istream
#pragma HLS INTERFACE axis register port=qstream
#pragma HLS INTERFACE axis register port=adcout
#pragma HLS DATA_PACK variable=istream
#pragma HLS DATA_PACK variable=qstream
#pragma HLS INTERFACE s_axilite port=capturesize bundle=control //clock=control_clk
#pragma HLS INTERFACE s_axilite port=configure bundle=control //clock=control_clk


	static capcount_t _remaining;
	adcstream_t iin, qin;
	iqout_t iqtmp;

	iin=istream;
	qin=qstream;

	for (int i=0;i<N_IQ;i++){
		iqtmp.data[2*i]=iin.data[i];
		iqtmp.data[2*i+1]=qin.data[i];
	}
	iqtmp.dest=0;
	iqtmp.last=_remaining==1;


	if (configure) {
		_remaining=capturesize;
		#ifndef __SYNTHESIS__
			cout<<"Configured core"<<endl;
		#endif
	} else {

		#ifndef __SYNTHESIS__
			cout<<"Capture "<<capturesize<<" groups from stream 0. Remaining "<<_remaining<<endl;
		#endif

		if (_remaining>0) {
			#ifndef __SYNTHESIS__
				cout<<"Sending data";
				if (iqtmp.last) cout<<" with TLAST";
				cout<<endl;
			#endif

			adcout=iqtmp;
			_remaining--;
		}
	}
}
