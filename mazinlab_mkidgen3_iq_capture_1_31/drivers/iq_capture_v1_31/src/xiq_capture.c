// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
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

void XIq_capture_Start(XIq_capture *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XIq_capture_ReadReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_AP_CTRL) & 0x80;
    XIq_capture_WriteReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XIq_capture_IsDone(XIq_capture *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XIq_capture_ReadReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XIq_capture_IsIdle(XIq_capture *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XIq_capture_ReadReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XIq_capture_IsReady(XIq_capture *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XIq_capture_ReadReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XIq_capture_EnableAutoRestart(XIq_capture *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XIq_capture_WriteReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XIq_capture_DisableAutoRestart(XIq_capture *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XIq_capture_WriteReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_AP_CTRL, 0);
}

void XIq_capture_Set_keep(XIq_capture *InstancePtr, XIq_capture_Keep Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XIq_capture_WriteReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_KEEP_DATA + 0, Data.word_0);
    XIq_capture_WriteReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_KEEP_DATA + 4, Data.word_1);
    XIq_capture_WriteReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_KEEP_DATA + 8, Data.word_2);
    XIq_capture_WriteReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_KEEP_DATA + 12, Data.word_3);
    XIq_capture_WriteReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_KEEP_DATA + 16, Data.word_4);
    XIq_capture_WriteReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_KEEP_DATA + 20, Data.word_5);
    XIq_capture_WriteReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_KEEP_DATA + 24, Data.word_6);
    XIq_capture_WriteReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_KEEP_DATA + 28, Data.word_7);
}

XIq_capture_Keep XIq_capture_Get_keep(XIq_capture *InstancePtr) {
    XIq_capture_Keep Data;

    Data.word_0 = XIq_capture_ReadReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_KEEP_DATA + 0);
    Data.word_1 = XIq_capture_ReadReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_KEEP_DATA + 4);
    Data.word_2 = XIq_capture_ReadReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_KEEP_DATA + 8);
    Data.word_3 = XIq_capture_ReadReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_KEEP_DATA + 12);
    Data.word_4 = XIq_capture_ReadReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_KEEP_DATA + 16);
    Data.word_5 = XIq_capture_ReadReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_KEEP_DATA + 20);
    Data.word_6 = XIq_capture_ReadReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_KEEP_DATA + 24);
    Data.word_7 = XIq_capture_ReadReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_KEEP_DATA + 28);
    return Data;
}

void XIq_capture_Set_total_capturesize(XIq_capture *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XIq_capture_WriteReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_TOTAL_CAPTURESIZE_DATA, (u32)(Data));
    XIq_capture_WriteReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_TOTAL_CAPTURESIZE_DATA + 4, (u32)(Data >> 32));
}

u64 XIq_capture_Get_total_capturesize(XIq_capture *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XIq_capture_ReadReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_TOTAL_CAPTURESIZE_DATA);
    Data += (u64)XIq_capture_ReadReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_TOTAL_CAPTURESIZE_DATA + 4) << 32;
    return Data;
}

void XIq_capture_Set_capturesize(XIq_capture *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XIq_capture_WriteReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_CAPTURESIZE_DATA, Data);
}

u32 XIq_capture_Get_capturesize(XIq_capture *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XIq_capture_ReadReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_CAPTURESIZE_DATA);
    return Data;
}

void XIq_capture_Set_iqout(XIq_capture *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XIq_capture_WriteReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_IQOUT_DATA, (u32)(Data));
    XIq_capture_WriteReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_IQOUT_DATA + 4, (u32)(Data >> 32));
}

u64 XIq_capture_Get_iqout(XIq_capture *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XIq_capture_ReadReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_IQOUT_DATA);
    Data += (u64)XIq_capture_ReadReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_IQOUT_DATA + 4) << 32;
    return Data;
}

void XIq_capture_InterruptGlobalEnable(XIq_capture *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XIq_capture_WriteReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_GIE, 1);
}

void XIq_capture_InterruptGlobalDisable(XIq_capture *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XIq_capture_WriteReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_GIE, 0);
}

void XIq_capture_InterruptEnable(XIq_capture *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XIq_capture_ReadReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_IER);
    XIq_capture_WriteReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_IER, Register | Mask);
}

void XIq_capture_InterruptDisable(XIq_capture *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XIq_capture_ReadReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_IER);
    XIq_capture_WriteReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_IER, Register & (~Mask));
}

void XIq_capture_InterruptClear(XIq_capture *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XIq_capture_WriteReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_ISR, Mask);
}

u32 XIq_capture_InterruptGetEnabled(XIq_capture *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XIq_capture_ReadReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_IER);
}

u32 XIq_capture_InterruptGetStatus(XIq_capture *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XIq_capture_ReadReg(InstancePtr->Control_BaseAddress, XIQ_CAPTURE_CONTROL_ADDR_ISR);
}

