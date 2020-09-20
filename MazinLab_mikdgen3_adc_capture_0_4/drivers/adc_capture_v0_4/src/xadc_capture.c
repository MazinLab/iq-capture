// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2.1 (64-bit)
// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
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

void XAdc_capture_Set_capturesize_V(XAdc_capture *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAdc_capture_WriteReg(InstancePtr->Control_BaseAddress, XADC_CAPTURE_CONTROL_ADDR_CAPTURESIZE_V_DATA, Data);
}

u32 XAdc_capture_Get_capturesize_V(XAdc_capture *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XAdc_capture_ReadReg(InstancePtr->Control_BaseAddress, XADC_CAPTURE_CONTROL_ADDR_CAPTURESIZE_V_DATA);
    return Data;
}

void XAdc_capture_Set_configure(XAdc_capture *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAdc_capture_WriteReg(InstancePtr->Control_BaseAddress, XADC_CAPTURE_CONTROL_ADDR_CONFIGURE_DATA, Data);
}

u32 XAdc_capture_Get_configure(XAdc_capture *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XAdc_capture_ReadReg(InstancePtr->Control_BaseAddress, XADC_CAPTURE_CONTROL_ADDR_CONFIGURE_DATA);
    return Data;
}

