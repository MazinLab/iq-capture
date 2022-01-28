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
// 0x20 : Data signal of keep
//        bit 31~0 - keep[159:128] (Read/Write)
// 0x24 : Data signal of keep
//        bit 31~0 - keep[191:160] (Read/Write)
// 0x28 : Data signal of keep
//        bit 31~0 - keep[223:192] (Read/Write)
// 0x2c : Data signal of keep
//        bit 31~0 - keep[255:224] (Read/Write)
// 0x30 : reserved
// 0x34 : Data signal of lastgrp
//        bit 7~0 - lastgrp[7:0] (Read/Write)
//        others  - reserved
// 0x38 : reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define XFILTER_IQ_CONTROL_ADDR_KEEP_DATA    0x10
#define XFILTER_IQ_CONTROL_BITS_KEEP_DATA    256
#define XFILTER_IQ_CONTROL_ADDR_LASTGRP_DATA 0x34
#define XFILTER_IQ_CONTROL_BITS_LASTGRP_DATA 8

