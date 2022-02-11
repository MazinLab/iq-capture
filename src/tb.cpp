#include "filter.hpp"
#include <iostream>
#include <bitset>
#define MAX_SAMP 512+3

using namespace std;

int bitsum(uint128_t x) {
	int ret=0;
	for (int i=0;i<128;i++) {
		if (x[i]) ret++;
	}
	return ret;
}

int lastbit(uint128_t x) {
	int ret=0;
	for (int i=0;i<128;i++) {
		if (x[i]) ret=i;
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

int lastbit(uint512_t x) {
	int ret=0;
	for (int i=0;i<512;i++) {
		if (x[i]) ret=i;
	}
	return ret;
}


#define OUT_BUF_SIZE 4096
typedef ap_axiu<256,8,0,0> resstream_t;

int bitsum(uint256_t x) {
	int ret=0;
	for (int i=0;i<256;i++) {
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


resstream_t iq_for_sample(int i) {
	resstream_t d;
	d.data=i;
	d.last=i%256 == 255;
	d.user=i%256;
	return d;
}


phasestream_t phase_for_sample(int i) {
	phasestream_t d;
	d.data=i;
	d.last=i%512 == 511;
	d.user=i%512;
	return d;
}

bool drive_writeaxi256() {

	ap_uint<256> out[OUT_BUF_SIZE];

	for (int i=0; i<OUT_BUF_SIZE;i++)
		out[i]=0;
	hls::stream<iqout_t> streamin("input");
	uint256_t keep;
	bool fail=false;
	int offset=13; //the group the core gets at start (test sync logic)
	int capturesize=128*14;  //only multiples of 128  allowed
	for (int i=0;i<N_GROUPS; i++)
		keep[i]=i%2;	// every other tuser
	int nkeep = bitsum(keep);
	int lastuser = lastbit(keep);
    int total_size=256*capturesize/nkeep+(256-offset)+256;  //send a fullcycle and then some
	bool aligned=true;

	cout<<"Will process "<<total_size<<" samples.\n";
	if (nkeep<2) {
		cout<<"nkeep must set at least two samples"<<endl;
		return false;
	}
	for (int j=0;j<total_size; j++) {
		resstream_t x;

		iqout_t in;
		x=iq_for_sample(j+offset);
		in.data=x.data;
		in.last=x.user==lastuser;
		if (keep[x.user]) streamin.write(in);
	}
	cout<<"Will send "<<streamin.size()<<" samples to capture "<<capturesize<<" samples "<<endl;
	if (streamin.size()>OUT_BUF_SIZE) {
		cout<<"More than "<<OUT_BUF_SIZE<<" samples needs a bigger buffer"<<endl;
		return false;
	}

	write_axi256(streamin, capturesize, out);

	int captured=0;
	for (int j=0;j<total_size;j++) {
		resstream_t d = iq_for_sample(j+offset);
		if (keep[d.user] && aligned && (captured<capturesize) ){
			if (out[captured++]!=d.data) {
				cout<<"Expected value "<<out[captured-1]<<" to be "<<d.data<<endl;
				fail=true;
			}
		} else if (!aligned) {
			cout<<"Skipping filtered sample "<<j<<" with user="<<d.user<<endl;
		}
		aligned |= d.last;
	}
	for (int j=captured;j<OUT_BUF_SIZE;j++) {
		if (out[j]!=0) {
			cout<<"too much output"<<endl;
			fail=true;
		}
	}

	return fail;
}


bool drive_filteriq() {


	hls::stream<resstream_t> streamin("input");
	hls::stream<iqout_t> filteredstream("filtered");
	uint256_t keep;
	bool fail=false;
	int offset=13; //the group the core gets at start
	int capturesize=128*4;  //only multiples of 128  allowed
	for (int i=0;i<N_GROUPS; i++) keep[i]=i<7? 0:i%2;
	int nkeep = bitsum(keep);
    int total_size=256*capturesize/nkeep+(256-offset)+256;


	if (total_size>2048) {
		cout<<"Need to increase stream directive for successful transfer of "<<total_size<<" samples.\n";
		return true;
	} else{
		cout<<"Will send "<<total_size<<" samples.\n";
	}
	for (int j=0;j<total_size;j++) streamin.write(iq_for_sample(j+offset));

	// keep must have at least 1 bit set
	for (int j=0;j<total_size;j++)
		filter_iq(streamin, filteredstream, keep, lastbit(keep));


	int output=0;
	for (int j=0;j<total_size;j++) {
		resstream_t d = iq_for_sample(j+offset);
		if (keep[d.user]) {
			if (filteredstream.empty()) {
				cout<<"Expected output data"<<endl;
				break;
			}
			iqout_t x=filteredstream.read();
			if (x.data !=d.data) {
				cout<<"Expected value "<<x.data<<" to be "<<d.data<<endl;
				fail=true;
			}
			if (x.last!= (d.user==lastbit(keep))) {
				cout<<"Expected last to be "<<(d.user==lastbit(keep))<<endl;
				fail=true;
			}
		}
	}
	if (!filteredstream.empty()) {
		cout<<"too much output"<<endl;
		fail=true;
	}

	return fail;
}


bool drive_filterphase256() {


//	void filter_phase(hls::stream<phasestream_t> &instream, hls::stream<out256_t> &filtered, pkeep256_t keep, pgroup256_t lastgrp);

	hls::stream<phasestream_t> streamin("input");
	hls::stream<out256_t> filteredstream("filtered");
	pkeep256_t keep;
	bool fail=false;
	int offset=13; //the group the core gets at start
	int capturesize=128*4;  //only multiples of 128  allowed
	for (int i=0;i<N_PHASEGROUPS/4; i++) keep[i]=i<7? 0:i%2;
	int nkeep = bitsum(keep);
    int total_size=N_PHASEGROUPS*2+(N_PHASEGROUPS-offset)+N_PHASEGROUPS;


	if (total_size>2048) {
		cout<<"Need to increase stream directive for successful transfer of "<<total_size<<" samples.\n";
		return true;
	} else{
		cout<<"Will send "<<total_size<<" samples.\n";
	}
	for (int j=0;j<total_size;j++) streamin.write(phase_for_sample(j+offset));

	bool error;
	// keep must have at least 1 bit set
	for (int j=0;j<total_size/4;j++)
		filter_phase(streamin, filteredstream, keep, lastbit(keep));


	int output=0;
	for (int j=0;j<(total_size+offset%4)/4;j++) {
		uint256_t d;
		phasestream_t phase;
		for (int i=0;i<4; i++) {
			 phase = phase_for_sample(4*j+offset+i+4-(offset%4));
			 d.range((i+1)*64-1,i*64)=phase.data;
		}
		if (keep[phase.user>>2]) {
			if (filteredstream.empty()) {
				cout<<"Expected output data"<<endl;
				break;
			}
			out256_t x=filteredstream.read();
			if (x.data !=d) {
				cout<<"Expected value "<<x.data<<" to be "<<d<<endl;
				fail=true;
			}
			if (x.last!= ((phase.user>>2)==lastbit(keep))) {
				cout<<"Expected last to be "<<((phase.user>>2)==lastbit(keep))<<endl;
				fail=true;
			}
		}
	}
	if (!filteredstream.empty()) {
		cout<<"too much output"<<endl;
		fail=true;
	}

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



//	fail|=drive_filteriq();
	fail|=drive_filterphase256();
//	fail|=drive_writeaxi256();
	//fail|=drive_adc(1500, out, 1398);

	if (fail) {
		std::cout << "Test failed" << std::endl;
	} else {
		std::cout << "Test passed" << std::endl;
	}
	return(fail);
}
