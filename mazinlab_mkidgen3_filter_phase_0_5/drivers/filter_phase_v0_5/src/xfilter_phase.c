// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xfilter_phase.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XFilter_phase_CfgInitialize(XFilter_phase *InstancePtr, XFilter_phase_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XFilter_phase_Set_keep(XFilter_phase *InstancePtr, XFilter_phase_Keep Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XFilter_phase_WriteReg(InstancePtr->Control_BaseAddress, XFILTER_PHASE_CONTROL_ADDR_KEEP_DATA + 0, Data.word_0);
    XFilter_phase_WriteReg(InstancePtr->Control_BaseAddress, XFILTER_PHASE_CONTROL_ADDR_KEEP_DATA + 4, Data.word_1);
    XFilter_phase_WriteReg(InstancePtr->Control_BaseAddress, XFILTER_PHASE_CONTROL_ADDR_KEEP_DATA + 8, Data.word_2);
    XFilter_phase_WriteReg(InstancePtr->Control_BaseAddress, XFILTER_PHASE_CONTROL_ADDR_KEEP_DATA + 12, Data.word_3);
}

XFilter_phase_Keep XFilter_phase_Get_keep(XFilter_phase *InstancePtr) {
    XFilter_phase_Keep Data;

    Data.word_0 = XFilter_phase_ReadReg(InstancePtr->Control_BaseAddress, XFILTER_PHASE_CONTROL_ADDR_KEEP_DATA + 0);
    Data.word_1 = XFilter_phase_ReadReg(InstancePtr->Control_BaseAddress, XFILTER_PHASE_CONTROL_ADDR_KEEP_DATA + 4);
    Data.word_2 = XFilter_phase_ReadReg(InstancePtr->Control_BaseAddress, XFILTER_PHASE_CONTROL_ADDR_KEEP_DATA + 8);
    Data.word_3 = XFilter_phase_ReadReg(InstancePtr->Control_BaseAddress, XFILTER_PHASE_CONTROL_ADDR_KEEP_DATA + 12);
    return Data;
}

void XFilter_phase_Set_lastgrp(XFilter_phase *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XFilter_phase_WriteReg(InstancePtr->Control_BaseAddress, XFILTER_PHASE_CONTROL_ADDR_LASTGRP_DATA, Data);
}

u32 XFilter_phase_Get_lastgrp(XFilter_phase *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XFilter_phase_ReadReg(InstancePtr->Control_BaseAddress, XFILTER_PHASE_CONTROL_ADDR_LASTGRP_DATA);
    return Data;
}

