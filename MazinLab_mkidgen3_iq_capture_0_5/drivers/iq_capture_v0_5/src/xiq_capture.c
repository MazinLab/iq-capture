// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2.1 (64-bit)
// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xiq_capture.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XIq_capture_CfgInitialize(XIq_capture *InstancePtr, XIq_capture_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XIq_capture_Set_keep_V(XIq_capture *InstancePtr, XIq_capture_Keep_v Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XIq_capture_WriteReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_KEEP_V_DATA + 0, Data.word_0);
    XIq_capture_WriteReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_KEEP_V_DATA + 4, Data.word_1);
    XIq_capture_WriteReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_KEEP_V_DATA + 8, Data.word_2);
    XIq_capture_WriteReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_KEEP_V_DATA + 12, Data.word_3);
    XIq_capture_WriteReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_KEEP_V_DATA + 16, Data.word_4);
    XIq_capture_WriteReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_KEEP_V_DATA + 20, Data.word_5);
    XIq_capture_WriteReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_KEEP_V_DATA + 24, Data.word_6);
    XIq_capture_WriteReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_KEEP_V_DATA + 28, Data.word_7);
}

XIq_capture_Keep_v XIq_capture_Get_keep_V(XIq_capture *InstancePtr) {
    XIq_capture_Keep_v Data;

    Data.word_0 = XIq_capture_ReadReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_KEEP_V_DATA + 0);
    Data.word_1 = XIq_capture_ReadReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_KEEP_V_DATA + 4);
    Data.word_2 = XIq_capture_ReadReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_KEEP_V_DATA + 8);
    Data.word_3 = XIq_capture_ReadReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_KEEP_V_DATA + 12);
    Data.word_4 = XIq_capture_ReadReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_KEEP_V_DATA + 16);
    Data.word_5 = XIq_capture_ReadReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_KEEP_V_DATA + 20);
    Data.word_6 = XIq_capture_ReadReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_KEEP_V_DATA + 24);
    Data.word_7 = XIq_capture_ReadReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_KEEP_V_DATA + 28);
    return Data;
}

void XIq_capture_Set_capturesize_V(XIq_capture *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XIq_capture_WriteReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_CAPTURESIZE_V_DATA, Data);
}

u32 XIq_capture_Get_capturesize_V(XIq_capture *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XIq_capture_ReadReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_CAPTURESIZE_V_DATA);
    return Data;
}

void XIq_capture_Set_configure(XIq_capture *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XIq_capture_WriteReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_CONFIGURE_DATA, Data);
}

u32 XIq_capture_Get_configure(XIq_capture *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XIq_capture_ReadReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_CONFIGURE_DATA);
    return Data;
}

