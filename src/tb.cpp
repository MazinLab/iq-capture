#include "capture.hpp"
#include <iostream>
#include <bitset>
#define MAX_SAMP 512+3

using namespace std;

#define OUT_BUF_SIZE 2048

int bitsum(uint256_t x) {
	int ret=0;
	for (int i=0;i<256;i++) {
		if (x[i]) ret++;
	}
	return ret;
}

bool drive_iq(uint256_t out[],  capcount_t persamp_capturesize) {


	hls::stream<resstream_t> streamin;
	uint256_t keep;
	bool fail=false;

	//210=31 200=15 205=23  %2=7  <128=15
	for (int i=0;i<N_GROUPS; i++) keep[i]=i%2;
	int nkeep = bitsum(keep);

	capcount_t capturesize = nkeep*persamp_capturesize;
	totalcapcount_t total_capturesize = 256*persamp_capturesize;

	//1*4GB worth ->persamp_capturesize=4GB/32B=1024^3*4/32=134M ->  max total_capturesize 2^35


//	capturesizebitsum(keep)
//	cs=256 tk=1 ->tcs 256*256
//	cs=128*tk tk=2 -> tcs=128*256
//	cs=127*tk tk=3 -> tcs = 127*256
//	cs=1*tk tk=256 - > tcs = 1*256
//
//	cs=2 tk=256 -> tcs=2
//
//	cs=3*tk -> tcs=3*256
	cout<<"Keeping "<<capturesize<<" samples total, "<<persamp_capturesize<<" each of "<<nkeep<<" groups.\n";
	cout<<"Total samples required through core: "<<total_capturesize<<endl;

	if (total_capturesize>2048) {
		cout<<"Need to increase stream directive for successful transfer of "<<total_capturesize<<" samples.\n";
		return true;
	} else{
		cout<<"Will send "<<total_capturesize<<" samples.\n";
	}


	for (int i=0;i<total_capturesize;i++){
		resstream_t d;
		d.data=i;
		d.last=i%256 == 255;
		d.user=i%256;
		streamin.write(d);
	}

	//total_capturesize sets how many samples the core will ingest
	//keep sets which of those samples (out of each group of 256) will be forwarded on
	//capturesize sets how many samples the core will output
	//In the implementation there will always be more data avaialble on the input stream
	//if total_capturesize is too small the core will never terminate. it must be at least (256-bitsum(keep)+1)*capturesize if it is more then there will be leftover internal data
	// keep must have at least 1 bit set
	iq_capture(streamin, keep, total_capturesize, capturesize, out);



	int captured=0;
	bool aligned=false;
	for (int i=0;i<total_capturesize;i++) {
		aligned|=((i%256))%256==0;
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
	for (int i=0; i<OUT_BUF_SIZE;i++) out[i]=0;

	fail|=drive_iq(out, 8);
//	fail|=drive_adc(1500, out, 1399);

	if (fail) {
		std::cout << "Test failed" << std::endl;
	} else {
		std::cout << "Test passed" << std::endl;
	}
	return(fail);
}
