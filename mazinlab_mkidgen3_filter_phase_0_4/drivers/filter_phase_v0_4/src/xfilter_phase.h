// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XFILTER_PHASE_H
#define XFILTER_PHASE_H

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
#include "xfilter_phase_hw.h"

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
} XFilter_phase_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XFilter_phase;

typedef u32 word_type;

typedef struct {
    u32 word_0;
    u32 word_1;
    u32 word_2;
    u32 word_3;
} XFilter_phase_Keep;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XFilter_phase_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XFilter_phase_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XFilter_phase_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XFilter_phase_ReadReg(BaseAddress, RegOffset) \
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
int XFilter_phase_Initialize(XFilter_phase *InstancePtr, u16 DeviceId);
XFilter_phase_Config* XFilter_phase_LookupConfig(u16 DeviceId);
int XFilter_phase_CfgInitialize(XFilter_phase *InstancePtr, XFilter_phase_Config *ConfigPtr);
#else
int XFilter_phase_Initialize(XFilter_phase *InstancePtr, const char* InstanceName);
int XFilter_phase_Release(XFilter_phase *InstancePtr);
#endif


void XFilter_phase_Set_keep(XFilter_phase *InstancePtr, XFilter_phase_Keep Data);
XFilter_phase_Keep XFilter_phase_Get_keep(XFilter_phase *InstancePtr);
void XFilter_phase_Set_lastgrp(XFilter_phase *InstancePtr, u32 Data);
u32 XFilter_phase_Get_lastgrp(XFilter_phase *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
