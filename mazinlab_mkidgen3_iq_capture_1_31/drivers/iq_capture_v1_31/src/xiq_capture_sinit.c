// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xiq_capture.h"

extern XIq_capture_Config XIq_capture_ConfigTable[];

XIq_capture_Config *XIq_capture_LookupConfig(u16 DeviceId) {
	XIq_capture_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XIQ_CAPTURE_NUM_INSTANCES; Index++) {
		if (XIq_capture_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XIq_capture_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XIq_capture_Initialize(XIq_capture *InstancePtr, u16 DeviceId) {
	XIq_capture_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XIq_capture_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XIq_capture_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

