// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XFILTER_IQ_H
#define XFILTER_IQ_H

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
#include "xfilter_iq_hw.h"

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
} XFilter_iq_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XFilter_iq;

typedef u32 word_type;

typedef struct {
    u32 word_0;
    u32 word_1;
    u32 word_2;
    u32 word_3;
    u32 word_4;
    u32 word_5;
    u32 word_6;
    u32 word_7;
} XFilter_iq_Keep;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XFilter_iq_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XFilter_iq_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XFilter_iq_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XFilter_iq_ReadReg(BaseAddress, RegOffset) \
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
int XFilter_iq_Initialize(XFilter_iq *InstancePtr, u16 DeviceId);
XFilter_iq_Config* XFilter_iq_LookupConfig(u16 DeviceId);
int XFilter_iq_CfgInitialize(XFilter_iq *InstancePtr, XFilter_iq_Config *ConfigPtr);
#else
int XFilter_iq_Initialize(XFilter_iq *InstancePtr, const char* InstanceName);
int XFilter_iq_Release(XFilter_iq *InstancePtr);
#endif


void XFilter_iq_Set_keep(XFilter_iq *InstancePtr, XFilter_iq_Keep Data);
XFilter_iq_Keep XFilter_iq_Get_keep(XFilter_iq *InstancePtr);
void XFilter_iq_Set_lastgrp(XFilter_iq *InstancePtr, u32 Data);
u32 XFilter_iq_Get_lastgrp(XFilter_iq *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
