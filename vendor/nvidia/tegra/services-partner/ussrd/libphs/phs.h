/*
 * Copyright (c) 2013-2015, NVIDIA CORPORATION.  All rights reserved.
 *
 * NVIDIA CORPORATION and its licensors retain all intellectual property
 * and proprietary rights in and to this software, related documentation
 * and any modifications thereto.  Any use, reproduction, disclosure or
 * distribution of this software and related documentation without an express
 * license agreement from NVIDIA CORPORATION is strictly prohibited
 */
#ifndef INCLUDED_PHS_H
#define INCLUDED_PHS_H

#if defined(__cplusplus)
extern "C"
{
#endif

#include <stdint.h>

typedef enum
{
    NvUsecase_NULL          = 0x00000000,
    NvUsecase_FIRST         = 0x00000001,

    NvUsecase_generic       = 0x00000001,
    NvUsecase_graphics      = 0x00000002,
    NvUsecase_camera        = 0x00000004,
    NvUsecase_video         = 0x00000008,
    NvUsecase_gpucompute    = 0x00000010,
    NvUsecase_ui            = 0x00000020,

    NvUsecase_LAST          = NvUsecase_ui,
    NvUsecase_ANY           = 0x7fffffff,
    NvUsecase_Force32       = 0x7fffffff
} NvUsecase;

typedef enum
{
    NvHintType_FIRST                = 0,

    NvHintType_ThroughputHint       = 0,
    NvHintType_FramerateTarget      = 1,
    NvHintType_MinCPU               = 2,
    NvHintType_MaxCPU               = 3,
    NvHintType_MinGPU               = 4,
    NvHintType_MaxGPU               = 5,
    NvHintType_GPUComputation       = 6,
    NvHintType_FramerateMinimum     = 7,
    NvHintType_AppIdletime          = 8,
    NvHintType_EglAvgFrameProctime  = 9,
    NvHintType_EglMaxFrameProctime  = 10,
    NvHintType_EglFrameTimestamp    = 11,
    NvHintType_EglBufferQueueLength = 12,
    NvHintType_CaptureQueueSize     = 13,
    NvHintType_TransientCpuLoad     = 14,

    NvHintType_LAST_PLUS_ONE,
    NvHintType_LAST                 = NvHintType_LAST_PLUS_ONE-1,
    NvHintType_LastReserved         = 63,
    NvHintType_Force32              = 0x7FFFFFFF
} NvHintType;

#define NVHINTTYPE_NO_TYPE ((NvHintType)-1)
#define NVHINT_TIMEOUT_ONCE 0
#define NVHINT_DEFAULT_TAG 0x00000000U
#define NVHINT_INVALID_TAG 0xffffffffU

#define PHS_FLAG_SYNCHRONOUS (1 << 0)
#define PHS_FLAG_IMMEDIATE  (1 << 1)

int NvPHSSendThroughputHints (uint32_t client_tag, uint32_t flags, ...);
void NvPHSCancelThroughputHints (uint32_t client_tag, NvUsecase usecase);
int NvPHSSetThrottle (uint32_t client_tag, uint32_t interval_ms);
int NvPHSIsChannelOpen (void);

NvUsecase NvPHSMuteUsecases (NvUsecase usecases_mask);
NvUsecase NvPHSUnmuteUsecases (NvUsecase usecases_mask);
int NvPHSMuteHintType (NvHintType type);
int NvPHSUnmuteHintType (NvHintType type);

/*****************************************************************************/
/* TO BE DEPRECATED */
int NvVaSendThroughputHints (uint32_t client_tag, ...);
/* TO BE DEPRECATED */
void NvCancelThroughputHints (uint32_t client_tag, NvUsecase usecase);
/* TO BE DEPRECATED */
static inline int NvSendThroughputHint (NvUsecase usecase, NvHintType type, uint32_t value, uint32_t timeout_ms)
{
    return NvPHSSendThroughputHints(NVHINT_DEFAULT_TAG, 0, usecase, type, value, timeout_ms, NvUsecase_NULL);
}
/* TO BE DEPRECATED */
static inline void NvCancelThroughputHint (NvUsecase usecase)
{
    NvPHSCancelThroughputHints(NVHINT_DEFAULT_TAG, usecase);
}
/*****************************************************************************/

#if defined(__cplusplus)
}
#endif

#endif // INCLUDED_PHS_H
