// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2.1 (64-bit)
// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xadc_capture.h"

extern XAdc_capture_Config XAdc_capture_ConfigTable[];

XAdc_capture_Config *XAdc_capture_LookupConfig(u16 DeviceId) {
	XAdc_capture_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XADC_CAPTURE_NUM_INSTANCES; Index++) {
		if (XAdc_capture_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XAdc_capture_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XAdc_capture_Initialize(XAdc_capture *InstancePtr, u16 DeviceId) {
	XAdc_capture_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XAdc_capture_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XAdc_capture_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

