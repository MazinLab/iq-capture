// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2.1 (64-bit)
// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xphase_capture.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XPhase_capture_CfgInitialize(XPhase_capture *InstancePtr, XPhase_capture_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XPhase_capture_Set_keep_V(XPhase_capture *InstancePtr, XPhase_capture_Keep_v Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XPhase_capture_WriteReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_V_DATA + 0, Data.word_0);
    XPhase_capture_WriteReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_V_DATA + 4, Data.word_1);
    XPhase_capture_WriteReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_V_DATA + 8, Data.word_2);
    XPhase_capture_WriteReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_V_DATA + 12, Data.word_3);
    XPhase_capture_WriteReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_V_DATA + 16, Data.word_4);
    XPhase_capture_WriteReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_V_DATA + 20, Data.word_5);
    XPhase_capture_WriteReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_V_DATA + 24, Data.word_6);
    XPhase_capture_WriteReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_V_DATA + 28, Data.word_7);
}

XPhase_capture_Keep_v XPhase_capture_Get_keep_V(XPhase_capture *InstancePtr) {
    XPhase_capture_Keep_v Data;

    Data.word_0 = XPhase_capture_ReadReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_V_DATA + 0);
    Data.word_1 = XPhase_capture_ReadReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_V_DATA + 4);
    Data.word_2 = XPhase_capture_ReadReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_V_DATA + 8);
    Data.word_3 = XPhase_capture_ReadReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_V_DATA + 12);
    Data.word_4 = XPhase_capture_ReadReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_V_DATA + 16);
    Data.word_5 = XPhase_capture_ReadReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_V_DATA + 20);
    Data.word_6 = XPhase_capture_ReadReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_V_DATA + 24);
    Data.word_7 = XPhase_capture_ReadReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_V_DATA + 28);
    return Data;
}

void XPhase_capture_Set_capturesize_V(XPhase_capture *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XPhase_capture_WriteReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_CAPTURESIZE_V_DATA, Data);
}

u32 XPhase_capture_Get_capturesize_V(XPhase_capture *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XPhase_capture_ReadReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_CAPTURESIZE_V_DATA);
    return Data;
}

void XPhase_capture_Set_configure(XPhase_capture *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XPhase_capture_WriteReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_CONFIGURE_DATA, Data);
}

u32 XPhase_capture_Get_configure(XPhase_capture *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XPhase_capture_ReadReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_CONFIGURE_DATA);
    return Data;
}

