// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xwrite_axi256.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XWrite_axi256_CfgInitialize(XWrite_axi256 *InstancePtr, XWrite_axi256_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XWrite_axi256_Start(XWrite_axi256 *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XWrite_axi256_ReadReg(InstancePtr->Control_BaseAddress, XWRITE_AXI256_CONTROL_ADDR_AP_CTRL) & 0x80;
    XWrite_axi256_WriteReg(InstancePtr->Control_BaseAddress, XWRITE_AXI256_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XWrite_axi256_IsDone(XWrite_axi256 *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XWrite_axi256_ReadReg(InstancePtr->Control_BaseAddress, XWRITE_AXI256_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XWrite_axi256_IsIdle(XWrite_axi256 *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XWrite_axi256_ReadReg(InstancePtr->Control_BaseAddress, XWRITE_AXI256_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XWrite_axi256_IsReady(XWrite_axi256 *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XWrite_axi256_ReadReg(InstancePtr->Control_BaseAddress, XWRITE_AXI256_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XWrite_axi256_EnableAutoRestart(XWrite_axi256 *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XWrite_axi256_WriteReg(InstancePtr->Control_BaseAddress, XWRITE_AXI256_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XWrite_axi256_DisableAutoRestart(XWrite_axi256 *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XWrite_axi256_WriteReg(InstancePtr->Control_BaseAddress, XWRITE_AXI256_CONTROL_ADDR_AP_CTRL, 0);
}

void XWrite_axi256_Set_capturesize(XWrite_axi256 *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XWrite_axi256_WriteReg(InstancePtr->Control_BaseAddress, XWRITE_AXI256_CONTROL_ADDR_CAPTURESIZE_DATA, Data);
}

u32 XWrite_axi256_Get_capturesize(XWrite_axi256 *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XWrite_axi256_ReadReg(InstancePtr->Control_BaseAddress, XWRITE_AXI256_CONTROL_ADDR_CAPTURESIZE_DATA);
    return Data;
}

void XWrite_axi256_Set_iqout(XWrite_axi256 *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XWrite_axi256_WriteReg(InstancePtr->Control_BaseAddress, XWRITE_AXI256_CONTROL_ADDR_IQOUT_DATA, (u32)(Data));
    XWrite_axi256_WriteReg(InstancePtr->Control_BaseAddress, XWRITE_AXI256_CONTROL_ADDR_IQOUT_DATA + 4, (u32)(Data >> 32));
}

u64 XWrite_axi256_Get_iqout(XWrite_axi256 *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XWrite_axi256_ReadReg(InstancePtr->Control_BaseAddress, XWRITE_AXI256_CONTROL_ADDR_IQOUT_DATA);
    Data += (u64)XWrite_axi256_ReadReg(InstancePtr->Control_BaseAddress, XWRITE_AXI256_CONTROL_ADDR_IQOUT_DATA + 4) << 32;
    return Data;
}

void XWrite_axi256_InterruptGlobalEnable(XWrite_axi256 *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XWrite_axi256_WriteReg(InstancePtr->Control_BaseAddress, XWRITE_AXI256_CONTROL_ADDR_GIE, 1);
}

void XWrite_axi256_InterruptGlobalDisable(XWrite_axi256 *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XWrite_axi256_WriteReg(InstancePtr->Control_BaseAddress, XWRITE_AXI256_CONTROL_ADDR_GIE, 0);
}

void XWrite_axi256_InterruptEnable(XWrite_axi256 *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XWrite_axi256_ReadReg(InstancePtr->Control_BaseAddress, XWRITE_AXI256_CONTROL_ADDR_IER);
    XWrite_axi256_WriteReg(InstancePtr->Control_BaseAddress, XWRITE_AXI256_CONTROL_ADDR_IER, Register | Mask);
}

void XWrite_axi256_InterruptDisable(XWrite_axi256 *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XWrite_axi256_ReadReg(InstancePtr->Control_BaseAddress, XWRITE_AXI256_CONTROL_ADDR_IER);
    XWrite_axi256_WriteReg(InstancePtr->Control_BaseAddress, XWRITE_AXI256_CONTROL_ADDR_IER, Register & (~Mask));
}

void XWrite_axi256_InterruptClear(XWrite_axi256 *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XWrite_axi256_WriteReg(InstancePtr->Control_BaseAddress, XWRITE_AXI256_CONTROL_ADDR_ISR, Mask);
}

u32 XWrite_axi256_InterruptGetEnabled(XWrite_axi256 *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XWrite_axi256_ReadReg(InstancePtr->Control_BaseAddress, XWRITE_AXI256_CONTROL_ADDR_IER);
}

u32 XWrite_axi256_InterruptGetStatus(XWrite_axi256 *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XWrite_axi256_ReadReg(InstancePtr->Control_BaseAddress, XWRITE_AXI256_CONTROL_ADDR_ISR);
}

