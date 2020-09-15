// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2.1 (64-bit)
// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// ==============================================================
// control
// 0x000 : reserved
// 0x004 : reserved
// 0x008 : reserved
// 0x00c : reserved
// 0x200 : Data signal of capturesize_V
//         bit 31~0 - capturesize_V[31:0] (Read/Write)
// 0x204 : reserved
// 0x100 ~
// 0x1ff : Memory 'keep_V' (256 * 8b)
//         Word n : bit [ 7: 0] - keep_V[4n]
//                  bit [15: 8] - keep_V[4n+1]
//                  bit [23:16] - keep_V[4n+2]
//                  bit [31:24] - keep_V[4n+3]
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define XPHASE_CAPTURE_CONTROL_ADDR_CAPTURESIZE_V_DATA 0x200
#define XPHASE_CAPTURE_CONTROL_BITS_CAPTURESIZE_V_DATA 32
#define XPHASE_CAPTURE_CONTROL_ADDR_KEEP_V_BASE        0x100
#define XPHASE_CAPTURE_CONTROL_ADDR_KEEP_V_HIGH        0x1ff
#define XPHASE_CAPTURE_CONTROL_WIDTH_KEEP_V            8
#define XPHASE_CAPTURE_CONTROL_DEPTH_KEEP_V            256

