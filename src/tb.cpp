#include "capture.hpp"
#include <iostream>
#include <bitset>
#define MAX_SAMP 512+3

using namespace std;

#define OUT_BUF_SIZE 1000

bool driveiq_group(unsigned int samples, uint256_t out[],  capcount_t capturesize) {


	hls::stream<resstream_t> streamin;
	uint256_t keep;
	bool fail=false;

	//210=31 200=15 205=23  %2=7  <128=15
	for (int i=0;i<N_GROUPS; i++) keep[i]=1;
	for (int i=0; i<OUT_BUF_SIZE;i++) out[i]=0;
	for (int i=0;i<samples;i++){
		resstream_t d;
		d.data=i;
		d.last=i%256 == 255;
		d.user=i%256+1;
		streamin.write(d);
	}

	iq_capture(streamin, keep, capturesize, out);


	int captured=0;
	bool aligned=false;
	for (int i=0;i<samples;i++) {
		aligned|=((i%256)+1)%256==0;
		if (keep[i%256] && captured<capturesize && aligned) {
			if (out[captured]!=i)
				cout<<"Expect value "<<out[captured]<<" to be "<<i<<endl;
			fail|=out[captured]!=i;
			captured++;
		} else {
			//cout<<"Expect value "<<out[captured]<<" to be "<<i<<endl;
			if (captured==capturesize) break;
		}
	}

	//Rest better still be zero
	while (captured<OUT_BUF_SIZE) fail|=out[captured++]!=0;

	return fail;
}

int main (void){

	bool fail=false;


	ap_uint<256> out[OUT_BUF_SIZE];

	fail|=driveiq_group(512, out, 256);
//	cout<<"\n\nSelecting DDS\n\n";
//	fail|=drivecore_group(11, ddsstream, 5);
//	cout<<"\n\nSelecting LP\n\n";
//	fail|=drivecore_group(11, lpstream, 5);

//	fail|=drivephase_group(11,phasestream,5);

//	fail|=driveadc_group(11,istream, qstream,5);

	if (fail) {
		std::cout << "Test failed" << std::endl;
	} else {
		std::cout << "Test passed" << std::endl;
	}
	return(fail);
}
