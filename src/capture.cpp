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


void phase_capture(phasestream_t &phasestream, keep_t keep[N_GROUPS], capcount_t capturesize,
				   phaseout_t &phaseout) {
#pragma HLS INTERFACE ap_ctrl_none port=return
#pragma HLS PIPELINE II=1
#pragma HLS INTERFACE axis register port=phasestream
#pragma HLS INTERFACE axis register port=phaseout
#pragma HLS INTERFACE s_axilite register port=keep bundle=control clock=ctrl_clk
#pragma HLS INTERFACE s_axilite register port=capturesize bundle=control

	static capcount_t tocapture;
	phasestream_t phasein;
	phaseout_t phasetmp;
	iqkeep_t keepval;

	phasein=phasestream;
	keepval=keep[phasein.user/2]; //half the width so group goes from 0-511
	keepval = phasein.user % 2 ? keep_t(keepval>4) : keep_t(keepval&0xf);

	if (tocapture>0 && phasein.user==0) {
		for (int i=0;i<N_PHASE;i++)
			phasetmp.data[i]=phasein.data[i];
		tocapture= keepval>tocapture ? capcount_t(0): capcount_t(tocapture-keepval);
		phasetmp.keep = keepval>tocapture ? phasekeep_t(tocapture):phasekeep_t(keepval); //A sloppy truncation of the transfer
		phasetmp.last=tocapture==0;
		phaseout=phasetmp;
	} else {
		tocapture=capturesize;
	}
}

unsigned char bitcount_sa8(keep_t x) {
#pragma HLS PIPELINE II=1
	const unsigned char S[3] = {1, 2, 4};
	const unsigned char B[3] = {0x55, 0x33, 0x0f};
	unsigned char result = x.to_uchar();
	result = ((result >> S[0]) & B[0]) + (result & B[0]);
	result = ((result >> S[1]) & B[1]) + (result & B[1]);
	result = ((result >> S[2]) & B[2]) + (result & B[2]);
	return result;
}

void parsekeep(keep_t userkeepval, capcount_t tocap, keep_t &keepval, keepcnt_t &nkeep) {
	keepcnt_t tmpn_keep=bitcount_sa8(userkeepval);
	if (tmpn_keep<tocap) {
		nkeep=tmpn_keep;
		keepval=userkeepval;
	} else {
		nkeep=tocap;
		keepval=keep_t((1<<tocap)-1); //user set a bad keepval so just take the first ones to fill things out
	}
}

void selectstream(resstream_t resin0, resstream_t resin1, resstream_t resin2, streamid_t streamid, resstream_t &resin) {
#pragma HLS PIPELINE II=1
	switch (streamid) {
		case 0:
			resin=resin0;
			break;
		case 1:
			resin=resin1;
			break;
		case 2:
			resin=resin2;
			break;
		case 3:
			resin=resin0;
			break;
	}
}


void iq_capture(resstream_t &resstream, resstream_t &ddsstream, resstream_t &lpstream, keep_t keep[N_GROUPS],
				capcount_t capturesize, streamid_t streamid, iqout_t &iqout, bool &complete, bool &start) {
#pragma HLS INTERFACE ap_ctrl_none port=return
//#pragma HLS INTERFACE s_axilite port=return
#pragma HLS PIPELINE II=1
#pragma HLS INTERFACE axis register port=resstream
#pragma HLS INTERFACE axis register port=ddsstream
#pragma HLS INTERFACE axis register port=lpstream
#pragma HLS INTERFACE axis register port=iqout
#pragma HLS INTERFACE s_axilite register port=keep bundle=control
//#pragma HLS INTERFACE s_axilite register port=capturesize bundle=control
//#pragma HLS INTERFACE s_axilite register port=streamid bundle=control
//#pragma HLS INTERFACE s_axilite register port=complete bundle=control
//#pragma HLS INTERFACE s_axilite register port=start bundle=control


	static capcount_t remaining=0;
	static group_t group;
	static keep_t nextkeep=0, keep0=0;
	static keepcnt_t nextn_keep=0, n_keep0=0;
	static streamid_t _streamid;
	static bool capturing=false, _need_to_start=false;
	resstream_t resin;
	keepcnt_t n_keep;

	//placing the switch in the function saves ~500LUTZ
	selectstream(resstream, ddsstream, lpstream, _streamid, resin);

	if (start) {

		#ifndef __SYNTHESIS__
		cout<<"Preparing capture of "<<capturesize<<" for stream "<<streamid.to_uint()<<endl;
		#endif

		_need_to_start=capturesize>0;  //User cleared complete and set a capture size
		_streamid=streamid;
		remaining=capturesize;
		group=0;
		n_keep=0;
		parsekeep(keep[0], remaining, keep0, n_keep0);
	}
	else if ((remaining>0 &!_need_to_start) | (_need_to_start && resin.user==0) ) {

		#ifndef __SYNTHESIS__
		if (_need_to_start) cout<<"Started capture."<<endl;
		#endif

		iqout_t iqtmp;
		keep_t keepval;

		bool last;

		if (_need_to_start){
			n_keep=n_keep0;
			keepval=keep0;
		} else {
			n_keep=nextn_keep;
			keepval=nextkeep;
		}

		last=n_keep==remaining;

		#ifndef __SYNTHESIS__
		cout<<"Group:"<<group<<" User:"<<resin.user<<" Left:"<<remaining<<endl;
		cout<<"Keepval: "<<std::bitset<8>(keepval.to_uchar())<<dec<<" (n="<<n_keep.to_uint()<<")\n";
		//cout<<"Keepvalmem: "<<std::bitset<8>(keep[group])<<" (n="<<(int)bitcount_sa8(keep[group])<<")\n";
		#endif

		//Send the data and keep bits out
		setdata: for (int i=0;i<N_IQ*2;i++) iqtmp.data[i]=resin.data[i];
		setkeep: for (int i=0;i<N_IQ;i++) iqtmp.keep(i*4+3,i*4)=keepval[i] ? 0xf:0;
		iqtmp.last=last;
		iqout=iqtmp;

		_need_to_start=false;

		parsekeep(keep[group+1], remaining-n_keep, nextkeep, nextn_keep);
//		group++;
	}
	else {
	#ifndef __SYNTHESIS__
		cout<<"No active capture\n";
	#endif
	}
	group= _need_to_start ? group_t(0) : group_t(group+1);

	remaining-=n_keep;
	start=false;
	complete=remaining==0;

	#ifndef __SYNTHESIS__
	cout<<"Exiting core. Start="<<start<<" complete="<<complete<<" remain="<<remaining<<endl;
	#endif

}


void simple_ii_2(resstream_t &resstream, keep_t keep[N_GROUPS],
				 capcount_t &capturesize, iqout_t &iqout, bool &complete, bool &start) {
#pragma HLS INTERFACE ap_ctrl_none port=return
#pragma HLS PIPELINE II=1
#pragma HLS INTERFACE axis register port=resstream
#pragma HLS INTERFACE axis register port=iqout
#pragma HLS INTERFACE s_axilite register port=keep bundle=control clock=ctrl_clk
#pragma HLS INTERFACE s_axilite register port=capturesize bundle=control
#pragma HLS INTERFACE s_axilite register port=complete bundle=control
#pragma HLS INTERFACE s_axilite register port=start bundle=control

	static capcount_t remaining;
	static group_t group;
	static keep_t nextkeep=0, keep0=0;
	static ap_uint<2> streamid;
	static bool _need_to_start=false;
	resstream_t resin;

	resin=resstream;

	if (start) {
		_need_to_start=capturesize>0;  //User cleared complete and set a capture size
		remaining=capturesize;
		group=0;
		nextkeep=keep[0];
	}else	if (remaining>0 | (_need_to_start && resin.user==0) ){

		_need_to_start=false;

		iqout_t iqtmp;
		keep_t keepval;
		bool last;

		keepval=nextkeep;
		last=8==remaining;


		setdata: for (int i=0;i<N_IQ*2;i++) iqtmp.data[i]=resin.data[i];
		iqtmp.last=last;
		iqtmp.keep=keepval;
		iqout=iqtmp;

		nextkeep=keep[group+1];

		remaining-=8;

		group++;

	}

	start=false;
	complete=remaining>0;
}


void adc_capture(adcstream_t &istream, adcstream_t &qstream, capcount_t capturesize, adcout_t &adcout) {
#pragma HLS INTERFACE ap_ctrl_none port=return
#pragma HLS PIPELINE II=1
#pragma HLS INTERFACE axis register port=istream
#pragma HLS DATA_PACK variable=istream
#pragma HLS DATA_PACK variable=qstream
#pragma HLS INTERFACE axis register port=qstream
#pragma HLS INTERFACE axis register port=adcout
#pragma HLS INTERFACE s_axilite register port=capturesize bundle=control clock=ctrl_clk

	static capcount_t tocapture;
	adcstream_t iin, qin;
	adcout_t iqtmp;
#pragma HLS ARRAY_PARTITION variable=iqtmp.data complete

	iin=istream;
	qin=qstream;

	if (tocapture>0) {
		for (int i=0;i<N_IQ;i++){
			iqtmp.data[2*i]=iin.data[i];
			iqtmp.data[2*i+1]=qin.data[i];
		}
		tocapture=tocapture<4*N_IQ ? capcount_t(0): capcount_t(tocapture-4*N_IQ);
		iqtmp.last=tocapture==0;
		adcout=iqtmp;
	} else {
		tocapture=capturesize;
	}
}

