// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// ==============================================================
// control
// 0x00 : Control signals
//        bit 0  - ap_start (Read/Write/COH)
//        bit 1  - ap_done (Read/COR)
//        bit 2  - ap_idle (Read)
//        bit 3  - ap_ready (Read/COR)
//        bit 7  - auto_restart (Read/Write)
//        others - reserved
// 0x04 : Global Interrupt Enable Register
//        bit 0  - Global Interrupt Enable (Read/Write)
//        others - reserved
// 0x08 : IP Interrupt Enable Register (Read/Write)
//        bit 0  - enable ap_done interrupt (Read/Write)
//        bit 1  - enable ap_ready interrupt (Read/Write)
//        others - reserved
// 0x0c : IP Interrupt Status Register (Read/TOW)
//        bit 0  - ap_done (COR/TOW)
//        bit 1  - ap_ready (COR/TOW)
//        others - reserved
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
// 0x34 : Data signal of total_capturesize
//        bit 31~0 - total_capturesize[31:0] (Read/Write)
// 0x38 : Data signal of total_capturesize
//        bit 2~0 - total_capturesize[34:32] (Read/Write)
//        others  - reserved
// 0x3c : reserved
// 0x40 : Data signal of capturesize
//        bit 26~0 - capturesize[26:0] (Read/Write)
//        others   - reserved
// 0x44 : reserved
// 0x48 : Data signal of iqout
//        bit 31~0 - iqout[31:0] (Read/Write)
// 0x4c : Data signal of iqout
//        bit 31~0 - iqout[63:32] (Read/Write)
// 0x50 : reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define XIQ_CAPTURE_CONTROL_ADDR_AP_CTRL                0x00
#define XIQ_CAPTURE_CONTROL_ADDR_GIE                    0x04
#define XIQ_CAPTURE_CONTROL_ADDR_IER                    0x08
#define XIQ_CAPTURE_CONTROL_ADDR_ISR                    0x0c
#define XIQ_CAPTURE_CONTROL_ADDR_KEEP_DATA              0x10
#define XIQ_CAPTURE_CONTROL_BITS_KEEP_DATA              256
#define XIQ_CAPTURE_CONTROL_ADDR_TOTAL_CAPTURESIZE_DATA 0x34
#define XIQ_CAPTURE_CONTROL_BITS_TOTAL_CAPTURESIZE_DATA 35
#define XIQ_CAPTURE_CONTROL_ADDR_CAPTURESIZE_DATA       0x40
#define XIQ_CAPTURE_CONTROL_BITS_CAPTURESIZE_DATA       27
#define XIQ_CAPTURE_CONTROL_ADDR_IQOUT_DATA             0x48
#define XIQ_CAPTURE_CONTROL_BITS_IQOUT_DATA             64

