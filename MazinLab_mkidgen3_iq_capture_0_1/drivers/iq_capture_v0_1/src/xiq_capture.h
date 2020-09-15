// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2.1 (64-bit)
// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
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


void XIq_capture_Set_capturesize_V(XIq_capture *InstancePtr, u32 Data);
u32 XIq_capture_Get_capturesize_V(XIq_capture *InstancePtr);
u32 XIq_capture_Get_keep_V_BaseAddress(XIq_capture *InstancePtr);
u32 XIq_capture_Get_keep_V_HighAddress(XIq_capture *InstancePtr);
u32 XIq_capture_Get_keep_V_TotalBytes(XIq_capture *InstancePtr);
u32 XIq_capture_Get_keep_V_BitWidth(XIq_capture *InstancePtr);
u32 XIq_capture_Get_keep_V_Depth(XIq_capture *InstancePtr);
u32 XIq_capture_Write_keep_V_Words(XIq_capture *InstancePtr, int offset, int *data, int length);
u32 XIq_capture_Read_keep_V_Words(XIq_capture *InstancePtr, int offset, int *data, int length);
u32 XIq_capture_Write_keep_V_Bytes(XIq_capture *InstancePtr, int offset, char *data, int length);
u32 XIq_capture_Read_keep_V_Bytes(XIq_capture *InstancePtr, int offset, char *data, int length);

#ifdef __cplusplus
}
#endif

#endif
