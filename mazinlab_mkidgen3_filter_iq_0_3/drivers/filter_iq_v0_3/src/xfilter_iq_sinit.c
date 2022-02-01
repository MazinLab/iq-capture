// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xfilter_iq.h"

extern XFilter_iq_Config XFilter_iq_ConfigTable[];

XFilter_iq_Config *XFilter_iq_LookupConfig(u16 DeviceId) {
	XFilter_iq_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XFILTER_IQ_NUM_INSTANCES; Index++) {
		if (XFilter_iq_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XFilter_iq_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XFilter_iq_Initialize(XFilter_iq *InstancePtr, u16 DeviceId) {
	XFilter_iq_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XFilter_iq_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XFilter_iq_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

