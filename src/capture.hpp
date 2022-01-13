/* The DDR4 core can capture up to 2667MT/S on a 64 bit bus. I think this translates
 * to ~21336 MBPS
 * ADC stream is 512*32B ~16.3GB/s (8 IQ 2 bytes each @ 512MHz)
	- Could pack to 512*24B 12.2GB/s but unpacking in software would be a bear)
 * OPFB stream is 512M*64B ~ 32.7GB/s  (16 IQ 2 bytes each @ 512MHz)
 * Res Streams (selected bins and DDSed) are 512M*32B ~16.3GB/s (8 IQ 2 bytes each @ 512MHz)
 * LP Res Stream is 256M*32B ~8.2GB/s (8 IQ 2 bytes each @ 256MHz)
 * Phase Stream is 512M*8B ~4 GB/s (4 phase 2 bytes @ 512MHz)
*/
#include "ap_int.h"
#include "ap_axi_sdata.h"
#include "hls_stream.h"
#include <ap_utils.h>

#define N_IQ 8
#define N_PHASE 4
#define N_GROUPS 256
#define N_PHASEGROUPS 512


#define MAX_IQGRPCAPCOUNT 2^27 //2^32 bytes / 32 bytes
#define MAX_GROUPS_PROCESS MAX_IQGRPCAPCOUNT
#define IQ_BURST_SIZE 128

typedef ap_uint<8> group_t;
typedef ap_uint<9> phasegroup_t;
typedef ap_uint<N_GROUPS> keep_t;
typedef ap_uint<N_PHASEGROUPS> phasekeep_t;
typedef ap_uint<N_IQ*4> iqkeep_t;
typedef ap_uint<16> sample_t;
typedef ap_uint<16> phase_t;
typedef ap_uint<27> capcount_t;  //27 min 32 max
typedef ap_uint<27+8> totalcapcount_t;
typedef ap_uint<4> streamid_t;
typedef ap_uint<256> uint256_t;
typedef ap_uint<128> uint128_t;
typedef ap_uint<64> phaseout_t;


typedef ap_axiu<N_IQ*32,8,0,0> resstream_t;
typedef ap_axiu<N_PHASE*16,16,0,0> phasestream_t;

void phase_capture(hls::stream<phasestream_t> &phasestream, phasekeep_t keep, totalcapcount_t total_capturesize, capcount_t capturesize, phaseout_t *out);
void iq_capture(hls::stream<resstream_t> &resstream, keep_t keep, totalcapcount_t total_capturesize, capcount_t capturesize, uint256_t *out);
void adc_capture(hls::stream<uint128_t> &istream, hls::stream<uint128_t> &qstream, capcount_t capturesize, uint256_t *out);
void simple_capture(hls::stream<resstream_t> &stream, capcount_t capturesize, uint256_t *out);
