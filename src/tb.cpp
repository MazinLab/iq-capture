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


bool drive_filterphase() {


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




bool drive_pairiq() {

	hls::stream<uint128_t> istream, qstream;
	hls::stream<iqout_t> out;
	bool fail=false;
	int samples=513;

	for (int i=0;i<samples;i++){
		istream.write(i);
		qstream.write(samples-i);
	}

	for (int i=0;i<samples;i++) pair_iq(istream, qstream, out);

	for (int i=0;i<samples;i++) {

			iqout_t tmp, got;
			uint128_t ival=i,qval=samples-i;
			bundle: for (int i=0;i<N_IQ;i++){
				tmp.data.range(32*(i+1)-1-16, 32*i)=ival.range(16*(i+1)-1, 16*i);
				tmp.data.range(32*(i+1)-1, 32*i+16)=qval.range(16*(i+1)-1, 16*i);
			}
			tmp.last=i%256 == 255;
			if (out.empty()) {
				cout<<"didn't get output"<<endl;
				fail|=true;
				break;
			}
			got=out.read();
			if (tmp.last!= got.last) {
				cout<<"last mismatch"<<endl;
				fail|=true;
			}
			if (got.data!=tmp.data){
				cout<<"Expect value "<<got.data<<" to be "<<tmp.data<<" (cycle="<<i<<")"<<endl;
				fail|=true;
			}
	}
	if (!out.empty()) {
		cout<<"got too much output"<<endl;
		fail|=true;
	}

	return fail;
}


int main (void){

	bool fail=false;



	fail|=drive_filteriq();
	fail|=drive_filterphase();
	fail|=drive_pairiq();

	if (fail) {
		std::cout << "Test failed" << std::endl;
	} else {
		std::cout << "Test passed" << std::endl;
	}
	return(fail);
}
