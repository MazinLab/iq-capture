// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2.1 (64-bit)
// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xphase_capture.h"

extern XPhase_capture_Config XPhase_capture_ConfigTable[];

XPhase_capture_Config *XPhase_capture_LookupConfig(u16 DeviceId) {
	XPhase_capture_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XPHASE_CAPTURE_NUM_INSTANCES; Index++) {
		if (XPhase_capture_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XPhase_capture_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XPhase_capture_Initialize(XPhase_capture *InstancePtr, u16 DeviceId) {
	XPhase_capture_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XPhase_capture_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XPhase_capture_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

