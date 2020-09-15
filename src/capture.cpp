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

void iq_capture(resstream_t &resstream, keep_t keep[N_GROUPS], capcount_t capturesize,
				iqout_t &iqout) {
#pragma HLS INTERFACE ap_ctrl_none port=return
#pragma HLS PIPELINE II=1
#pragma HLS INTERFACE axis register port=resstream
#pragma HLS INTERFACE axis register port=iqout
#pragma HLS INTERFACE s_axilite register port=keep bundle=control clock=ctrl_clk
#pragma HLS INTERFACE s_axilite register port=capturesize bundle=control

	static capcount_t tocapture;
	resstream_t resin;
	iqout_t iqtmp;
	iqkeep_t keepval;

	resin=resstream;
	keepval=keep[resin.user]; //half the width so group goes from 0-511
	unsigned int n_bytes_keep=keepval*4;

	if (tocapture>0 && resin.user==0) {
		for (int i=0;i<N_IQ*2;i++) iqtmp.data[i]=resin.data[i];
		tocapture = n_bytes_keep>tocapture ? capcount_t(0): capcount_t(tocapture-n_bytes_keep);
		keepval = n_bytes_keep>tocapture ? keep_t(tocapture):keep_t(keepval); //A sloppy truncation of the transfer
		for (int i=0;i<N_IQ;i++)
			iqtmp.keep(i,i+4)=keepval[i];
		iqtmp.last=tocapture==0;
		iqout=iqtmp;
	} else {
		tocapture=capturesize;
	}
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

