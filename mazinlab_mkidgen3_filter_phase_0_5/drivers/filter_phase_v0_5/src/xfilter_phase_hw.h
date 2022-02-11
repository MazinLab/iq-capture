// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// ==============================================================
// control
// 0x00 : reserved
// 0x04 : reserved
// 0x08 : reserved
// 0x0c : reserved
// 0x10 : Data signal of keep
//        bit 31~0 - keep[31:0] (Read/Write)
// 0x14 : Data signal of keep
//        bit 31~0 - keep[63:32] (Read/Write)
// 0x18 : Data signal of keep
//        bit 31~0 - keep[95:64] (Read/Write)
// 0x1c : Data signal of keep
//        bit 31~0 - keep[127:96] (Read/Write)
// 0x20 : reserved
// 0x24 : Data signal of lastgrp
//        bit 6~0 - lastgrp[6:0] (Read/Write)
//        others  - reserved
// 0x28 : reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define XFILTER_PHASE_CONTROL_ADDR_KEEP_DATA    0x10
#define XFILTER_PHASE_CONTROL_BITS_KEEP_DATA    128
#define XFILTER_PHASE_CONTROL_ADDR_LASTGRP_DATA 0x24
#define XFILTER_PHASE_CONTROL_BITS_LASTGRP_DATA 7

