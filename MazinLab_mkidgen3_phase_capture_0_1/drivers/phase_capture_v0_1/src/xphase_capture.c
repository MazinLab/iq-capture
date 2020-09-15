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

u32 XPhase_capture_Get_keep_V_BaseAddress(XPhase_capture *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Control_BaseAddress + XPHASE_CAPTURE_CONTROL_ADDR_KEEP_V_BASE);
}

u32 XPhase_capture_Get_keep_V_HighAddress(XPhase_capture *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Control_BaseAddress + XPHASE_CAPTURE_CONTROL_ADDR_KEEP_V_HIGH);
}

u32 XPhase_capture_Get_keep_V_TotalBytes(XPhase_capture *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XPHASE_CAPTURE_CONTROL_ADDR_KEEP_V_HIGH - XPHASE_CAPTURE_CONTROL_ADDR_KEEP_V_BASE + 1);
}

u32 XPhase_capture_Get_keep_V_BitWidth(XPhase_capture *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XPHASE_CAPTURE_CONTROL_WIDTH_KEEP_V;
}

u32 XPhase_capture_Get_keep_V_Depth(XPhase_capture *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XPHASE_CAPTURE_CONTROL_DEPTH_KEEP_V;
}

u32 XPhase_capture_Write_keep_V_Words(XPhase_capture *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XPHASE_CAPTURE_CONTROL_ADDR_KEEP_V_HIGH - XPHASE_CAPTURE_CONTROL_ADDR_KEEP_V_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Control_BaseAddress + XPHASE_CAPTURE_CONTROL_ADDR_KEEP_V_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XPhase_capture_Read_keep_V_Words(XPhase_capture *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XPHASE_CAPTURE_CONTROL_ADDR_KEEP_V_HIGH - XPHASE_CAPTURE_CONTROL_ADDR_KEEP_V_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Control_BaseAddress + XPHASE_CAPTURE_CONTROL_ADDR_KEEP_V_BASE + (offset + i)*4);
    }
    return length;
}

u32 XPhase_capture_Write_keep_V_Bytes(XPhase_capture *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XPHASE_CAPTURE_CONTROL_ADDR_KEEP_V_HIGH - XPHASE_CAPTURE_CONTROL_ADDR_KEEP_V_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Control_BaseAddress + XPHASE_CAPTURE_CONTROL_ADDR_KEEP_V_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XPhase_capture_Read_keep_V_Bytes(XPhase_capture *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XPHASE_CAPTURE_CONTROL_ADDR_KEEP_V_HIGH - XPHASE_CAPTURE_CONTROL_ADDR_KEEP_V_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Control_BaseAddress + XPHASE_CAPTURE_CONTROL_ADDR_KEEP_V_BASE + offset + i);
    }
    return length;
}

