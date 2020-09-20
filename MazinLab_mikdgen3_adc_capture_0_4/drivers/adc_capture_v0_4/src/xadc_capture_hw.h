// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2.1 (64-bit)
// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// ==============================================================
// control
// 0x00 : reserved
// 0x04 : reserved
// 0x08 : reserved
// 0x0c : reserved
// 0x10 : Data signal of capturesize_V
//        bit 31~0 - capturesize_V[31:0] (Read/Write)
// 0x14 : reserved
// 0x18 : Data signal of configure
//        bit 0  - configure[0] (Read/Write)
//        others - reserved
// 0x1c : reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define XADC_CAPTURE_CONTROL_ADDR_CAPTURESIZE_V_DATA 0x10
#define XADC_CAPTURE_CONTROL_BITS_CAPTURESIZE_V_DATA 32
#define XADC_CAPTURE_CONTROL_ADDR_CONFIGURE_DATA     0x18
#define XADC_CAPTURE_CONTROL_BITS_CONFIGURE_DATA     1

