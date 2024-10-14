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
/* AL Device configuration status 

   Summary:
    Indicates the AL device configuration status for processing with message data.

   Description:
    This AL_DEVICE identifies the Concentrator or Meter configuration. AL uses this 
    information for processing module operations.

   Remarks:
    None.
*/
typedef enum
{
    AL_CONCENTRATOR,
    AL_METER
} AL_DEVICE;

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
    uint8_t ACA[ACA_LENGTH];
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
  uint8_t app_data[MAX_DATA_LENGTH];
  /* Length of the data */
  uint16_t app_dataLen;
  /* Data Request Tx Status, Set to 1 if Data confirm DLL_TX_STATUS_ERROR */
  uint16_t Last_Request_Tx_Failure;
} AL_DATA_IND_PARAMS;


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
  /* Message Code */
  uint8_t eventId; 
  /* ACA Address of Event Node */
  uint8_t eventValue[ACA_LENGTH];
  
} AL_DATA_EVENT_PARAMS;

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
/* Meters And More AL module Status

  Summary:
    Status of a Meters And More AL module interface operation.

  Description:
    Lists the status of Meters And More AL module operations.
*/
typedef enum
{
    AL_PROCESSED,
    AL_BUSY
} AL_M_STATUS;

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
    void APP_MyDatEventIndHandler( AL_DATA_EVENT_PARAMS *eventParams )
    {
         eventParams->eventValue;
    }
    </code>
*/
typedef void ( *AL_DATA_EVENT_CALLBACK )( AL_DATA_EVENT_PARAMS *eventParams );


// *****************************************************************************
// *****************************************************************************
// Section: Interface Functions
// *****************************************************************************
// *****************************************************************************

// *****************************************************************************
/* Function:
    AL_RESULT AL_Data_Ind_CallbackRegister (
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

    AL_Data_Ind_CallbackRegister(APP_Rx_Ind_callback);
    </code>

  Remarks:
    Callback can be set to a NULL pointer to stop receiving notifications.
*/
AL_RESULT AL_Data_Ind_CallbackRegister( AL_DATA_IND_CALLBACK callback );

// *****************************************************************************
/* Function:
    AL_RESULT AL_Data_Event_CallbackRegister (
        AL_DATA_EVENT_CALLBACK callback
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
    void APP_Event_Ind_callback(AL_DATA_EVENT_CALLBACK *indParams)
    {
        if (indParams->eventId == MAC_EVENT_ID_ACA){

        }
    }

    AL_Data_Event_CallbackRegister(APP_Event_Ind_callback);
    </code>

  Remarks:
    Callback can be set to a NULL pointer to stop receiving notifications.
    This Callback is only generated in Master Node. There is no need to set
    a handling function on Slave Nodes.
*/
AL_RESULT AL_Data_Event_CallbackRegister( AL_DATA_EVENT_CALLBACK callback );

// *****************************************************************************
/* Function:
    AL_M_STATUS AL_Data_Config_Request (
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
    AL_M_STATUS indicating the status of request placed.

  Example:
    <code>
    AL_CONFIG_DATA configParams;
    
    configParams.ACA = meterACADataBuffer;
    configParams.SCA = meterSCADataBuffer;
    configParams.Key_K1 = Key_k1_DataBuffer;
    configParams.Key_K2 = Key_k2_DataBuffer;
    configParams.lmon.buff = lmon_preconfigured_data;
    configParams.cmon.buff = NULL;
    configParams.config_device = AL_CONCENTRATOR; 
    
    AL_Data_Config_Request(&configParams);
    </code>

  Remarks:
    This function must be called once after AL_Initialize. All the data Indication, 
	Request or Confirm events require config data to process.
*/
AL_M_STATUS AL_Data_Config_Request( AL_CONFIG_DATA *configParams );

// *****************************************************************************
/* Function:
    AL_M_STATUS AL_DataRequest_Process (
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
    AL_M_STATUS indicating the status of request placed.

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
	
    AL_DataRequest_Process(&drParams);
    </code>

  Remarks:
    Node_Info parameter needed for processing protected messages in AL are specific to each node.
	This information to be sent by concentrator for each data request placed. This is applicable 
	only for Concentrator.
*/	
AL_M_STATUS AL_DataRequest_Process( AL_DATA_REQ_PARAMS *reqParams );

// *****************************************************************************
/* Function:
    AL_M_STATUS AL_Set_Encryption_Keys (
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
    AL_M_STATUS indicating the status of request placed.

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
AL_M_STATUS AL_Set_Encryption_Keys( AL_CONFIG_DATA *configparams );

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


    /* Provide C++ Compatibility */
#ifdef __cplusplus
}
#endif

#endif /* AL_H */

/* *****************************************************************************
 End of File
 */
