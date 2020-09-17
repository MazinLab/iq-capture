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

bool compareiqkeep(iqkeep_t keep, keep_t keepval) {
	bool ret=true;
	for (int i=0;i<N_IQ;i++) {
		int x=keep.range(i*4+3, i*4);
		//cout<<"keep="<<hex<<keep.to_uint()<<": "<<x<<", "<<(int)(keepval[i]*0xf)<<" from "<<std::bitset<8>(keepval.to_uchar())<<endl;
		if (keep.range(i*4+3, i*4)!=keepval[i]*0xf)
			ret=false;
	}
	return ret;
}

bool drivecore(unsigned int ncall, resstream_t resstream[], resstream_t ddsstream[], resstream_t lpstream[],
		keep_t keep[], capcount_t capturesize, ap_uint<2> streamselect) {

	iqout_t iqout[ncall];
	bool fail=false, done=false, started=false;
	bool keepmatch, iqmatch, core_done, start=true;
	keep_t keepval;
	unsigned int captured=0;
	capcount_t core_capturesize=capturesize;

	for (int i=0;i<ncall;i++){
		for (int j=0;j<2*N_IQ;j++) iqout[i].data[j]=0;
		iqout[i].last=0;
		iqout[i].keep=0;
	}

	cout<<"Priming core for first call\n";
	iq_capture(resstream[0], ddsstream[0], lpstream[0], keep, core_capturesize, streamselect, iqout[0], core_done, start);
	cout<<"Core primed first call. Done="<<core_done<<endl<<endl;

	for (int i=0;i<ncall;i++) {

		cout<<dec<<"call="<<i<<" group="<<resstream[i].user<<","<<ddsstream[i].user<<","<<lpstream[i].user<<endl;
		iq_capture(resstream[i], ddsstream[i], lpstream[i], keep, core_capturesize, streamselect, iqout[i], core_done, start);

		switch (streamselect){
		case 0:
			keepval=keep[resstream[i].user];
			started|=resstream[i].user==0;
			iqmatch=compareiq(resstream[i].data, iqout[i].data);
			break;
		case 1:
			keepval=keep[ddsstream[i].user];
			started|=ddsstream[i].user==0;
			iqmatch=compareiq(ddsstream[i].data, iqout[i].data);
			break;
		case 2:
			keepval=keep[lpstream[i].user];
			started|=lpstream[i].user==0;
			iqmatch=compareiq(lpstream[i].data, iqout[i].data);
			break;
		default:
			break;
		}

		if (bitcount_sa8(keepval)>capturesize-captured) {
			int foo=capturesize==captured ? 0: (1<<(capturesize-captured)-1);
			//cout<<"Clipping keep in TB as have "<<dec<<captured<<"/"<<capturesize;
			//cout<<" new keep:"<<hex<<foo<<dec<<endl;
			keepval=keep_t(foo);
		}

		keepmatch=compareiqkeep(iqout[i].keep, keepval);

		for (int j=0;j<N_IQ;j++)
			captured+=iqout[i].keep[j*4];

		cout<<"Captured "<<dec<<captured<<" of "<<capturesize<<endl;//". Core says "<<core_capturesize<<" left\n";
		cout<<"TKEEP=0x"<<hex<<iqout[i].keep.to_uint()<<dec<<" TLAST="<<iqout[i].last<<" Core done:"<<core_done<<endl;

		if (captured<capturesize) {
			if (!started) {
				if (iqout[i].last | iqout[i].keep!=0 | core_done) cout<<"Pre-start data\n";
			} else {
				fail|=!(keepmatch | iqmatch) | core_done;
				if (!keepmatch) cout<<"Keep mismatch\n";
				if (!iqmatch) cout<<"IQ mismatch\n";
				if (iqout[i].last) cout<<"Premature TLAST\n";
				if (core_done) cout<<"Premature core done\n";
			}
		} else if (captured==capturesize) {
			if (!core_done) {
				cout<<"Core not reporting done\n";
				fail=true;
			}
			if (done) {
				fail|=(iqout[i].last | iqout[i].keep!=0);
				if (iqout[i].last | iqout[i].keep!=0) cout<<"Extraneous data\n";
			} else{
				fail|=!keepmatch | !iqmatch | !iqout[i].last;
				if (!keepmatch) cout<<"Keep mismatch\n";
				if (!iqmatch) cout<<"IQ mismatch\n";
				if (!iqout[i].last) cout<<"TLAST missing\n";
			}
			done=true;
		} else {
			fail=true;
			cout<<"Captured more than commanded\n";
		}

	}

	return fail;
}

int main (void){

//	for (int i=0;i<256;i++) cout<<i<<" "<<bitcount_sa8(i)<<endl;
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
			ddsstream[i].user=i-1;
			ddsstream[i].last=i==MAX_SAMP/8-2;

			lpstream[i].data[j*2].range(15,0)=3*ndx;
			lpstream[i].data[j*2+1].range(15,0)=3*ndx;
			lpstream[i].data[j*2+1]=-lpstream[i].data[j*2+1];
			lpstream[i].user=i-2;
			lpstream[i].last=i==MAX_SAMP/8-3;

		}
	}
	for (int i=0;i<N_GROUPS;i++) {
		for (int j=0;j<8;j++) {
			keep[i][j]=j%2;  //keep every other
		}
	}


	cout<<"Selecting Res\n";
	fail|=drivecore(5, resstream, ddsstream, lpstream, keep, 5, 0);
	cout<<"\n\nSelecting DDS\n\n";
	fail|=drivecore(5, resstream, ddsstream, lpstream, keep, 5, 1);
	cout<<"\n\nSelecting LP\n\n";
	fail|=drivecore(5, resstream, ddsstream, lpstream, keep, 5, 2);

	if (fail) {
		std::cout << "Test failed" << std::endl;
	} else {
		std::cout << "Test passed" << std::endl;
	}
	return(fail);
}
