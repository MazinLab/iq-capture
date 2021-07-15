// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xadc_capture.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XAdc_capture_CfgInitialize(XAdc_capture *InstancePtr, XAdc_capture_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XAdc_capture_Start(XAdc_capture *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XAdc_capture_ReadReg(InstancePtr->Control_BaseAddress, XADC_CAPTURE_CONTROL_ADDR_AP_CTRL) & 0x80;
    XAdc_capture_WriteReg(InstancePtr->Control_BaseAddress, XADC_CAPTURE_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XAdc_capture_IsDone(XAdc_capture *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XAdc_capture_ReadReg(InstancePtr->Control_BaseAddress, XADC_CAPTURE_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XAdc_capture_IsIdle(XAdc_capture *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XAdc_capture_ReadReg(InstancePtr->Control_BaseAddress, XADC_CAPTURE_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XAdc_capture_IsReady(XAdc_capture *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XAdc_capture_ReadReg(InstancePtr->Control_BaseAddress, XADC_CAPTURE_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XAdc_capture_EnableAutoRestart(XAdc_capture *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAdc_capture_WriteReg(InstancePtr->Control_BaseAddress, XADC_CAPTURE_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XAdc_capture_DisableAutoRestart(XAdc_capture *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAdc_capture_WriteReg(InstancePtr->Control_BaseAddress, XADC_CAPTURE_CONTROL_ADDR_AP_CTRL, 0);
}

void XAdc_capture_Set_capturesize(XAdc_capture *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAdc_capture_WriteReg(InstancePtr->Control_BaseAddress, XADC_CAPTURE_CONTROL_ADDR_CAPTURESIZE_DATA, Data);
}

u32 XAdc_capture_Get_capturesize(XAdc_capture *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XAdc_capture_ReadReg(InstancePtr->Control_BaseAddress, XADC_CAPTURE_CONTROL_ADDR_CAPTURESIZE_DATA);
    return Data;
}

void XAdc_capture_Set_iqout(XAdc_capture *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAdc_capture_WriteReg(InstancePtr->Control_BaseAddress, XADC_CAPTURE_CONTROL_ADDR_IQOUT_DATA, (u32)(Data));
    XAdc_capture_WriteReg(InstancePtr->Control_BaseAddress, XADC_CAPTURE_CONTROL_ADDR_IQOUT_DATA + 4, (u32)(Data >> 32));
}

u64 XAdc_capture_Get_iqout(XAdc_capture *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XAdc_capture_ReadReg(InstancePtr->Control_BaseAddress, XADC_CAPTURE_CONTROL_ADDR_IQOUT_DATA);
    Data += (u64)XAdc_capture_ReadReg(InstancePtr->Control_BaseAddress, XADC_CAPTURE_CONTROL_ADDR_IQOUT_DATA + 4) << 32;
    return Data;
}

void XAdc_capture_InterruptGlobalEnable(XAdc_capture *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAdc_capture_WriteReg(InstancePtr->Control_BaseAddress, XADC_CAPTURE_CONTROL_ADDR_GIE, 1);
}

void XAdc_capture_InterruptGlobalDisable(XAdc_capture *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAdc_capture_WriteReg(InstancePtr->Control_BaseAddress, XADC_CAPTURE_CONTROL_ADDR_GIE, 0);
}

void XAdc_capture_InterruptEnable(XAdc_capture *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XAdc_capture_ReadReg(InstancePtr->Control_BaseAddress, XADC_CAPTURE_CONTROL_ADDR_IER);
    XAdc_capture_WriteReg(InstancePtr->Control_BaseAddress, XADC_CAPTURE_CONTROL_ADDR_IER, Register | Mask);
}

void XAdc_capture_InterruptDisable(XAdc_capture *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XAdc_capture_ReadReg(InstancePtr->Control_BaseAddress, XADC_CAPTURE_CONTROL_ADDR_IER);
    XAdc_capture_WriteReg(InstancePtr->Control_BaseAddress, XADC_CAPTURE_CONTROL_ADDR_IER, Register & (~Mask));
}

void XAdc_capture_InterruptClear(XAdc_capture *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAdc_capture_WriteReg(InstancePtr->Control_BaseAddress, XADC_CAPTURE_CONTROL_ADDR_ISR, Mask);
}

u32 XAdc_capture_InterruptGetEnabled(XAdc_capture *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XAdc_capture_ReadReg(InstancePtr->Control_BaseAddress, XADC_CAPTURE_CONTROL_ADDR_IER);
}

u32 XAdc_capture_InterruptGetStatus(XAdc_capture *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XAdc_capture_ReadReg(InstancePtr->Control_BaseAddress, XADC_CAPTURE_CONTROL_ADDR_ISR);
}

