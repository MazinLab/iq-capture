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


void phase_capture(phasestream_t &phasestream, const streamid_t streamid, uint256_t keep, capcount_t capturesize, bool configure, phaseout_t &phaseout) {
#pragma HLS INTERFACE ap_ctrl_none port=return
#pragma HLS PIPELINE II=1
#pragma HLS INTERFACE axis register port=phasestream
#pragma HLS INTERFACE axis register port=phaseout
#pragma HLS INTERFACE s_axilite port=keep bundle=control clock=ctrl_clk
#pragma HLS INTERFACE s_axilite port=capturesize bundle=control
#pragma HLS INTERFACE ap_stable port=streamid

	static capcount_t _remaining=0;
	static bool _aligned=false;
	phasestream_t phasein;
	phaseout_t phasetmp;

	phasein=phasestream;

	setdata: for (int i=0;i<N_PHASE;i++) phasetmp.data[i]=phasein.data[i];
	phasetmp.id=streamid;
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



void iq_capture(resstream_t &resstream, uint256_t keep, capcount_t capturesize, const streamid_t streamid, iqout2_t &iqout, bool configure) {
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
	iqout2_t iqtmp;

	resin=resstream;

	setdata: for (int i=0;i<N_IQ*2;i++) iqtmp.data[i]=resin.data[i];
	iqtmp.id=streamid;
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
			_remaining--;
		}
	}

}

void adc_capture(adcstream_t &istream, adcstream_t &qstream, bool configure, capcount_t capturesize, iqout2_t &adcout) {
#pragma HLS INTERFACE ap_ctrl_none port=return
#pragma HLS PIPELINE II=1
#pragma HLS INTERFACE axis register port=istream
#pragma HLS DATA_PACK variable=istream
#pragma HLS DATA_PACK variable=qstream
#pragma HLS INTERFACE axis register port=qstream
#pragma HLS INTERFACE axis register port=adcout
#pragma HLS INTERFACE s_axilite port=capturesize bundle=control //clock=control_clk
#pragma HLS INTERFACE s_axilite port=configure bundle=control //clock=control_clk


	static capcount_t _remaining;
	adcstream_t iin, qin;
	iqout2_t iqtmp;

	iin=istream;
	qin=qstream;

	for (int i=0;i<N_IQ;i++){
		iqtmp.data[2*i]=iin.data[i];
		iqtmp.data[2*i+1]=qin.data[i];
	}
	iqtmp.id=0;
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


//void selectstream(resstream_t resin0, resstream_t resin1, resstream_t resin2, streamid_t streamid, resstream_t &resin) {
//#pragma HLS PIPELINE II=1
//	switch (streamid) {
//		case 0:
//			resin=resin0;
//			break;
//		case 1:
//			resin=resin1;
//			break;
//		case 2:
//			resin=resin2;
//			break;
//		case 3:
//			resin=resin0;
//			break;
//	}
//}


//void capture_control(capcount_t capturesize, streamid_t streamid, bool &complete, bool &start,
//					 bool &start_out, bool complete_in, capcount_t &capturesize_out, streamid_t &streamid_out){
//#pragma HLS INTERFACE s_axilite register port=capturesize bundle=control
//#pragma HLS INTERFACE s_axilite register port=streamid bundle=control
//#pragma HLS INTERFACE s_axilite register port=complete bundle=control
//#pragma HLS INTERFACE s_axilite register port=start bundle=control
//
//	streamid_out=streamid;
//	capturesize_out=capturesize;
//	start_out=start;
//
//	complete=complete_in;
//	start=false;
//}
//
//void keep_tag(resstream_t &resstream, keep_t keep[N_GROUPS], const streamid_t streamid, iqout_t &iqout) {
//#pragma HLS INTERFACE ap_ctrl_none port=return
////#pragma HLS INTERFACE s_axilite port=return
//#pragma HLS PIPELINE II=1
//#pragma HLS INTERFACE axis register port=resstream
//#pragma HLS INTERFACE axis register port=iqout
//#pragma HLS INTERFACE s_axilite register port=keep
//
//	iqout_t iqtmp;
//	resstream_t resin=resstream;
//	keep_t keepval=keep[resin.user];
//	//Send the data and keep bits out
//	setdata: for (int i=0;i<N_IQ*2;i++) iqtmp.data[i]=resin.data[i];
//	setkeep: for (int i=0;i<N_IQ;i++) iqtmp.keep(i*4+3,i*4)=keepval[i] ? 0xf:0;
//	iqtmp.id=streamid;
//	iqtmp.last=resin.last;
//	iqout=iqtmp;
//}





//
//void iq_capture_group(resstream_t &resstream, resstream_t &ddsstream, resstream_t &lpstream, uint256_t keep,
//				capcount_t capturesize, streamid_t streamid, iqout2_t &iqout, bool configure) {
////#pragma HLS INTERFACE ap_ctrl_none port=return
//#pragma HLS INTERFACE s_axilite port=return bundle=control
//#pragma HLS PIPELINE II=1
//#pragma HLS INTERFACE axis register port=resstream
//#pragma HLS INTERFACE axis register port=ddsstream
//#pragma HLS INTERFACE axis register port=lpstream
//#pragma HLS INTERFACE axis register port=iqout
//#pragma HLS INTERFACE s_axilite  port=keep bundle=control
//#pragma HLS INTERFACE s_axilite  port=capturesize bundle=control  //Uncommenting this makes it fail the II
//#pragma HLS INTERFACE s_axilite  port=streamid bundle=control
//#pragma HLS INTERFACE s_axilite  port=configure bundle=control
//
//	static uint256_t _keep;
//	static capcount_t _remaining=0;
//	static bool _aligned, _configure=true;
//	resstream_t resin;
//	iqout2_t iqtmp;
//
//	//placing the switch in the function saves ~500LUT
//	selectstream(resstream, ddsstream, lpstream, streamid, resin);
//
//	setdata: for (int i=0;i<N_IQ*2;i++) iqtmp.data[i]=resin.data[i];
//	iqtmp.id=streamid;
//
//	if (configure) {
//		_remaining=capturesize;
//		_aligned=false;
//		_keep=keep;
//		#ifndef __SYNTHESIS__
//		cout<<"Configured core"<<endl;
//		#endif
//	} else {
//		iqtmp.last=_remaining==1;
//
//		_aligned=_aligned || resin.user==0;
//
//		#ifndef __SYNTHESIS__
//		cout<<"Capture "<<capturesize<<" groups from stream "<<streamid.to_uint()<<" user="<<resin.user.to_uint()<<endl;
//		cout<<"Aligned "<<_aligned<<". Remaining "<<_remaining<<" Keep this: "<<_keep[resin.user].to_bool()<<endl;
//		#endif
//
//		if (_remaining>0 && _aligned && _keep[resin.user]) {
//			#ifndef __SYNTHESIS__
//			cout<<"Sending data";
//			if (iqtmp.last) cout<<" with TLAST";
//			cout<<endl;
//			#endif
//
//			iqout=iqtmp;
//			_remaining--;
//		}
//	}
//
//}

