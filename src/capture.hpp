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
#include "ap_fixed.h"


#define N_IQ 8
#define N_PHASE 4
#define N_GROUPS 256
#define N_PHASEGROUPS 512

typedef ap_uint<8> group_t;
typedef ap_uint<9> phasegroup_t;
typedef ap_uint<N_IQ> keep_t;
typedef ap_uint<N_IQ*4> iqkeep_t;
typedef ap_uint<16> sample_t;
typedef ap_uint<16> phase_t;
typedef ap_uint<N_PHASE*2> phasekeep_t;
typedef ap_uint<27> capcount_t;
typedef ap_uint<4> keepcnt_t;
typedef ap_uint<3> streamid_t;
typedef ap_uint<256> uint256_t;

typedef struct adcstream_t {
	sample_t data[N_IQ];
} adcstream_t;

typedef struct resstream_t {
	sample_t data[N_IQ*2];
	group_t user;
	bool last;
} resstream_t;

typedef struct phasestream_t {
	phase_t data[N_PHASE];
	phasegroup_t user;
	bool last;
} phasestream_t;

typedef struct iqout2_t {
	sample_t data[N_IQ*2];
	streamid_t id;
	bool last;
} iqout2_t;

typedef struct phaseout_t {
	phase_t data[N_PHASE];
	streamid_t id;
	bool last;
} phaseout_t;

unsigned char bitcount_sa8(keep_t x);
void phase_capture(phasestream_t &phasestream, keep_t keep[N_GROUPS], capcount_t capturesize, phaseout_t &phaseout);
void iq_capture(resstream_t &resstream, resstream_t &ddsstream, resstream_t &lpstream, uint256_t keep,
				capcount_t capturesize, streamid_t streamid, iqout2_t &iqout, bool config);
void adc_capture(adcstream_t &istream, adcstream_t &qstream, capcount_t capturesize, iqout2_t &adcout);
