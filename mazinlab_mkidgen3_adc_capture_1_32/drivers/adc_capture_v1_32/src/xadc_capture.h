// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XADC_CAPTURE_H
#define XADC_CAPTURE_H

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "xadc_capture_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#else
typedef struct {
    u16 DeviceId;
    u32 Control_BaseAddress;
} XAdc_capture_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XAdc_capture;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XAdc_capture_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XAdc_capture_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XAdc_capture_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XAdc_capture_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif

/************************** Function Prototypes *****************************/
#ifndef __linux__
int XAdc_capture_Initialize(XAdc_capture *InstancePtr, u16 DeviceId);
XAdc_capture_Config* XAdc_capture_LookupConfig(u16 DeviceId);
int XAdc_capture_CfgInitialize(XAdc_capture *InstancePtr, XAdc_capture_Config *ConfigPtr);
#else
int XAdc_capture_Initialize(XAdc_capture *InstancePtr, const char* InstanceName);
int XAdc_capture_Release(XAdc_capture *InstancePtr);
#endif

void XAdc_capture_Start(XAdc_capture *InstancePtr);
u32 XAdc_capture_IsDone(XAdc_capture *InstancePtr);
u32 XAdc_capture_IsIdle(XAdc_capture *InstancePtr);
u32 XAdc_capture_IsReady(XAdc_capture *InstancePtr);
void XAdc_capture_EnableAutoRestart(XAdc_capture *InstancePtr);
void XAdc_capture_DisableAutoRestart(XAdc_capture *InstancePtr);

void XAdc_capture_Set_capturesize(XAdc_capture *InstancePtr, u32 Data);
u32 XAdc_capture_Get_capturesize(XAdc_capture *InstancePtr);
void XAdc_capture_Set_iqout(XAdc_capture *InstancePtr, u64 Data);
u64 XAdc_capture_Get_iqout(XAdc_capture *InstancePtr);

void XAdc_capture_InterruptGlobalEnable(XAdc_capture *InstancePtr);
void XAdc_capture_InterruptGlobalDisable(XAdc_capture *InstancePtr);
void XAdc_capture_InterruptEnable(XAdc_capture *InstancePtr, u32 Mask);
void XAdc_capture_InterruptDisable(XAdc_capture *InstancePtr, u32 Mask);
void XAdc_capture_InterruptClear(XAdc_capture *InstancePtr, u32 Mask);
u32 XAdc_capture_InterruptGetEnabled(XAdc_capture *InstancePtr);
u32 XAdc_capture_InterruptGetStatus(XAdc_capture *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
