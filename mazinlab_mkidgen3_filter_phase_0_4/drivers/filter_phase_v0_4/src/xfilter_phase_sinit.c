// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xfilter_phase.h"

extern XFilter_phase_Config XFilter_phase_ConfigTable[];

XFilter_phase_Config *XFilter_phase_LookupConfig(u16 DeviceId) {
	XFilter_phase_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XFILTER_PHASE_NUM_INSTANCES; Index++) {
		if (XFilter_phase_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XFilter_phase_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XFilter_phase_Initialize(XFilter_phase *InstancePtr, u16 DeviceId) {
	XFilter_phase_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XFilter_phase_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XFilter_phase_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

