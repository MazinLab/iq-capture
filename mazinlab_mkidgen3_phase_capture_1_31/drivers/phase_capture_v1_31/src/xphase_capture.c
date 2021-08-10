// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
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

void XPhase_capture_Start(XPhase_capture *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XPhase_capture_ReadReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_AP_CTRL) & 0x80;
    XPhase_capture_WriteReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XPhase_capture_IsDone(XPhase_capture *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XPhase_capture_ReadReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XPhase_capture_IsIdle(XPhase_capture *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XPhase_capture_ReadReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XPhase_capture_IsReady(XPhase_capture *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XPhase_capture_ReadReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XPhase_capture_EnableAutoRestart(XPhase_capture *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XPhase_capture_WriteReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XPhase_capture_DisableAutoRestart(XPhase_capture *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XPhase_capture_WriteReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_AP_CTRL, 0);
}

void XPhase_capture_Set_keep(XPhase_capture *InstancePtr, XPhase_capture_Keep Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XPhase_capture_WriteReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_DATA + 0, Data.word_0);
    XPhase_capture_WriteReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_DATA + 4, Data.word_1);
    XPhase_capture_WriteReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_DATA + 8, Data.word_2);
    XPhase_capture_WriteReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_DATA + 12, Data.word_3);
    XPhase_capture_WriteReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_DATA + 16, Data.word_4);
    XPhase_capture_WriteReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_DATA + 20, Data.word_5);
    XPhase_capture_WriteReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_DATA + 24, Data.word_6);
    XPhase_capture_WriteReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_DATA + 28, Data.word_7);
    XPhase_capture_WriteReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_DATA + 32, Data.word_8);
    XPhase_capture_WriteReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_DATA + 36, Data.word_9);
    XPhase_capture_WriteReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_DATA + 40, Data.word_10);
    XPhase_capture_WriteReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_DATA + 44, Data.word_11);
    XPhase_capture_WriteReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_DATA + 48, Data.word_12);
    XPhase_capture_WriteReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_DATA + 52, Data.word_13);
    XPhase_capture_WriteReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_DATA + 56, Data.word_14);
    XPhase_capture_WriteReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_DATA + 60, Data.word_15);
}

XPhase_capture_Keep XPhase_capture_Get_keep(XPhase_capture *InstancePtr) {
    XPhase_capture_Keep Data;

    Data.word_0 = XPhase_capture_ReadReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_DATA + 0);
    Data.word_1 = XPhase_capture_ReadReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_DATA + 4);
    Data.word_2 = XPhase_capture_ReadReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_DATA + 8);
    Data.word_3 = XPhase_capture_ReadReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_DATA + 12);
    Data.word_4 = XPhase_capture_ReadReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_DATA + 16);
    Data.word_5 = XPhase_capture_ReadReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_DATA + 20);
    Data.word_6 = XPhase_capture_ReadReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_DATA + 24);
    Data.word_7 = XPhase_capture_ReadReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_DATA + 28);
    Data.word_8 = XPhase_capture_ReadReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_DATA + 32);
    Data.word_9 = XPhase_capture_ReadReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_DATA + 36);
    Data.word_10 = XPhase_capture_ReadReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_DATA + 40);
    Data.word_11 = XPhase_capture_ReadReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_DATA + 44);
    Data.word_12 = XPhase_capture_ReadReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_DATA + 48);
    Data.word_13 = XPhase_capture_ReadReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_DATA + 52);
    Data.word_14 = XPhase_capture_ReadReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_DATA + 56);
    Data.word_15 = XPhase_capture_ReadReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_KEEP_DATA + 60);
    return Data;
}

void XPhase_capture_Set_total_capturesize(XPhase_capture *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XPhase_capture_WriteReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_TOTAL_CAPTURESIZE_DATA, (u32)(Data));
    XPhase_capture_WriteReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_TOTAL_CAPTURESIZE_DATA + 4, (u32)(Data >> 32));
}

u64 XPhase_capture_Get_total_capturesize(XPhase_capture *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XPhase_capture_ReadReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_TOTAL_CAPTURESIZE_DATA);
    Data += (u64)XPhase_capture_ReadReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_TOTAL_CAPTURESIZE_DATA + 4) << 32;
    return Data;
}

void XPhase_capture_Set_capturesize(XPhase_capture *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XPhase_capture_WriteReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_CAPTURESIZE_DATA, Data);
}

u32 XPhase_capture_Get_capturesize(XPhase_capture *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XPhase_capture_ReadReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_CAPTURESIZE_DATA);
    return Data;
}

void XPhase_capture_Set_out_r(XPhase_capture *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XPhase_capture_WriteReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_OUT_R_DATA, (u32)(Data));
    XPhase_capture_WriteReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_OUT_R_DATA + 4, (u32)(Data >> 32));
}

u64 XPhase_capture_Get_out_r(XPhase_capture *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XPhase_capture_ReadReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_OUT_R_DATA);
    Data += (u64)XPhase_capture_ReadReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_OUT_R_DATA + 4) << 32;
    return Data;
}

void XPhase_capture_InterruptGlobalEnable(XPhase_capture *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XPhase_capture_WriteReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_GIE, 1);
}

void XPhase_capture_InterruptGlobalDisable(XPhase_capture *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XPhase_capture_WriteReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_GIE, 0);
}

void XPhase_capture_InterruptEnable(XPhase_capture *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XPhase_capture_ReadReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_IER);
    XPhase_capture_WriteReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_IER, Register | Mask);
}

void XPhase_capture_InterruptDisable(XPhase_capture *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XPhase_capture_ReadReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_IER);
    XPhase_capture_WriteReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_IER, Register & (~Mask));
}

void XPhase_capture_InterruptClear(XPhase_capture *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XPhase_capture_WriteReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_ISR, Mask);
}

u32 XPhase_capture_InterruptGetEnabled(XPhase_capture *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XPhase_capture_ReadReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_IER);
}

u32 XPhase_capture_InterruptGetStatus(XPhase_capture *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XPhase_capture_ReadReg(InstancePtr->Control_BaseAddress, XPHASE_CAPTURE_CONTROL_ADDR_ISR);
}

