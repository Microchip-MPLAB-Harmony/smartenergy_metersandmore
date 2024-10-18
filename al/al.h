/*******************************************************************************
  Interface definition of Meters And More AL (Application Layer) module.

  Company:
    Microchip Technology Inc.

  File Name:
    al.h

  Summary:
    Interface definition of Meters And More AL (Application Layer) module.

  Description:
    This file defines the interface for the Meters And More AL (Application
    Layer) module.
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

#ifndef AL_H
#define AL_H

// *****************************************************************************
// *****************************************************************************
// Section: File includes
// *****************************************************************************
// *****************************************************************************

#include "stack/metersandmore/dll/dll.h"
#include "crypto/common_crypto/MCHP_Crypto_Sym_Cipher.h"

/* Provide C++ Compatibility */
#ifdef __cplusplus
extern "C" {
#endif

// *****************************************************************************
// *****************************************************************************
// Section: Macro Definitions
// *****************************************************************************
// *****************************************************************************

#define KEY_LENGTH              16U
#define LMON_LENGTH             8U

// *****************************************************************************
// *****************************************************************************
// Section: Data Types
// *****************************************************************************
// *****************************************************************************

// *****************************************************************************
/* AL Encryption status for incoming message_types

   Summary:
    Indicates the incoming message_type protected status.

   Description:
    This AL_AUTH identifies the incoming message_type. User must check 
    for its status before processing with message data.

   Remarks:
    None.
*/
typedef enum
{
    AL_ENCRYPTION_DISABLED = 0x00,
    AL_ENCRYPTION_ENABLED = 0x01
} AL_AUTH;

/* Last Message Order Number (LMON) */
typedef union
{
    uint8_t buff[LMON_LENGTH];
    uint64_t value;
} LMON;

// *****************************************************************************
/* AL Node information Device configuration status 

   Summary:
    Indicates the AL device configuration status for processing with message data.

   Description:
    This AL_DEVICE identifies the Concentrator or Meter configuration. AL uses this 
    information for processing module operations.

   Remarks:
    None.
*/
typedef struct
{
    LMON lmon;
    uint8_t ACA[MAC_ADDRESS_SIZE];
} NODE_INFO;

// *****************************************************************************
/* Meters And More AL Configuration Data struct

  Summary:
    AL Configuration Data Parameters Structure.

   Description:
    Contains fields which define the information to be shared in the
    AL Configuration Data request. 

  Remarks:
    None.
*/
typedef struct
{
    /* Absolute Communication Address */
    uint8_t ACA[MAC_ADDRESS_SIZE];
    /* Section Communication Address */
    uint8_t SCA[MAC_ADDRESS_SIZE];
    /* Write data authentication key */
    uint8_t Key_K1[KEY_LENGTH];
    /* Read data authentication key */
    uint8_t Key_K2[KEY_LENGTH];
    /* Read LMON data */
    LMON lmon;
    /* CMON data (updated in both DCU & METER AL)*/
    LMON cmon;
    
} AL_CONFIG_DATA;

// *****************************************************************************
/* AL Event IDs

   Summary:
    Identifies the possible AL Event identifiers.

   Description:
    This enumeration identifies the possible AL Event identifiers.

   Remarks:
    None.
*/
typedef enum
{
    AL_EVENT_ID_MAC_ACA = 0,
    AL_EVENT_ID_MASTER_TX_TIMEOUT = 0x20,
} AL_EVENT_ID;

// *****************************************************************************
/* AL Event Struct

   Summary:
    Contains fields defining an AL Event

   Description:
    Contains fields of a AL Event, its length and value itself.

   Remarks:
    None.
*/
typedef struct
{
    uint8_t length;
    uint8_t value[MAC_EVENT_VALUE_MAX_LENGTH];
} AL_EVENT_VALUE;

// *****************************************************************************
/* Meters And More AL Data Indication struct

  Summary:
    AL Data Indication Parameters Structure.

   Description:
    Contains fields which define the information returned by the
    AL Data Indication Callback.

  Remarks:
    None.
*/
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
  uint8_t app_data[MAX_LENGTH_432_DATA];
  /* Length of the data */
  uint16_t app_dataLen;
  /* Data Request Tx Status, Set to 1 if Data confirm DLL_TX_STATUS_ERROR */
  uint16_t Last_Request_Tx_Failure;
} AL_DATA_IND_PARAMS;

// *****************************************************************************
/* Meters And More AL Data request struct

  Summary:
    AL Data Request Parameters Structure.

   Description:
    Contains fields which define the AL Data Request input parameter.

  Remarks:
    Fields marked as Master Only are used in Master Node and ignored in
    Slave Nodes.
*/
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

// *****************************************************************************
/* Meters And More AL Event Indication struct

  Summary:
    AL Event Indication Parameters Structure.

   Description:
    Contains fields which define the information returned by the
    AL Event Indication Callback.

  Remarks:
    This Struct is only used in Master Node.
*/
typedef struct
{
    /* Event Identifier */
    AL_EVENT_ID eventId;
    /* First additional information */
    AL_EVENT_VALUE eventValue;
} AL_EVENT_IND_PARAMS;

// *****************************************************************************
/* Meters And More AL module Result

  Summary:
    Result of a Meters And More AL module interface operation.

  Description:
    Lists the possible results of Meters And More AL module operations.
*/
typedef enum
{
    AL_SUCCESS,
    AL_ERROR
} AL_RESULT;

// *****************************************************************************
/* Meters And More Application Layer module Initialization Data

  Summary:
    Defines the data required to initialize the Meters And More Application
    Layer module

  Description:
    Contains fields which define the information required by Application Layer
    module upon initialization:
    - The rate at which associated task is executed
    - The role of the Device, Master or Slave

  Remarks:
    None.
*/
typedef struct
{
  /* Application Layer task rate in milliseconds */
  uint8_t taskRateMs;

  /* Is master node (false in slave node) */
  bool isMaster;
} AL_INIT;

// *****************************************************************************
/* Meters And More AL module Data Indication Function Pointer

  Summary:
    Pointer to a Meters And More AL module Data indication Function Pointer.

  Description:
    This data type defines the required function signature for the Meters And More AL
    module Data indication callback function. A client must register a pointer 
	using the callback register function whose function signature (parameter and
	return value types) match the types specified by this function pointer in 
	order to receive related event callbacks from the module.

    The parameters and return values are described here and a partial example
    implementation is provided.

  Parameters:
    indParams - Pointer to the object containing any data necessary to process the
             Data indication primitive.

  Returns:
    None.

  Example:
    <code>
    void APP_MyDataIndEventHandler( AL_DATA_IND_PARAMS *indParams )
    {
        if(indParams->app_dataLen > 0)
        {

        }
    }
    </code>
*/
typedef void ( *AL_DATA_IND_CALLBACK )( AL_DATA_IND_PARAMS *indParams );

// *****************************************************************************
/* Meters And More AL module Event Indication Function Pointer

  Summary:
    Pointer to a Meters And More AL module Event Indication Function Pointer.

  Description:
    This data type defines the required function signature for the Meters And More AL
    module Event Indication callback function. A client must register a pointer 
    using the callback register function whose function signature (parameter and
    return value types) match the types specified by this function pointer in 
    order to receive related event callbacks from the module.

    The parameters and return values are described here and a partial example
    implementation is provided.

  Parameters:
    indParams - Pointer to the object containing any data necessary to process the
                Event Indication primitive.

  Returns:
    None.

  Example:
    <code>
    void APP_MyDatEventIndHandler( AL_EVENT_IND_PARAMS *eventParams )
    {
         eventParams->eventValue;
    }
    </code>
*/
typedef void ( *AL_EVENT_IND_CALLBACK )( AL_EVENT_IND_PARAMS *eventParams );

// *****************************************************************************
// *****************************************************************************
// Section: Interface Functions
// *****************************************************************************
// *****************************************************************************

// *****************************************************************************
/* Function:
    AL_RESULT AL_DataIndicationCallbackRegister (
        AL_DATA_IND_CALLBACK callback
    );

  Summary:
    Allows a client to set a Meters And More AL Data indication
    event handling function for the module to call back when the requested
    transmission has finished.

  Description:
    This function allows a client to register a Meters And More
    AL Data indication event handling function for the module to call back
    when a Meters And More AL data indication event occurs.

  Parameters:
    callback - Pointer to the callback function.

  Returns:
    None.

  Example:
    <code>
    void APP_Rx_Ind_callback(AL_DATA_IND_PARAMS *indParams )
    {
        if (indParams->app_dataLen > 0){

        }
    }

    AL_DataIndicationCallbackRegister(APP_Rx_Ind_callback);
    </code>

  Remarks:
    Callback can be set to a NULL pointer to stop receiving notifications.
*/
AL_RESULT AL_DataIndicationCallbackRegister( AL_DATA_IND_CALLBACK callback );

// *****************************************************************************
/* Function:
    AL_RESULT AL_EventIndicationCallbackRegister (
        AL_EVENT_IND_CALLBACK callback
    );

  Summary:
    Allows a client to set a Meters And More AL Data Event indication
    event handling function for the module to call back
    when AL generates or receives a new event.

  Description:
    This function allows a client to register a Meters And More
    AL Event indication event handling function for the module to call back
    when a Meters And More AL event occurs.

  Parameters:
    callback - Pointer to the callback function.

  Returns:
    None.

  Example:
    <code>
    void APP_Event_Ind_callback(AL_EVENT_IND_CALLBACK *indParams)
    {
        if (indParams->eventId == MAC_EVENT_ID_ACA){

        }
    }

    AL_EventIndicationCallbackRegister(APP_Event_Ind_callback);
    </code>

  Remarks:
    Callback can be set to a NULL pointer to stop receiving notifications.
    This Callback is only generated in Master Node. There is no need to set
    a handling function on Slave Nodes.
*/
AL_RESULT AL_EventIndicationCallbackRegister( AL_EVENT_IND_CALLBACK callback );

// *****************************************************************************
/* Function:
    AL_RESULT AL_Data_Config_Request (
        AL_CONFIG_DATA *configParams
    );

  Summary:
    AL Data Config request

  Description:
    Function that implements the AL Config Data request primitive

  Precondition:
    The low-level board initialization must have been completed and
    the module's initialization function must have been called before
    the system can call the tasks routine for any module. 

  Parameters:
    configParams - Pointer to structure containing parameters related to AL Data Config Request

  Returns:
    AL_RESULT indicating the status of request placed.

  Example:
    <code>
    AL_CONFIG_DATA configParams;
    
    configParams.ACA = meterACADataBuffer;
    configParams.SCA = meterSCADataBuffer;
    configParams.Key_K1 = Key_k1_DataBuffer;
    configParams.Key_K2 = Key_k2_DataBuffer;
    configParams.lmon.buff = lmon_preconfigured_data;
    configParams.cmon.buff = NULL;
    
    AL_Data_Config_Request(&configParams);
    </code>

  Remarks:
    This function must be called once after AL_Initialize. All the data Indication, 
	Request or Confirm events require config data to process.
*/
AL_RESULT AL_Data_Config_Request( AL_CONFIG_DATA *configParams );

// *****************************************************************************
/* Function:
    void AL_DataRequest (
        AL_DATA_REQ_PARAMS *reqParams
    );

  Summary:
    AL Data request

  Description:
    Function that implements the AL Data request primitive

  Precondition:
    The low-level board initialization must have been completed and
    the module's initialization function must have been called before
    the system can call the tasks routine for any module.

  Parameters:
    drParams - Pointer to structure containing parameters related to AL Data request

  Returns:
    None.

  Example:
    <code>
    AL_DATA_REQ_PARAMS drParams;
    
    drParams.serviceClass = SERVICE_CLASS_RA;
    drParams.dstAddress.macAddress.address = dest_addressBuff;
    drParams.maxResponseLen = 128;
    drParams.timeSlotNum = 8;
    drParams.node_info.ACA = Dest_node_addrBuffer;
    drParams.node_info.lmon.buff = Node_Lmon_DataBuffer;
    drParams.Txdata = data;
    drParams.Txdata_Len = 10;
	drParams.timestamp = 0x66FB3B80;
	
    AL_DataRequest(&drParams);
    </code>

  Remarks:
    Node_Info parameter needed for processing protected messages in AL are specific to each node.
	This information to be sent by concentrator for each data request placed. This is applicable 
	only for Concentrator.
*/	
void AL_DataRequest( AL_DATA_REQ_PARAMS *reqParams );

// *****************************************************************************
/* Function:
    AL_RESULT AL_Set_Encryption_Keys (
        AL_CONFIG_DATA *configParams
    );

  Summary:
    AL Data Config request

  Description:
    Function that updates the encryption keys in AL run time.

  Precondition:
    AL_Data_Config_Request configures the Write & Read keys initially. CCU or Meter can request the AL 
	for updating the Keys using this function.

  Parameters:
    configParams - Pointer to structure containing parameters related to AL Data Config Request

  Returns:
    AL_RESULT indicating the status of request placed.

  Example:
    <code>
    AL_CONFIG_DATA configParams;
    
    configParams.Key_K1 = Key_k1_DataBuffer;
    configParams.Key_K2 = Key_k2_DataBuffer;
        
    AL_Set_Encryption_Keys(&configParams);
    </code>

  Remarks:
    None.
*/
AL_RESULT AL_Set_Encryption_Keys( AL_CONFIG_DATA *configparams );

// *****************************************************************************
/* Function:
    SYS_MODULE_OBJ AL_Initialize (
      const SYS_MODULE_INDEX index,
      const SYS_MODULE_INIT * const init
    );

  Summary:
    Initializes the Meters And More AL module according to initialization
    parameters.

  Description:
    This routine initializes the Meters And More AL module.
    The initialization data is specified by the init parameter.
    It is a single instance module and thus only one index is allowed.

  Precondition:
    The low-level processor and board initialization must be completed before
    the system can call the initialization functions for any modules.

  Parameters:
    index - Identifier for the instance to be initialized
            (single instance allowed)
    init  - Pointer to the init data structure containing any data
            necessary to initialize the module.

  Returns:
    If successful, returns a valid handle to a module instance object.
    Otherwise, it returns SYS_MODULE_OBJ_INVALID.

  Example:
    <code>
    SYS_MODULE_OBJ   sysObjMetersandmore;

    sysObjMetersandmore = AL_Initialize(0, (SYS_MODULE_INIT *)&init);
    </code>

  Remarks:
    This routine must be called before any other AL routine is called.
*/
SYS_MODULE_OBJ AL_Initialize (const SYS_MODULE_INDEX index, const SYS_MODULE_INIT * const init);
        
// *****************************************************************************
/* Function:
    SYS_MODULE_OBJ AL_Tasks (
        SYS_MODULE_OBJ object
    );

  Summary:
    Routine that maintains the state machine in the AL module.

  Description:
    Routine that performs the tasks necessary to maintain the state machine in
    the Meters And More AL module.

  Precondition:
    The low-level board initialization must have been completed and
    the module's initialization function must have been called before
    the system can call the tasks routine for any module.

  Parameters:
    object - Handle to the module instance

  Returns:
    None.

  Example:
    <code>
    SYS_MODULE_OBJ   sysObjMetersandmore;

    sysObjMetersandmore = AL_Initialize(0, (SYS_MODULE_INIT *)&InitData);

    AL_Tasks(sysObjMetersandmore);
    </code>

  Remarks:
    None.
*/
void AL_Tasks( SYS_MODULE_OBJ object );

// *****************************************************************************
/* Function:
    SYS_STATUS AL_GetStatus(void);

  Summary:
    Gets the status of the AL module.

  Description:
    This function allows to retrieve AL module status.
    It must be used to ensure the module is Ready before start using it.

  Precondition:
    None.

  Parameters:
    None.

  Returns:
    Returns the status of the Meters And Mores AL module.
    - SYS_STATUS_UNINITIALIZED: AL module has not been initialized.
    - SYS_STATUS_BUSY: AL module is busy in the process of initialization.
    - SYS_STATUS_READY: AL module is ready to be used.

  Example:
    <code>
    case APP_AL_STATE_START:
    {
        if (AL_GetStatus() == AL_STATUS_READY)
        {
            app_ALData.state = APP_AL_STATE_RUNNING;
        }

        break;
    }
    </code>

  Remarks:
    None.
*/
SYS_STATUS AL_GetStatus(void);

#ifdef __cplusplus
}
#endif

#endif /* AL_H */

/* *****************************************************************************
 End of File
 */
