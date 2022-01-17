// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xwrite_axi256.h"

extern XWrite_axi256_Config XWrite_axi256_ConfigTable[];

XWrite_axi256_Config *XWrite_axi256_LookupConfig(u16 DeviceId) {
	XWrite_axi256_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XWRITE_AXI256_NUM_INSTANCES; Index++) {
		if (XWrite_axi256_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XWrite_axi256_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XWrite_axi256_Initialize(XWrite_axi256 *InstancePtr, u16 DeviceId) {
	XWrite_axi256_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XWrite_axi256_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XWrite_axi256_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

