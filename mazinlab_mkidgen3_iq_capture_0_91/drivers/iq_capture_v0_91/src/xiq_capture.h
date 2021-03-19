// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.1.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XIQ_CAPTURE_H
#define XIQ_CAPTURE_H

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
#include "xiq_capture_hw.h"

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
} XIq_capture_Config;
#endif

typedef struct {
    u32 Control_BaseAddress;
    u32 IsReady;
} XIq_capture;

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
} XIq_capture_Keep;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XIq_capture_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XIq_capture_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XIq_capture_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XIq_capture_ReadReg(BaseAddress, RegOffset) \
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
int XIq_capture_Initialize(XIq_capture *InstancePtr, u16 DeviceId);
XIq_capture_Config* XIq_capture_LookupConfig(u16 DeviceId);
int XIq_capture_CfgInitialize(XIq_capture *InstancePtr, XIq_capture_Config *ConfigPtr);
#else
int XIq_capture_Initialize(XIq_capture *InstancePtr, const char* InstanceName);
int XIq_capture_Release(XIq_capture *InstancePtr);
#endif

void XIq_capture_Start(XIq_capture *InstancePtr);
u32 XIq_capture_IsDone(XIq_capture *InstancePtr);
u32 XIq_capture_IsIdle(XIq_capture *InstancePtr);
u32 XIq_capture_IsReady(XIq_capture *InstancePtr);
void XIq_capture_EnableAutoRestart(XIq_capture *InstancePtr);
void XIq_capture_DisableAutoRestart(XIq_capture *InstancePtr);

void XIq_capture_Set_keep(XIq_capture *InstancePtr, XIq_capture_Keep Data);
XIq_capture_Keep XIq_capture_Get_keep(XIq_capture *InstancePtr);
void XIq_capture_Set_total_capturesize(XIq_capture *InstancePtr, u64 Data);
u64 XIq_capture_Get_total_capturesize(XIq_capture *InstancePtr);
void XIq_capture_Set_capturesize(XIq_capture *InstancePtr, u32 Data);
u32 XIq_capture_Get_capturesize(XIq_capture *InstancePtr);
void XIq_capture_Set_iqout(XIq_capture *InstancePtr, u64 Data);
u64 XIq_capture_Get_iqout(XIq_capture *InstancePtr);

void XIq_capture_InterruptGlobalEnable(XIq_capture *InstancePtr);
void XIq_capture_InterruptGlobalDisable(XIq_capture *InstancePtr);
void XIq_capture_InterruptEnable(XIq_capture *InstancePtr, u32 Mask);
void XIq_capture_InterruptDisable(XIq_capture *InstancePtr, u32 Mask);
void XIq_capture_InterruptClear(XIq_capture *InstancePtr, u32 Mask);
u32 XIq_capture_InterruptGetEnabled(XIq_capture *InstancePtr);
u32 XIq_capture_InterruptGetStatus(XIq_capture *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
