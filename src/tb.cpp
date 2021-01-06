#include "filter.hpp"
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
int bitsum(uint512_t x) {
	int ret=0;
	for (int i=0;i<512;i++) {
		if (x[i]) ret++;
	}
	return ret;
}
int lastbit(uint256_t x) {
	int ret=0;
	for (int i=0;i<256;i++) {
		if (x[i]) ret=i;
	}
	return ret;
}
int lastbit(uint512_t x) {
	int ret=0;
	for (int i=0;i<512;i++) {
		if (x[i]) ret=i;
	}
	return ret;
}

resstream_t iq_for_sample(int i) {
	resstream_t d;
	d.data=i;
	d.last=i%256 == 255;
	d.user=i%256;
	return d;
}


bool drive_iq(uint256_t out[]) {


	hls::stream<resstream_t> streamin("input");
	hls::stream<iqout_t> filteredstream("filtered"), filteredstreamin("filtered");
	iqout_t filtereddata[2048];
	uint256_t keep;
	bool fail=false;
	int offset=13; //the group the core gets at start
//	int n_iq = 7;
	int capturesize=8;  //only even values allowed
	//210=31 200=15 205=23  %2=7  <128=15
	for (int i=0;i<N_GROUPS; i++) keep[i]=i%2;
	int nkeep = bitsum(keep);
    int total_size=256*capturesize;


	if (total_size>2048) {
		cout<<"Need to increase stream directive for successful transfer of "<<total_size<<" samples.\n";
		return true;
	} else{
		cout<<"Will send "<<total_size<<" samples.\n";
	}
	for (int j=0;j<total_size;j++)
		streamin.write(iq_for_sample(j+offset));

	// keep must have at least 1 bit set
	for (int j=0;j<total_size;j++)
		filter_iq(streamin, filteredstream, keep, lastbit(keep));

	int i=0;
	while(!filteredstream.empty()) {
		iqout_t x=filteredstream.read();
		filteredstreamin.write(x);
		cout<<"filtered["<<i<<"]="<<x.data<<" last="<<x.last<<endl;
		filtereddata[i++]=x;
	}


	write_axi256(filteredstreamin, capturesize, out);

	cout<<"Capture "<<capturesize<<" samples."<<endl;
	for (int j=0;j<capturesize+2;j++) {
		cout<<"out["<<j<<"]="<<out[j]<<endl;
	}
	bool aligned=false;
	int captured=0;
	for (int j=0;j<total_size;j++) {
		resstream_t d = iq_for_sample(j+offset);
		if (keep[d.user] && aligned && (captured<capturesize) ){
			if (out[captured++]!=d.data) {
				cout<<"Expected value "<<out[captured-1]<<" to be "<<d.data<<endl;
				fail=true;
			}
		}
		aligned |= d.last;
	}
	for (int j=captured;j<OUT_BUF_SIZE;j++) {
		if (out[j]!=0) {
			cout<<"too much output"<<endl;
			fail=true;
		}
	}

//	for (int i=0;i<OUT_BUF_SIZE;i++){
//		if ((i<capturesize) && (out[i]!=filtereddata[i].data)){
//			cout<<"mismatch"<<endl;
//			fail=true;
//		} else if ((i>=capturesize) && (out[i]!=0)){
//			cout<<"too much output"<<endl;
//			fail=true;
//		}
//	}



//	int captured=0;
//	bool aligned=true;
//	int lastgrp = lastbit(keep);
//	for (int j=0;j<total_size;j++) {
//
//		resstream_t d = iq_for_sample(j+offset);
//
//		if (keep[d.user]){
//			if (!filteredstream.empty()) {
//				iqout_t x=filteredstream.read();
//
//				if (x.data!=d.data){
//					cout<<"Expected value "<<x.data<<" to be "<<d.data<<endl;
//					fail=true;
//				}
//				if ((d.user.to_uint()==lastgrp)!=x.last){
//					cout<<"Expected last to be "<<(d.user.to_uint()==lastgrp)<<endl;
//					fail=true;
//				}
//			} else {
//				cout<<"premature empty stream"<<endl;
//				fail=true;
//			}
//		}
//	}
//	if (!filteredstream.empty()) {
//		cout<<"stream has extra data"<<endl;
//		fail=true;
//	}


	return fail;
}
//
//bool drive_adc(unsigned int samples, uint256_t out[],  capcount_t capturesize) {
//
//	hls::stream<uint128_t> istream, qstream;
//	bool fail=false;
//
//	for (int i=0; i<OUT_BUF_SIZE;i++) out[i]=0;
//	for (int i=0;i<samples;i++){
//		istream.write(i);
//		qstream.write(samples-i);
//	}
//
//	adc_capture(istream, qstream, capturesize, out);
//
//	int captured=0;
//	for (int i=0;i<samples;i++) {
//		if (captured<capturesize) {
//
//			uint256_t tmp;
//			uint128_t ival=i,qval=samples-i;
//			bundle: for (int i=0;i<N_IQ;i++){
//				tmp.range(32*(i+1)-1-16, 32*i)=ival.range(16*(i+1)-1, 16*i);
//				tmp.range(32*(i+1)-1, 32*i+16)=qval.range(16*(i+1)-1, 16*i);
//			}
//
//			if (out[captured]!=tmp){
//				cout<<"Expect value "<<out[captured]<<" to be "<<tmp<<" (cycle="<<i<<")"<<endl;
//				fail|=out[captured]!=i;
//			} else {cout<<"OK "<<out[captured]<<" (cycle="<<i<<")"<<endl;}
//			captured++;
//		} else {
//			//cout<<"Expect value "<<out[captured]<<" to be "<<i<<endl;
//			if (captured==capturesize) break;
//		}
//	}
//
//	//Rest better still be zero
//	while (captured<OUT_BUF_SIZE) fail|=out[captured++]!=0;
//
//	return fail;
//}

int main (void){

	bool fail=false;


	ap_uint<256> out[OUT_BUF_SIZE];
	for (int i=0; i<OUT_BUF_SIZE;i++) out[i]=0;

	fail|=drive_iq(out);
	//fail|=drive_adc(1500, out, 1398);

	if (fail) {
		std::cout << "Test failed" << std::endl;
	} else {
		std::cout << "Test passed" << std::endl;
	}
	return(fail);
}
