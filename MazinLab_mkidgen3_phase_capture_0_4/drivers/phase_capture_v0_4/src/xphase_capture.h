// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2.1 (64-bit)
// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XPHASE_CAPTURE_H
#define XPHASE_CAPTURE_H

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
#include "xphase_capture_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
#else
typedef struct {
    u16 DeviceId;
    u32 Control_BaseAddress;
} XPhase_capture_Config;
#endif

typedef struct {
    u32 Control_BaseAddress;
    u32 IsReady;
} XPhase_capture;

typedef struct {
    u32 word_0;
    u32 word_1;
    u32 word_2;
    u32 word_3;
    u32 word_4;
    u32 word_5;
    u32 word_6;
    u32 word_7;
} XPhase_capture_Keep_v;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XPhase_capture_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XPhase_capture_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XPhase_capture_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XPhase_capture_ReadReg(BaseAddress, RegOffset) \
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
int XPhase_capture_Initialize(XPhase_capture *InstancePtr, u16 DeviceId);
XPhase_capture_Config* XPhase_capture_LookupConfig(u16 DeviceId);
int XPhase_capture_CfgInitialize(XPhase_capture *InstancePtr, XPhase_capture_Config *ConfigPtr);
#else
int XPhase_capture_Initialize(XPhase_capture *InstancePtr, const char* InstanceName);
int XPhase_capture_Release(XPhase_capture *InstancePtr);
#endif


void XPhase_capture_Set_keep_V(XPhase_capture *InstancePtr, XPhase_capture_Keep_v Data);
XPhase_capture_Keep_v XPhase_capture_Get_keep_V(XPhase_capture *InstancePtr);
void XPhase_capture_Set_capturesize_V(XPhase_capture *InstancePtr, u32 Data);
u32 XPhase_capture_Get_capturesize_V(XPhase_capture *InstancePtr);
void XPhase_capture_Set_configure(XPhase_capture *InstancePtr, u32 Data);
u32 XPhase_capture_Get_configure(XPhase_capture *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
