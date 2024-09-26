/* ************************************************************************** */
/** Descriptive File Name

  @Company
    Company Name

  @File Name
    al.h

  @Summary
    Brief description of the file.

  @Description
    Describe the purpose of this file.
 */
/* ************************************************************************** */

#ifndef AL_H    /* Guard against multiple inclusion */
#define AL_H


/* ************************************************************************** */
/* ************************************************************************** */
/* Section: Included Files                                                    */
/* ************************************************************************** */
/* ************************************************************************** */

#include "stack/metersandmore/dll/dll.h"
#include "crypto/common_crypto/MCHP_Crypto_Sym_Cipher.h"

/* Provide C++ Compatibility */
#ifdef __cplusplus
extern "C" {
#endif

#define KEY_LENGTH              16U
#define ACA_LENGTH              6U
#define SCA_LENGTH              6U   
#define LMON_LENGTH             8U   
#define CMON_LENGTH             8U    
    
#define SessionID               1U    
#define CMAC_LENGTH             16U 
#define CMAC_DATA_LENGTH        20U     

#define AL_INSTANCES_NUMBER     1U
    
#define MAX_DATA_LENGTH         128U 
    
    /* ************************************************************************** */
    /* ************************************************************************** */
    /* Section: Constants                                                         */
    /* ************************************************************************** */
    /* ************************************************************************** */

    /*  A brief description of a section can be given directly below the section
        banner.
     */
    
typedef enum
{
    AL_ENCRYPTION_DISABLED = 0x00,
    AL_ENCRYPTION_ENABLED = 0x01
} AL_AUTH;

typedef union
{
    uint8_t buff[LMON_LENGTH];
    uint64_t value;
} LMON;
    
typedef enum
{
    AL_CONCENTRATOR,
    AL_METER
} AL_DEVICE;

typedef struct
{
    LMON lmon;
    uint8_t ACA[ACA_LENGTH];
} NODE_INFO;

typedef struct
{
    /* Absolute Communication Address */
    uint8_t ACA[ACA_LENGTH];
    /* Section Communication Address */
    uint8_t SCA[SCA_LENGTH];
    /* Write data authentication key */
    uint8_t Key_K1[KEY_LENGTH];
    /* Read data authentication key */
    uint8_t Key_K2[KEY_LENGTH];
    /* Read LMON data */
    LMON lmon;
    /* CMON data (updated in both CCU & METER AL)*/
    LMON cmon;
    /* Concentrator/Meter Configuration */
    AL_DEVICE config_device;
    
} AL_CONFIG_DATA;


typedef struct
{
  /* Message Code */
  uint8_t command_message; 
  /* Message Type */
  AL_AUTH message_type;
  /* Decrypted status*/
  crypto_Sym_Status_E decryption_status;
  /* Authentication status */
  uint16_t authentication_status;
  /* Source 432 Address (Concentrator)  */
  uint16_t srcAddress;
  /* ACA & new verified LMON from Meter for table entry in MASTER*/
  NODE_INFO node_info;
  /* Pointer to received data*/
  uint8_t app_data[MAX_DATA_LENGTH];
  /* Length of the data */
  uint16_t app_dataLen;
  /* Data Request Tx Status, Set to 1 if Data confirm DLL_TX_STATUS_ERROR */
  uint16_t Last_Request_Tx_Failure;
} AL_DATA_IND_PARAMS;

typedef struct
{
  /* Message Code */
  uint8_t eventId; 
  /* ACA Address of Event Node */
  uint8_t eventValue[ACA_LENGTH];
  
} AL_DATA_EVENT_PARAMS;

typedef struct
{
  /* Service class - MASTER ONLY */
  SERVICE_CLASS serviceClass;
  /* Destination route - MASTER ONLY */
  ROUTING_ENTRY dstAddress;
  /* Max length of the response - MASTER ONLY */
  uint16_t maxResponseLen;
  /* Number of time slots alocated in data request with Service_Class RC - MASTER ONLY */
  uint16_t timeSlotNum ;  
  /* ACA & new verified LMON from Meter for table entry in MASTER*/
  NODE_INFO node_info;
  /* Pointer to Data buffer (CM, Data) */
  uint8_t *Txdata;
  /* Length of the data */
  uint16_t Txdata_Len;
  /* POSIX timestamp */
  uint64_t timestamp;
} AL_DATA_REQ_PARAMS;


typedef enum
{
    AL_SUCCESS,
    AL_ERROR
} AL_RESULT;

typedef enum
{
    AL_PROCESSED,
    AL_BUSY
} AL_M_STATUS;

    // *****************************************************************************
    // *****************************************************************************
    // Section: Data Types
    // *****************************************************************************
    // *****************************************************************************

typedef void ( *AL_DATA_IND_CALLBACK )( AL_DATA_IND_PARAMS *indParams );

typedef void ( *AL_DATA_EVENT_CALLBACK )( AL_DATA_EVENT_PARAMS *eventParams );

    // *****************************************************************************
    // *****************************************************************************
    // Section: Interface Functions
    // *****************************************************************************
    // *****************************************************************************

    // *****************************************************************************

AL_RESULT AL_data_ind_CallbackRegister( AL_DATA_IND_CALLBACK callback );

AL_RESULT AL_data_event_CallbackRegister( AL_DATA_EVENT_CALLBACK callback );

AL_M_STATUS AL_data_config_process( AL_CONFIG_DATA *configParams );
    
AL_M_STATUS AL_data_request_process( AL_DATA_REQ_PARAMS *reqParams );

AL_M_STATUS AL_set_encryption_keys( AL_CONFIG_DATA *configparams );

SYS_MODULE_OBJ AL_Initialize (const SYS_MODULE_INDEX index, const SYS_MODULE_INIT * const init);
        
        
    /* Provide C++ Compatibility */
#ifdef __cplusplus
}
#endif

#endif /* AL_H */

/* *****************************************************************************
 End of File
 */
