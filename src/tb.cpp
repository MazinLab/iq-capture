#include "capture.hpp"
#include <iostream>

#define MAX_SAMP 10


using namespace std;

bool compareiq(sample_t a[2*N_IQ], sample_t b[2*N_IQ]) {
	for (int i=0;i<2*N_IQ;i++)
		if (a[i]!=b[1]) return false;
	return true;
}

bool compareiqkeep(iqkeep_t keep, keep_t keepval) {
	for (int i=0;i<N_IQ;i++) {
		if (keep.range((i+1)*4-1, i*4)!=keep[i]*0xff)
			return false;
	}
	return true;
}

bool drivecore(unsigned int ncall, resstream_t resstream[], resstream_t ddsstream[], resstream_t lpstream[],
		keep_t keep[], capcount_t capturesize, ap_uint<2> streamselect) {

	iqout_t iqout[ncall];
	bool fail=false;
	bool keepmatch, iqmatch;
	keep_t keepval;
	unsigned int captured=0;

	for (int i=0;i<ncall;i++) {
		iq_capture(resstream[i], ddsstream[i], lpstream[i], keep, capturesize, streamselect, iqout[i]);

		switch (streamselect){
		case 0:
			keepval=keep[resstream[i].user];
			iqmatch=compareiq(resstream[i].data, iqout[i].data);
			break;
		case 1:
			keepval=keep[ddsstream[i].user];
			iqmatch=compareiq(ddsstream[i].data, iqout[i].data);
			break;
		case 2:
			keepval=keep[lpstream[i].user];
			iqmatch=compareiq(lpstream[i].data, iqout[i].data);
			break;
		default:
			break;
		}
		if (keepval>capturesize-captured)
			keepval=capturesize-captured;

		keepmatch=compareiqkeep(iqout[i].keep, keepval);

		for (int j=0;j<N_IQ;j+=4)
			captured+=iqout[i].keep[j];

		if (captured<capturesize) {
			fail|=!(keepmatch | iqmatch);
			if (!keepmatch) cout<<"Keep mismatch\n";
			if (!iqmatch) cout<<"IQ mismatch\n";
			if (iqout[i].last) cout<<"Premature TLAST\n";
		} else if (captured==capturesize) {
			if (!keepmatch) cout<<"Keep mismatch\n";
			if (!iqmatch) cout<<"IQ mismatch\n";
			if (!iqout[i].last) cout<<"TLAST missing\n";
		} else {
			fail=true;
			cout<<"Captured more than commanded\n";
		}

	}

	return fail;
}

int main (void){

	bool fail=false;

	resstream_t resstream[MAX_SAMP], ddsstream[MAX_SAMP], lpstream[MAX_SAMP];
	keep_t keep[N_GROUPS], keepval;
	capcount_t capturesize;
	ap_uint<2> streamselect;

	unsigned int captured;

	for (int i=0;i<MAX_SAMP/8;i++) {
		for (int j=0;j<8;j++) {
			unsigned int ndx = i*8+j;
			resstream[i].data[j*2].range(15,0)=ndx;
			resstream[i].data[j*2+1].range(15,0)=ndx;
			resstream[i].data[j*2+1]=-resstream[i].data[j*2+1];
			resstream[i].user=i;
			resstream[i].last=i==MAX_SAMP/8-1;

			ddsstream[i].data[j*2].range(15,0)=2*ndx;
			ddsstream[i].data[j*2+1].range(15,0)=2*ndx;
			ddsstream[i].data[j*2+1]=-ddsstream[i].data[j*2+1];
			ddsstream[i].last=i==MAX_SAMP/8-2;
			ddsstream[i].user=i+1;

			lpstream[i].data[j*2].range(15,0)=3*ndx;
			lpstream[i].data[j*2+1].range(15,0)=3*ndx;
			lpstream[i].data[j*2+1]=-lpstream[i].data[j*2+1];
			lpstream[i].last=i==MAX_SAMP/8-1;
			lpstream[i].user=i+2;

		}
	}
	for (int i=0;i<N_GROUPS;i++) {
		for (int j=0;j<8;j++) {
			unsigned int ndx = i*8+j;
			keep[i][j]=ndx%2;  //keep every other
		}
	}


	cout<<"Selecting Res\n";
	fail|=drivecore(MAX_SAMP, resstream, ddsstream, lpstream, keep, MAX_SAMP/2, 0);
	cout<<"Selecting DDS\n";
	fail|=drivecore(MAX_SAMP, resstream, ddsstream, lpstream, keep, MAX_SAMP/2, 1);
	cout<<"Selecting LP\n";
	fail|=drivecore(MAX_SAMP, resstream, ddsstream, lpstream, keep, MAX_SAMP/2, 2);

	if (fail) {
		std::cout << "Test failed" << std::endl;
	} else {
		std::cout << "Test passed" << std::endl;
	}
	return(fail);
}
