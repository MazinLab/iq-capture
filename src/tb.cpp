#include "capture.hpp"
#include <iostream>
#include <bitset>
#define MAX_SAMP 512+3

using namespace std;

#define OUT_BUF_SIZE 1000

bool drive_iq(unsigned int samples, uint256_t out[],  capcount_t capturesize) {


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

bool drive_adc(unsigned int samples, uint256_t out[],  capcount_t capturesize) {

	hls::stream<uint128_t> istream, qstream;
	bool fail=false;

	for (int i=0; i<OUT_BUF_SIZE;i++) out[i]=0;
	for (int i=0;i<samples;i++){
		istream.write(i);
		qstream.write(samples-i);
	}

	adc_capture(istream, qstream, capturesize, out);

	int captured=0;
	for (int i=0;i<samples;i++) {
		if (captured<capturesize) {

			uint256_t tmp;
			uint128_t ival=i,qval=samples-i;
			bundle: for (int i=0;i<N_IQ;i++){
				tmp.range(32*(i+1)-1-16, 32*i)=ival.range(16*(i+1)-1, 16*i);
				tmp.range(32*(i+1)-1, 32*i+16)=qval.range(16*(i+1)-1, 16*i);
			}

			if (out[captured]!=tmp){
				cout<<"Expect value "<<out[captured]<<" to be "<<tmp<<endl;
				fail|=out[captured]!=i;
			}
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

//	fail|=drive_iq(512, out, 256);
	fail|=drive_adc(1000, out, 769);

	if (fail) {
		std::cout << "Test failed" << std::endl;
	} else {
		std::cout << "Test passed" << std::endl;
	}
	return(fail);
}
