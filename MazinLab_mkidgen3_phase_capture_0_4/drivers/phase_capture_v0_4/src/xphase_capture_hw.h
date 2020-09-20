// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2.1 (64-bit)
// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// ==============================================================
// control
// 0x00 : reserved
// 0x04 : reserved
// 0x08 : reserved
// 0x0c : reserved
// 0x10 : Data signal of keep_V
//        bit 31~0 - keep_V[31:0] (Read/Write)
// 0x14 : Data signal of keep_V
//        bit 31~0 - keep_V[63:32] (Read/Write)
// 0x18 : Data signal of keep_V
//        bit 31~0 - keep_V[95:64] (Read/Write)
// 0x1c : Data signal of keep_V
//        bit 31~0 - keep_V[127:96] (Read/Write)
// 0x20 : Data signal of keep_V
//        bit 31~0 - keep_V[159:128] (Read/Write)
// 0x24 : Data signal of keep_V
//        bit 31~0 - keep_V[191:160] (Read/Write)
// 0x28 : Data signal of keep_V
//        bit 31~0 - keep_V[223:192] (Read/Write)
// 0x2c : Data signal of keep_V
//        bit 31~0 - keep_V[255:224] (Read/Write)
// 0x30 : reserved
// 0x34 : Data signal of capturesize_V
//        bit 31~0 - capturesize_V[31:0] (Read/Write)
// 0x38 : reserved
// 0x3c : Data signal of configure
//        bit 0  - configure[0] (Read/Write)
//        others - reserved
// 0x40 : reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define XPHASE_CAPTURE_CONTROL_ADDR_KEEP_V_DATA        0x10
#define XPHASE_CAPTURE_CONTROL_BITS_KEEP_V_DATA        256
#define XPHASE_CAPTURE_CONTROL_ADDR_CAPTURESIZE_V_DATA 0x34
#define XPHASE_CAPTURE_CONTROL_BITS_CAPTURESIZE_V_DATA 32
#define XPHASE_CAPTURE_CONTROL_ADDR_CONFIGURE_DATA     0x3c
#define XPHASE_CAPTURE_CONTROL_BITS_CONFIGURE_DATA     1

