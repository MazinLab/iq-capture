#include "ap_int.h"
#include "ap_axi_sdata.h"
#include "hls_stream.h"

#define N_IQ 8
#define N_PHASE 4
#define N_GROUPS 256
#define N_PHASEGROUPS 512


typedef ap_uint<8> group_t;
typedef ap_uint<9> phasegroup_t;
typedef ap_uint<N_GROUPS> keep_t;
typedef ap_uint<128> keep512_t;
typedef ap_uint<128> pkeep256_t;
typedef ap_uint<7> pgroup256_t;
typedef ap_uint<N_PHASEGROUPS> phasekeep_t;
typedef ap_uint<16> sample_t;
typedef ap_uint<16> phase_t;
typedef ap_uint<27> capcount_t;  //27 max 4GiB worth of uint256
typedef ap_uint<4> streamid_t;
typedef ap_uint<512> uint512_t;
typedef ap_uint<256> uint256_t;
typedef ap_uint<128> uint128_t;
typedef ap_uint<512> uint512_t;
typedef unsigned long long uint64_t;


typedef ap_axiu<N_IQ*32,8,0,0> resstream_t;
typedef ap_axiu<N_IQ*32,0,0,0> iqout_t;
typedef ap_axiu<256,0,0,0> out256_t;
typedef ap_axiu<512,0,0,0> out512_t;
typedef ap_axiu<N_PHASE*16,16,0,0> phasestream_t;
typedef ap_axiu<N_PHASE*16,0,0,0> phaseout_t;

void pair_iq(hls::stream<uint128_t> &i_in, hls::stream<uint128_t> &q_in, hls::stream<iqout_t> &out);
void filter_iq(hls::stream<resstream_t> &instream, hls::stream<iqout_t> &filtered, keep_t keep, group_t lastgrp);
void filter_phase64(hls::stream<phasestream_t> &instream, hls::stream<phaseout_t> &filtered, phasekeep_t keep, phasegroup_t lastgrp);

void filter_phase(hls::stream<phasestream_t> &instream, hls::stream<out256_t> &filtered, pkeep256_t keep, pgroup256_t lastgrp);

void pair_iq512(hls::stream<uint128_t> &i_in, hls::stream<uint128_t> &q_in, hls::stream<out512_t> &out);
void filter_iq512(hls::stream<resstream_t> &instream, hls::stream<out512_t> &filtered, keep_t keep, group_t lastgrp);
void filter_phase512(hls::stream<phasestream_t> &instream, hls::stream<out512_t> &filtered, phasekeep_t keep, phasegroup_t lastgrp);

void write_axi256(hls::stream<iqout_t> &filtered, capcount_t capturesize, uint256_t *out);
void write_axi64(hls::stream<phaseout_t> &filtered, capcount_t capturesize, uint64_t *out);
void simple_capture(hls::stream<iqout_t> &stream, capcount_t capturesize, uint256_t *iqout);
