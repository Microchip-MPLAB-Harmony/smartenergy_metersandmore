/*******************************************************************************
  Company:
    Microchip Technology Inc.

  File Name:
    al_local.h

  Summary:
    Meters And More AL (Application Layer) Local header file.

  Description:
    Meters And More AL (Application Layer) Local header file. This file
    provides definitions and types internally used by AL.
*******************************************************************************/

//DOM-IGNORE-BEGIN
/*
Copyright (C) 2024, Microchip Technology Inc., and its subsidiaries. All rights reserved.

The software and documentation is provided by microchip and its contributors
"as is" and any express, implied or statutory warranties, including, but not
limited to, the implied warranties of merchantability, fitness for a particular
purpose and non-infringement of third party intellectual property rights are
disclaimed to the fullest extent permitted by law. In no event shall microchip
or its contributors be liable for any direct, indirect, incidental, special,
exemplary, or consequential damages (including, but not limited to, procurement
of substitute goods or services; loss of use, data, or profits; or business
interruption) however caused and on any theory of liability, whether in contract,
strict liability, or tort (including negligence or otherwise) arising in any way
out of the use of the software and documentation, even if advised of the
possibility of such damage.

Except as expressly permitted hereunder and subject to the applicable license terms
for any third-party software incorporated in the software and any applicable open
source software license terms, no license or other rights, whether express or
implied, are granted under any patent or other intellectual property rights of
Microchip or any third party.
*/
//DOM-IGNORE-END

#ifndef AL_LOCAL_H    
#define AL_LOCAL_H

/* ************************************************************************** */
/* ************************************************************************** */
/* Section: Included Files                                                    */
/* ************************************************************************** */
/* ************************************************************************** */
#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>
#include "al.h"

/* Provide C++ Compatibility */
#ifdef __cplusplus
extern "C" {
#endif

#define AL_INSTANCES_NUMBER     1U

#define CMAC_LENGTH             16U
#define CMAC_DATA_LENGTH        20U
#define CMON_LENGTH             8U

// *****************************************************************************
// *****************************************************************************
// Section: Data Types
// *****************************************************************************
// *****************************************************************************

typedef struct
{
    /* Phase/any */
    uint8_t Phase;
    /* threshold of request */
    uint8_t TCR;
    /* filter the node address */
    uint8_t AddToAddress;
    /* filter the node address */
    uint8_t RightShiftAdd;
} ACA_NW_REQ;

typedef struct
{
    /* Absolute Communication Address */
    uint8_t ACA[MAC_ADDRESS_SIZE];
    /* Instantaneous signal level */
    uint8_t Av_SIG;
    /* Instantaneous SNR */
    uint8_t SNR;
    /* Impedance value */
    uint8_t Av_TX;
    /* Reserved */
    uint8_t Reserve[3];
} ACA_NW_RESP;

typedef union
{
    uint8_t data[8];
    uint64_t value;
} DATETIME;

/* This structure is used in meter side AL to store random number from CCU to Meter */
typedef struct
{
    uint8_t random_num[KEY_LENGTH];
    uint8_t challenge_req_received;
}LMON_RECOVERY;

typedef struct
{
    /* Write data authentication key */
    uint8_t Write_Key[KEY_LENGTH];
    /* Read data authentication key */
    uint8_t Read_Key[KEY_LENGTH];
    /* Read data authentication key */
    uint8_t Counter_block[KEY_LENGTH];
} KEYS;

typedef enum
{
    AL_STATE_WAIT_DLL_READY,
    AL_STATE_APP_PROCESS,
} AL_STATE;

/* This variable is used only in Concentrator AL */
typedef union
{
    uint8_t status_byte;
    
    struct{
        int DL_Request_sent                 : 1;
        int DL_Confirm_rcvd                 : 1;
        int DL_Indication_req               : 1;
        int DL_Event_sent                   : 1;
    }flags;
}AL_MSG_STATUS;

typedef union
{
    uint8_t status_byte;
    
    struct{
        int ACA_Req_Address_Req_rcvd        : 1;
        int ACA_Address_Req_Sent            : 1;
        int ACA_Req_Address_Resp_sent       : 1;
        int ACA_ACK_sent                    : 1;                                    /* Same flag used for ACK & NACK */
        
    }flags;
}AL_NWSTATUS;

typedef struct
{
  /* input data */
  uint8_t inputBuf[CMAC_DATA_LENGTH];
  /* Received CMAC from concentrator */
  uint8_t Received_cmac[CMAC_LENGTH];
  /* Generated MAC output 128bit*/
  uint8_t Computed_cmac[CMAC_LENGTH];
  /* Length of the data */
  uint32_t input_dataLen;
  /* Key for the AES-CMAC cipher Operation*/
  uint8_t key[KEY_LENGTH];
} CMAC_PARAMS;

typedef struct
{
  /* Data buffer */
  uint8_t buffer[MAX_LENGTH_432_DATA];
  /* Length of the data */
  uint16_t dataLen;
  /* Generated MAC output 128bit*/
  uint8_t Mac_Output[CMAC_LENGTH];
  /* Key for the AES-CMAC cipher Operation*/
  uint32_t result;
} CRC_DATA;

typedef struct
{
    /* Application indication Callback */
    AL_DATA_IND_CALLBACK dataIndCallback;
    /* Application Event Callback */
    AL_EVENT_IND_CALLBACK eventIndCallback;
    /* Status of the AL module */
    SYS_STATUS status;
    /* State of the AL module State Machine */
    AL_STATE state;
    /* Maintain the event status in CCU */
    AL_MSG_STATUS AL_Status;
    /* Maintain the Network event status */
    AL_NWSTATUS AL_NWStatus;
    /* Keys used in Encrypt message processing */
    KEYS keys;
    /* variable used in handling CRC calculations */
    CRC_DATA crc;
    /* variable used in handling Cipher operations */
    CMAC_PARAMS cmac;
    /* storing the LMON recovery info */
    LMON_RECOVERY lmon_recovery;
    /* Used in CCU AL to store node info(ACA, LMON) received from Concentrator Table, for AUTH & ENCRYPT handling*/
    NODE_INFO comm_node_configdata;
    /* Tx Data Request Buffer */
    uint8_t Transmit_Buff[MAX_LENGTH_432_DATA];
    /* Write data authentication key */
    uint8_t Key_K1[KEY_LENGTH];
    /* Read data authentication key */
    uint8_t Key_K2[KEY_LENGTH];
    /* Read LMON data */
    LMON lmon;
    /* CMON data (updated in both DCU & METER AL)*/
    LMON cmon;
    /* Next task time in ms */
    uint64_t nextTaskTimeCount;
    /* Task rate in SYS_TIME counter ticks */
    uint32_t taskRateCount;
    /* Tx Buffer Length */
    uint16_t txBufferLen;
    /* Random Number Generated for LMON Recovery */
    uint8_t random_number[16];
    /* Incoming TCT (min 1 to max 255) */
    uint8_t TCT;
    /* Is master node (false in slave node) */
    bool isMaster;
    /* Flag to indicate this object is in use */
    bool inUse;

} AL_DATA;

#ifdef __cplusplus
}
#endif

#endif // #ifndef AL_LOCAL_H

/* *****************************************************************************
 End of File
 */
