/*******************************************************************************
  Interface definition of Meters&More AL (Application Layer) module.

  Company:
    Microchip Technology Inc.

  File Name:
    app_layer.h

  Summary:
    Interface definition of Meters&More Application Layer module.

  Description:
    This file defines the interface for the Meters&More Application Layer
    module.
*******************************************************************************/

#ifndef APP_LAYER_H    
#define APP_LAYER_H


/* ************************************************************************** */
/* ************************************************************************** */
/* Section: Included Files                                                    */
/* ************************************************************************** */
/* ************************************************************************** */
#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>
#include "al.h"
#include "crc.h"
#include "system/time/sys_time.h"
#include "config/default/crypto/common_crypto/MCHP_Crypto_Sym_Cipher.h"
#include "config/default/crypto/common_crypto/MCHP_Crypto_Mac_Cipher.h"


/* Provide C++ Compatibility */
#ifdef __cplusplus
extern "C" {
#endif

// *****************************************************************************
// *****************************************************************************
// Section: Data Types
// *****************************************************************************
// *****************************************************************************

#define taskRateCount     50U  

typedef enum
{
    CHALLENGE_REQ       = 112U,
    CHALLENGE_RESP      = 113U
} LMON_SYNC;

typedef enum
{
    ADDRESS_REQ         = 90U,
    ADDRESS_RESP        = 91U,
    TCT_SET_REQ         = 92U,
    REQ_ADDRESS_REQ     = 94U,
    REQ_ADDRESS_RESP    = 95U,
    NACK_RESP           = 247U
} NW_MGMT_COMMANDS;

typedef enum
{
    A_Node_ACK          = 253U,
    A_Node_NACK         = 255U,
    B_Node_ACK          = 251U,
    B_Node_NACK         = 249U,
    A_Node_ACK_AUTH     = 243U,
    A_Node_NACK_AUTH    = 245U,
    B_Node_ACK_AUTH     = 241U,
    B_Node_NACK_AUTH    = 239U            
}ACK_COMMANDS;

typedef enum
{
    WRITE_REQ           = 4U,
    WRITETAB_REQ        = 10U,
    SETTAB_REQ          = 14U,
    RESETTAB_REQ        = 16U,
    SETIC_REQ           = 40U,
    WRITETABIC_REQ      = 42U,
    READ_REQ            = 2U,
    READ_RESP           = 3U,
    READTAB_REQ_SEL     = 6U,
    READTAB_RESP_SEL    = 7U,
    READTAB_REQ         = 8U,
    READTAB_RESP        = 9U,
    GETTAB_REQ          = 30U,
    GETTAB_RESP         = 31U,
    DATASPONT           = 20U,
    REPROG_LOCAL        = 100U,
    REPROG_BROADCAST    = 101U,
    COMMAND             = 18U
} APP_MESSAGE_COMMANDS;

typedef enum
{
    WRITE_REQ_AUTH        = 104U,
    WRITETAB_REQ_AUTH     = 110U,
    SETTAB_REQ_AUTH       = 114U,
    RESETTAB_REQ_AUTH     = 116U,
    SETIC_REQ_AUTH        = 140U,
    WRITETABIC_REQ_AUTH   = 142U,
    READ_REQ_AUTH         = 102U,
    READ_RESP_AUTH        = 103U,
    READTAB_REQ_SEL_AUTH  = 106U,
    READTAB_RESP_SEL_AUTH = 107U,
    READTAB_REQ_AUTH      = 108U,
    READTAB_RESP_AUTH     = 109U,
    GETTAB_REQ_AUTH       = 130U,
    GETTAB_RESP_AUTH      = 131U,
    DATASPONT_AUTH        = 120U,
    COMMAND_AUTH          = 118U
} APP_MSG_PROTECTED_COMMANDS;

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
    uint8_t ACA[ACA_LENGTH];
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

typedef struct
{
    /* Write data authentication key */
    uint8_t Write_Key[KEY_LENGTH];
    /* Read data authentication key */
    uint8_t Read_Key[KEY_LENGTH];
    /* Keys generation status*/
    uint8_t Keys_generation_status;
    /* Read data authentication key */
    uint8_t Counter_block[KEY_LENGTH];
} KEYS;

typedef enum
{
    AL_STATE_IDLE,
    AL_STATE_APP_PROCESS,            
    AL_STATE_WAIT,
} APP_STATE;

typedef struct
{
    /* Status of the AL module */
    SYS_STATUS status;
    /* State of the State Machine for AL*/
    APP_STATE state;
    /* Flag to indicate this object is in use */
    bool inUse;
} AL_STATUS;


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
  uint8_t buffer[MAX_DATA_LENGTH];
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
    AL_DATA_EVENT_CALLBACK dataEventCallback;
    
} AL_HANDLERS;

  
#ifdef __cplusplus
}
#endif

#endif /* #ifndef app_layer_H */

/* *****************************************************************************
 End of File
 */
