// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Version: 2021.1
// Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module filter_iq_fetch_keep (
        ap_ready,
        keep,
        grp,
        ap_return
);


output   ap_ready;
input  [255:0] keep;
input  [7:0] grp;
output  [0:0] ap_return;

assign ap_ready = 1'b1;

assign ap_return = keep[grp];

endmodule //filter_iq_fetch_keep