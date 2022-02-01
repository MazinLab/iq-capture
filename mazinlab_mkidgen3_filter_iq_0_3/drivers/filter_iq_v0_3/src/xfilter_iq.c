// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xfilter_iq.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XFilter_iq_CfgInitialize(XFilter_iq *InstancePtr, XFilter_iq_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XFilter_iq_Set_keep(XFilter_iq *InstancePtr, XFilter_iq_Keep Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XFilter_iq_WriteReg(InstancePtr->Control_BaseAddress, XFILTER_IQ_CONTROL_ADDR_KEEP_DATA + 0, Data.word_0);
    XFilter_iq_WriteReg(InstancePtr->Control_BaseAddress, XFILTER_IQ_CONTROL_ADDR_KEEP_DATA + 4, Data.word_1);
    XFilter_iq_WriteReg(InstancePtr->Control_BaseAddress, XFILTER_IQ_CONTROL_ADDR_KEEP_DATA + 8, Data.word_2);
    XFilter_iq_WriteReg(InstancePtr->Control_BaseAddress, XFILTER_IQ_CONTROL_ADDR_KEEP_DATA + 12, Data.word_3);
    XFilter_iq_WriteReg(InstancePtr->Control_BaseAddress, XFILTER_IQ_CONTROL_ADDR_KEEP_DATA + 16, Data.word_4);
    XFilter_iq_WriteReg(InstancePtr->Control_BaseAddress, XFILTER_IQ_CONTROL_ADDR_KEEP_DATA + 20, Data.word_5);
    XFilter_iq_WriteReg(InstancePtr->Control_BaseAddress, XFILTER_IQ_CONTROL_ADDR_KEEP_DATA + 24, Data.word_6);
    XFilter_iq_WriteReg(InstancePtr->Control_BaseAddress, XFILTER_IQ_CONTROL_ADDR_KEEP_DATA + 28, Data.word_7);
}

XFilter_iq_Keep XFilter_iq_Get_keep(XFilter_iq *InstancePtr) {
    XFilter_iq_Keep Data;

    Data.word_0 = XFilter_iq_ReadReg(InstancePtr->Control_BaseAddress, XFILTER_IQ_CONTROL_ADDR_KEEP_DATA + 0);
    Data.word_1 = XFilter_iq_ReadReg(InstancePtr->Control_BaseAddress, XFILTER_IQ_CONTROL_ADDR_KEEP_DATA + 4);
    Data.word_2 = XFilter_iq_ReadReg(InstancePtr->Control_BaseAddress, XFILTER_IQ_CONTROL_ADDR_KEEP_DATA + 8);
    Data.word_3 = XFilter_iq_ReadReg(InstancePtr->Control_BaseAddress, XFILTER_IQ_CONTROL_ADDR_KEEP_DATA + 12);
    Data.word_4 = XFilter_iq_ReadReg(InstancePtr->Control_BaseAddress, XFILTER_IQ_CONTROL_ADDR_KEEP_DATA + 16);
    Data.word_5 = XFilter_iq_ReadReg(InstancePtr->Control_BaseAddress, XFILTER_IQ_CONTROL_ADDR_KEEP_DATA + 20);
    Data.word_6 = XFilter_iq_ReadReg(InstancePtr->Control_BaseAddress, XFILTER_IQ_CONTROL_ADDR_KEEP_DATA + 24);
    Data.word_7 = XFilter_iq_ReadReg(InstancePtr->Control_BaseAddress, XFILTER_IQ_CONTROL_ADDR_KEEP_DATA + 28);
    return Data;
}

void XFilter_iq_Set_lastgrp(XFilter_iq *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XFilter_iq_WriteReg(InstancePtr->Control_BaseAddress, XFILTER_IQ_CONTROL_ADDR_LASTGRP_DATA, Data);
}

u32 XFilter_iq_Get_lastgrp(XFilter_iq *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XFilter_iq_ReadReg(InstancePtr->Control_BaseAddress, XFILTER_IQ_CONTROL_ADDR_LASTGRP_DATA);
    return Data;
}

