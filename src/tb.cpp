#include "capture.hpp"
#include <iostream>
#include <bitset>
#define MAX_SAMP 512+3

using namespace std;

bool compareiq(sample_t a[2*N_IQ], sample_t b[2*N_IQ]) {
	for (int i=0;i<2*N_IQ;i++)
		if (a[i]!=b[i]) return false;
	return true;
}

bool compareadc(sample_t ai[N_IQ], sample_t aq[N_IQ], sample_t b[2*N_IQ]) {
	for (int i=0;i<N_IQ;i++){
		if (ai[i]!=b[2*i]) return false;
		if (aq[i]!=b[2*i+1]) return false;
	}
	return true;
}


bool comparephase(sample_t a[N_PHASE], sample_t b[N_PHASE]) {
	for (int i=0;i<N_PHASE;i++)
		if (a[i]!=b[i]) return false;
	return true;
}




bool driveadc_group(unsigned int ncall, adcstream_t istream[], adcstream_t qstream[], capcount_t capturesize) {

	iqout_t out[ncall];
	bool fail=false, started=false, done=false;
	bool iqmatch;
	int keepval;
	unsigned int captured=0;
	capcount_t core_capturesize=capturesize;

	for (int i=0;i<ncall;i++){
		for (int j=0;j<2*N_IQ;j++) out[i].data[j]=0;
		out[i].last=0;
		out[i].id=0;
	}

	adc_capture(istream[0], qstream[0], core_capturesize, true, out[0]);
	for (int i=0;i<ncall;i++) {

		cout<<dec<<"call="<<i<<endl;
		adc_capture(istream[i], qstream[i], core_capturesize, false, out[i]);

		keepval=1;
		iqmatch=compareadc(istream[i].data, qstream[i].data, out[i].data);
		started=true;

		keepval*=started;
		if (keepval & !iqmatch & captured<capturesize) {
			fail|=true;
			cout<<"keep and no IQ match\n";
		}
		if (iqmatch & !keepval) {
			fail|=true;
			cout<<"IQ matches and keep not set\n";
		}
		if (out[i].id!=0 && keepval && !done){
			fail|=true;
			cout<<"Streamid mismatch\n";
		}
		captured+=keepval;

		if (out[i].last & captured<capturesize) {
			fail|=true;
			cout<<"TLAST early\n";
		}
		if (out[i].last & captured>capturesize) {
			fail|=true;
			cout<<"TLAST late\n";
		}
		if (!out[i].last & captured==capturesize & !done) {
			fail|=true;
			cout<<"TLAST missing\n";
		}
		done=captured==capturesize;

	}

	return fail;
}


bool drivephase_group(unsigned int ncall, phasestream_t resstream[], capcount_t capturesize) {

	phaseout_t out[ncall];
	bool fail=false, started=false, done=false;
	bool keepmatch, iqmatch, keepval;
	uint256_t keep;
	unsigned int captured=0;
	capcount_t core_capturesize=capturesize;

	for (int i=0;i<N_GROUPS; i++) keep[i]=i%2==0;

	for (int i=0;i<ncall;i++){
		for (int j=0;j<2*N_IQ;j++) out[i].data[j]=0;
		out[i].last=0;
		out[i].id=0;
	}

	phase_capture(resstream[0], keep, core_capturesize, 3, true, out[0]);
	for (int i=0;i<ncall;i++) {

		cout<<dec<<"call="<<i<<" group="<<resstream[i].user<<endl;
		phase_capture(resstream[i], keep, core_capturesize, 3, false, out[i]);

		keepval=keep[resstream[i].user];
		iqmatch=comparephase(resstream[i].data, out[i].data);
		started|=resstream[i].user==0;

		keepval*=started;
		if (keepval & !iqmatch & captured<capturesize) {
			fail|=true;
			cout<<"keep and no IQ match\n";
		}
		if (iqmatch & !keepval) {
			fail|=true;
			cout<<"IQ matches and keep not set\n";
		}
		if (out[i].id!=3 && keepval && !done){
			fail|=true;
			cout<<"Streamid mismatch\n";
		}
		captured+=keepval;

		if (out[i].last & captured<capturesize) {
			fail|=true;
			cout<<"TLAST early\n";
		}
		if (out[i].last & captured>capturesize) {
			fail|=true;
			cout<<"TLAST late\n";
		}
		if (!out[i].last & captured==capturesize & !done) {
			fail|=true;
			cout<<"TLAST missing\n";
		}
		done=captured==capturesize;

	}

	return fail;
}


bool drivecore_group(unsigned int ncall, resstream_t resstream[], capcount_t capturesize) {

	iqout_t iqout[ncall];
	bool fail=false, started=false, done=false;
	bool keepmatch, iqmatch, keepval;
	uint256_t keep;
	unsigned int captured=0;
	capcount_t core_capturesize=capturesize;

	for (int i=0;i<N_GROUPS; i++) keep[i]=i%2==0;

	for (int i=0;i<ncall;i++){
		for (int j=0;j<2*N_IQ;j++) iqout[i].data[j]=0;
		iqout[i].last=0;
		iqout[i].id=0;
	}

	iq_capture(resstream[0], keep, core_capturesize, 3, true, iqout[0]);
	for (int i=0;i<ncall;i++) {

		cout<<dec<<"call="<<i<<" group="<<resstream[i].user<<endl;
		iq_capture(resstream[i], keep, core_capturesize, 3, false, iqout[i]);

		keepval=keep[resstream[i].user];
		iqmatch=compareiq(resstream[i].data, iqout[i].data);
		started|=resstream[i].user==0;

		keepval*=started;
		if (keepval & !iqmatch & captured<capturesize) {
			fail|=true;
			cout<<"keep and no IQ match\n";
		}
		if (iqmatch & !keepval) {
			fail|=true;
			cout<<"IQ matches and keep not set\n";
		}
		if (iqout[i].id!=3 && keepval && !done){
			fail|=true;
			cout<<"Streamid mismatch\n";
		}
		captured+=keepval;

		if (iqout[i].last & captured<capturesize) {
			fail|=true;
			cout<<"TLAST early\n";
		}
		if (iqout[i].last & captured>capturesize) {
			fail|=true;
			cout<<"TLAST late\n";
		}
		if (!iqout[i].last & captured==capturesize & !done) {
			fail|=true;
			cout<<"TLAST missing\n";
		}
		done=captured==capturesize;

	}

	return fail;
}

int main (void){

	bool fail=false;

	resstream_t resstream[MAX_SAMP], ddsstream[MAX_SAMP], lpstream[MAX_SAMP];
	phasestream_t phasestream[MAX_SAMP];
	adcstream_t istream[MAX_SAMP], qstream[MAX_SAMP];
	capcount_t capturesize;
	ap_uint<2> streamselect;

	unsigned int captured;

	for (int i=0;i<MAX_SAMP/N_IQ;i++) {
		for (int j=0;j<N_IQ;j++) {
			unsigned int ndx = i*N_IQ+j;
			resstream[i].data[j*2].range(15,0)=ndx;
			resstream[i].data[j*2+1].range(15,0)=ndx;
			resstream[i].data[j*2+1]=-resstream[i].data[j*2+1];
			resstream[i].user=i;
			resstream[i].last=i==MAX_SAMP/N_IQ-1;

			ddsstream[i].data[j*2].range(15,0)=2*ndx;
			ddsstream[i].data[j*2+1].range(15,0)=2*ndx;
			ddsstream[i].data[j*2+1]=-ddsstream[i].data[j*2+1];
			ddsstream[i].user=i-1;
			ddsstream[i].last=i==MAX_SAMP/N_IQ-2;

			lpstream[i].data[j*2].range(15,0)=3*ndx;
			lpstream[i].data[j*2+1].range(15,0)=3*ndx;
			lpstream[i].data[j*2+1]=-lpstream[i].data[j*2+1];
			lpstream[i].user=i-2;
			lpstream[i].last=i==MAX_SAMP/N_IQ-3;

			istream[i].data[j].range(15,0)=ndx;
			qstream[i].data[j].range(15,0)=ndx;
			qstream[i].data[j]=-qstream[i].data[j];
		}
	}

	for (int i=0;i<MAX_SAMP/N_PHASE;i++) {
		for (int j=0;j<N_PHASE;j++) {
			unsigned int ndx = i*N_PHASE+j;
			phasestream[i].data[j].range(15,0)=ndx;
			phasestream[i].user=i;
			phasestream[i].last=i==(ndx%N_PHASEGROUPS) == 0;
		}
	}



//	fail|=drivecore_group(11, resstream, 5);
//	cout<<"\n\nSelecting DDS\n\n";
//	fail|=drivecore_group(11, ddsstream, 5);
//	cout<<"\n\nSelecting LP\n\n";
//	fail|=drivecore_group(11, lpstream, 5);

	fail|=drivephase_group(11,phasestream,5);

//	fail|=driveadc_group(11,istream, qstream,5);

	if (fail) {
		std::cout << "Test failed" << std::endl;
	} else {
		std::cout << "Test passed" << std::endl;
	}
	return(fail);
}
