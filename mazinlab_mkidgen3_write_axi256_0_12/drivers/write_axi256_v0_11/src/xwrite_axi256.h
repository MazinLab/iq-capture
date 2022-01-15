// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XWRITE_AXI256_H
#define XWRITE_AXI256_H

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
#include "xwrite_axi256_hw.h"

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
} XWrite_axi256_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XWrite_axi256;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XWrite_axi256_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XWrite_axi256_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XWrite_axi256_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XWrite_axi256_ReadReg(BaseAddress, RegOffset) \
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
int XWrite_axi256_Initialize(XWrite_axi256 *InstancePtr, u16 DeviceId);
XWrite_axi256_Config* XWrite_axi256_LookupConfig(u16 DeviceId);
int XWrite_axi256_CfgInitialize(XWrite_axi256 *InstancePtr, XWrite_axi256_Config *ConfigPtr);
#else
int XWrite_axi256_Initialize(XWrite_axi256 *InstancePtr, const char* InstanceName);
int XWrite_axi256_Release(XWrite_axi256 *InstancePtr);
#endif

void XWrite_axi256_Start(XWrite_axi256 *InstancePtr);
u32 XWrite_axi256_IsDone(XWrite_axi256 *InstancePtr);
u32 XWrite_axi256_IsIdle(XWrite_axi256 *InstancePtr);
u32 XWrite_axi256_IsReady(XWrite_axi256 *InstancePtr);
void XWrite_axi256_EnableAutoRestart(XWrite_axi256 *InstancePtr);
void XWrite_axi256_DisableAutoRestart(XWrite_axi256 *InstancePtr);

void XWrite_axi256_Set_capturesize(XWrite_axi256 *InstancePtr, u32 Data);
u32 XWrite_axi256_Get_capturesize(XWrite_axi256 *InstancePtr);
void XWrite_axi256_Set_iqout(XWrite_axi256 *InstancePtr, u64 Data);
u64 XWrite_axi256_Get_iqout(XWrite_axi256 *InstancePtr);

void XWrite_axi256_InterruptGlobalEnable(XWrite_axi256 *InstancePtr);
void XWrite_axi256_InterruptGlobalDisable(XWrite_axi256 *InstancePtr);
void XWrite_axi256_InterruptEnable(XWrite_axi256 *InstancePtr, u32 Mask);
void XWrite_axi256_InterruptDisable(XWrite_axi256 *InstancePtr, u32 Mask);
void XWrite_axi256_InterruptClear(XWrite_axi256 *InstancePtr, u32 Mask);
u32 XWrite_axi256_InterruptGetEnabled(XWrite_axi256 *InstancePtr);
u32 XWrite_axi256_InterruptGetStatus(XWrite_axi256 *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
