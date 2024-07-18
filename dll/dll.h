/*******************************************************************************
  Interface definition of Meters&More DLL (Data Link Layer) module.

  Company:
    Microchip Technology Inc.

  File Name:
    dll.h

  Summary:
    Interface definition of Meters&More DLL (Data Link Layer) module.

  Description:
    This file defines the interface for the Meters&More DLL (Data Link Layer)
    module.
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

#ifndef DLL_H
#define DLL_H

// *****************************************************************************
// *****************************************************************************
// Section: File includes
// *****************************************************************************
// *****************************************************************************

#include <stdint.h>
#include <stdbool.h>
#include <stddef.h>
#include "driver/driver.h"
#include "system/system.h"
#include "device.h"
#include "configuration.h"

// DOM-IGNORE-BEGIN
#ifdef __cplusplus // Provide C++ Compatibility

    extern "C" {

#endif
// DOM-IGNORE-END

// *****************************************************************************
// *****************************************************************************
// Section: Data Types
// *****************************************************************************
// *****************************************************************************

/* Sizes */

/* Max LSDU Data length according to Meters&More */
#define MAX_LENGTH_432_DATA         (128U)

/* DLL object sizes */
#define MAX_ROUTE_SIZE              (9U)
#define MAC_ADDRESS_SIZE            (6U)

/* Maximum length of an IB object */
#define DLL_IB_MAX_VALUE_LENGTH     (MAX_ROUTE_SIZE*MAC_ADDRESS_SIZE)

/* Maximum length of a MAC Event Value */
#define MAC_EVENT_VALUE_MAX_LENGTH  (MAC_ADDRESS_SIZE)

// *****************************************************************************
/* Meters&More DLL module Result

  Summary:
    Result of a Meters&More DLL module interface operation.

  Description:
    Identifies the result of certain Meters&More DLL module operations.
*/
typedef enum
{
    DLL_SUCCESS,
    DLL_ERROR
} DLL_RESULT;


// *****************************************************************************
/* DLL module Status

  Summary:
    Defines the status of the DLL module.

  Description:
    This enumeration defines the status of the DLL module:
        - DLL_STATUS_UNINITIALIZED: DLL module has not been initialized.
        - DLL_STATUS_READY: DLL module is ready to be used.
  Remarks:
    None.
*/
typedef enum
{
    DLL_STATUS_UNINITIALIZED = SYS_STATUS_UNINITIALIZED,
    DLL_STATUS_READY = SYS_STATUS_READY,
} DLL_STATUS;

// *****************************************************************************
/* DSAP definition

   Summary:
    DSAP (Destination Service Access Point) values for Meters&More DLL layer.

   Description:
    This enumeration identifies the possible DSAP values
    0 - Application Frame
    1 - Network Management

   Remarks:
    None.
*/
typedef enum
{
    DLL_DSAP_APPLICATION_FRAME  = 0x00,
    DLL_DSAP_NETWORK_MANAGEMENT = 0x01
} DLL_DSAP;

// *****************************************************************************
/* ECC definition

   Summary:
    ECC (Encryption Coding Control) values for Meters&More DLL layer.

   Description:
    This enumeration identifies the possible ECC values
    The only value defined is:
    - Disabled
    (Other values are reserved).

   Remarks:
    None.
*/
typedef enum
{
    DLL_ECC_DISABLED = 0x00,
} DLL_ECC;

// *****************************************************************************
/* Service Class definition

   Summary:
    Identifies the possible MAC Service Class values.

   Description:
    This enumeration identifies the possible MAC Service Class values
    S - Send/NoReply
    RA - Request/Respond on A subnetwork
    RB - Request/Respond involving A and B subnetworks
    RC - Request/MultiRespond

   Remarks:
    None.
*/
typedef enum
{
    SERVICE_CLASS_S  = 0x00,
    SERVICE_CLASS_RA = 0x01,
    SERVICE_CLASS_RB = 0x02,
    SERVICE_CLASS_RC = 0x03
} SERVICE_CLASS;

// *****************************************************************************
/* Tx Status definition

   Summary:
    Transmission results defined in DLL layer.

   Description:
    This enumeration identifies the possible Transmission result values
    0 - Success
    1 - Error

   Remarks:
    None.
*/
typedef enum
{
    DLL_TX_STATUS_SUCCESS = 0x00,
    DLL_TX_STATUS_ERROR   = 0x01
} DLL_TX_STATUS;

// *****************************************************************************
/* MAC Address definition

   Summary:
    Defines the Address as an array of 6 unsigned 8-bit integers.

   Description:
    Creates an unsigned 8-bit integer array specific type for Address
    definition.

   Remarks:
    None.
*/
typedef struct
{
    uint8_t address[MAC_ADDRESS_SIZE];
} MAC_ADDRESS;

// *****************************************************************************
/* Routing Table Entry definition

   Summary:
    Defines the fields of an entry in the Routing Table.

   Description:
    This structure contains the fields which define a Routing Table entry.
    This table contains a route to every node in the Network.

   Remarks:
    A Routing Table Entry is pased to DLL in DLL_DataRequest, containing
    the destination address and the ordered list of the addresses of the
    involved repeaters.
*/
typedef struct
{
    MAC_ADDRESS macAddress[MAX_ROUTE_SIZE];
    uint8_t routeSize;
} ROUTING_ENTRY;

// *****************************************************************************
/* DLL Parameter Information Base definition

   Summary:
    Lists the available objects in the DLL Information Base (IB).

   Description:
    DLL IB is a collection of objects that can be read/written in order to
    retrieve information and/or configure the DLL layer.

   Remarks:
    None.
*/
typedef enum
{
    MAC_ACA_ADDRESS_IB = 0x201,
    MAC_SCA_ADDRESS_IB = 0x202,
    MAC_BAUDRATE_IB = 0x203,
    MAC_TIME_SLOT_US_IB = 0x204,
    MAC_TIME_ELABORATION_US_IB = 0x205,
    MAC_ADDITIONAL_DELAY_US_IB = 0x206,
    LLC_NUM_RETRIES_IB = 0x400,

} DLL_IB_ATTRIBUTE;

/* Masks to distinguish between layer attributes */
#define MAC_ATTRIBUTE_MASK   0x200
#define LLC_ATTRIBUTE_MASK   0x400

// *****************************************************************************
/* DLL IB Value definition

   Summary:
    Defines the fields of an IB Value object.

   Description:
    This structure contains the fields which define an IB Value object,
    which contains information of its length and the value itself coded into an
    8-bit array format.

   Remarks:
    None.
*/
typedef struct
{
    uint8_t length;
    uint8_t value[DLL_IB_MAX_VALUE_LENGTH];
} DLL_IB_VALUE;

// *****************************************************************************
/* MAC Event IDs

   Summary:
    Identifies the possible MAC Event identifiers.

   Description:
    This enumeration identifies the possible MAC Event identifiers.

   Remarks:
    None.
*/
typedef enum
{
    MAC_EVENT_ID_ACA = 0
} MAC_EVENT_ID;

// *****************************************************************************
/* MAC Event Struct

   Summary:
    Contains fields defining a MAC Event

   Description:
    Contains fields of a MAC Event, its length and value itself.

   Remarks:
    None.
*/
typedef struct
{
    uint8_t length;
    uint8_t value[MAC_EVENT_VALUE_MAX_LENGTH];
} MAC_EVENT_VALUE;

// *****************************************************************************
/* Meters&More DLL 4-32 Data request struct

  Summary:
    This struct includes DLL 4-32 DL_Data.request

  Remarks:
    None.
*/
typedef struct
{
  /* Pointer to the data to be sent (max length: MAX_LENGTH_432_DATA) */
  uint8_t *lsdu;
  /* Destination LSAP */
  DLL_DSAP dsap;
  /* ECC (Encryption Coding Control) */
  DLL_ECC ecc;
  /* Service class - MASTER ONLY */
  SERVICE_CLASS serviceClass;
  /* Destination route - MASTER ONLY */
  ROUTING_ENTRY dstAddress;
  /* Max length of the response - MASTER ONLY */
  uint16_t maxResponseLen;
  /* Number of time slots alocated in data request with Service_Class RC - MASTER ONLY */
  uint16_t timeSlotNum ;
  /* Length of the data */
  uint16_t lsduLen;
} DLL_DATA_REQUEST_PARAMS;


// *****************************************************************************
/* Meters&More DLL 4-32 Data Indication struct

  Summary:
    This struct includes DLL 4-32 Data indication

  Remarks:
    None.
*/
typedef struct
{
  /* Destination LSAP */
  DLL_DSAP dsap;
  /* ECC (Encryption Coding Control) */
  DLL_ECC ecc;
  /* Source address */
  MAC_ADDRESS srcAddress;
  /* Pointer to received data (max length: MAX_LENGTH_432_DATA)*/
  uint8_t *lsdu;
  /* Length of the data */
  uint16_t lsduLen;
} DLL_DATA_IND_PARAMS;

// *****************************************************************************
/* Meters&More DLL 4-32 Data Confirm struct

  Summary:
    This struct includes DLL 4-32 Data onfirm

  Remarks:
    None.
*/
typedef struct
{
    /* Destination LSAP */
    DLL_DSAP dsap;
    /* ECC (Encryption Coding Control) */
    DLL_ECC ecc;
    /* Destination address */
    MAC_ADDRESS dstAddress;
    /* Tx status */
    DLL_TX_STATUS txStatus;
} DLL_DATA_CONFIRM_PARAMS;

// *****************************************************************************
/* Meters&More DLL 4-32 Event Indication struct

  Summary:
    This struct includes DLL 4-32 Event indication

  Remarks:
    None.
*/
typedef struct
{
    /* Event Identifier */
    MAC_EVENT_ID eventId;
    /* First additional information */
    MAC_EVENT_VALUE eventValue;
} DLL_EVENT_IND_PARAMS;

// *****************************************************************************
/* Meters&More DLL module Initialization Data

  Summary:
    Defines the data required to initialize the Meters&More DLL module

  Description:


  Remarks:
    None.
*/
typedef struct
{
  /* DLL repeats */
  uint8_t repeats;

  /* ADP task rate in milliseconds */
  uint8_t taskRateMs;

  /* Is master node (false in slave node) */
  bool isMaster;
} DLL_INIT;

// *****************************************************************************
/* Meters&More DLL 4-32 module Data Indication Function Pointer

  Summary:
    Pointer to a Meters&More DLL 4-32 module DL_Data.indication Function Pointer.

  Description:
    This data type defines the required function signature for the Meters&More DLL 4-32
    module DL_Data.indication callback function. A client must
    register a pointer using the callback register function whose function
    signature (parameter and return value types) match the types specified by
    this function pointer in order to receive transfer related event calls back
    from the module.

    The parameters and return values are described here and a partial example
    implementation is provided.

  Parameters:
    indParams - Pointer to the object containing any data necessary to process the
             DL_Data.indication primitive.

  Returns:
    None.

  Example:
    <code>
    void APP_MyDataIndEventHandler( DLL_DATA_IND_PARAMS *indParams )
    {
        if(indParams->lsduLen > 0)
        {

        }
    }
    </code>
*/
typedef void ( *DLL_DATA_IND_CALLBACK )( DLL_DATA_IND_PARAMS *indParams );

// *****************************************************************************
/* Meters&More DLL 4-32 module Data Confirm Function Pointer

  Summary:
    Pointer to a Meters&More DLL 4-32 module Data Confirmn Function Pointer.

  Description:
    This data type defines the required function signature for the Meters&More DLL 4-32
    module Data Confirm callback function. A client must
    register a pointer using the callback register function whose function
    signature (parameter and return value types) match the types specified by
    this function pointer in order to receive transfer related event calls back
    from the module.

    The parameters and return values are described here and a partial example
    implementation is provided.

  Parameters:
    cfmParams - Pointer to the object containing any data necessary to identify the
             result of the last transmission.

  Returns:
    None.

  Example:
    <code>
    void APP_MyDataCfmEventHandler( DLL_DATA_CONFIRM_PARAMS *cfmParams )
    {
        switch(cfmParams->uc_tx_status)
        {
            case DLL_TX_STATUS_SUCCESS:
                break;
            case DLL_TX_STATUS_ERROR:
                break;
        }
    }
    </code>

  Remarks:
    - If the status field is DLL_TX_STATUS_SUCCESS, it means that the data was
      transferred successfully.

    - Otherwise, it means that the data was not transferred successfully.

*/
typedef void ( *DLL_DATA_CONFIRM_CALLBACK )( DLL_DATA_CONFIRM_PARAMS *cfmParams );


// *****************************************************************************
/* Meters&More DLL 4-32 module Event Indication Function Pointer

  Summary:
    Pointer to a Meters&More DLL 4-32 module Event Indication Function Pointer.

  Description:
    This data type defines the required function signature for the Meters&More DLL 4-32
    module Event Indication callback function. A client must
    register a pointer using the callback register function whose function
    signature (parameter and return value types) match the types specified by
    this function pointer in order to receive transfer related event calls back
    from the module.

    The parameters and return values are described here and a partial example
    implementation is provided.

  Parameters:
    indParams - Pointer to the object containing any data necessary to process the
             Event Indication primitive.

  Returns:
    None.

  Example:
    <code>
    void APP_MyEventIndEventHandler( DLL_EVENT_IND_PARAMS *indParams )
    {
        if (indParams->lsduLen > 0){

        }
    }
    </code>
*/
typedef void ( *DLL_EVENT_IND_CALLBACK )( DLL_EVENT_IND_PARAMS *indParams );


// *****************************************************************************

// *****************************************************************************
// *****************************************************************************
// Section: Interface Routines
// *****************************************************************************
// *****************************************************************************

// *****************************************************************************
/* Function:
    SYS_MODULE_OBJ DLL_Initialize (
      const SYS_MODULE_INDEX index,
      const SYS_MODULE_INIT * const init
    );

  Summary:
    Initializes the Meters&More DLL module according to the init parameter and the cause of the reset of the main processor.

  Description:
    This routine initializes the Meters&More DLL module making it ready for clients to open and use.
    The initialization data is specified by the init parameter.
    It is a single instance module.

  Precondition:
    The low-level processor and board initialization must be completed before the
    system can call the initialization functions for any modules.

  Parameters:
    index - Identifier for the instance to be initialized (single instance allowed)
    init  - Pointer to the init data structure containing any data necessary to initialize the module.
    resetCause - Reset cause of the main processor.

  Returns:
    If successful, returns a valid handle to a module instance object.
    Otherwise, it returns SYS_MODULE_OBJ_INVALID.

  Example:
    <code>
    SYS_MODULE_OBJ   sysObjMetersandmore;

    DLL_INIT dllInitData = {
        .taskRateMs = 1U
    };

    sysObjMetersandmore = DLL_Initialize((SYS_MODULE_INIT *)&dllInitData);
    </code>

  Remarks:
    This routine must be called before any other DLL routine is called.
*/
SYS_MODULE_OBJ DLL_Initialize(const SYS_MODULE_INDEX index, const SYS_MODULE_INIT * const init);


// *****************************************************************************
/* Function:
    DLL_RESULT DLL_DataIndicationCallbackRegister(DLL_DATA_IND_CALLBACK callback);

  Summary:
    Allows a client to set a Meters&More DLL 4-32 DL_Data.indication event handling function
    for the module to call back when the requested transmission has finished.

  Description:
    This function allows a client to register a Meters&More DLL 4-32 DL_Data.indication event
    handling function for the module to call back when a Meters&More DLL data indication event
    occurs.

    The callback once set, persists until the client closes the module or sets another callback
    (which could be a "NULL" pointer to indicate no callback).

  Parameters:
    callback - Pointer to the callback function.

  Returns:
    None.

  Example:
    <code>
    void APP_Rx_Ind_callback(DLL_DATA_IND_PARAMS *indParams)
    {
        if (indParams->lsduLen > 0){

        }
    }

    DLL_DataIndicationCallbackRegister( APP_Rx_Ind_callback );
    </code>

*/
DLL_RESULT DLL_DataIndicationCallbackRegister(DLL_DATA_IND_CALLBACK callback);

// *****************************************************************************
/* Function:
    DLL_RESULT DLL_DataConfirmCallbackRegister(DLL_DATA_CONFIRM_CALLBACK callback);

  Summary:
    Allows a client to set a Meters&More DLL 4-32 DL_Data.confirm event handling function
    for the module to call back when the requested transmission has finished.

  Description:
    This function allows a client to register a Meters&More DLL 4-32 DL_Data.confirm event
    handling function for the module to call back when a Meters&More DLL data confirm event
    occurs.

    The callback once set, persists until the client closes the module or sets another callback
    (which could be a "NULL" pointer to indicate no callback).

  Parameters:
    callback - Pointer to the callback function.

  Returns:
    None.

  Example:
    <code>
    void APP_Tx_Cfm_callback(DLL_DATA_CONFIRM_PARAMS *cfmParams)
    {
        if (cfmParams->result == DLL_SUCCESS)
        {

        }
        else
        {

        }
    }

    DLL_DataConfirmCallbackRegister( APP_Tx_Cfm_callback );

    </code>

*/
DLL_RESULT DLL_DataConfirmCallbackRegister(DLL_DATA_CONFIRM_CALLBACK callback);

// *****************************************************************************
/* Function:
    DLL_RESULT DLL_EventIndicationCallbackRegister(DLL_EVENT_IND_CALLBACK callback);

  Summary:
    Allows a client to set a Meters&More DLL 4-32 DL_Event.indication event handling function
    for the module to call back when DLL generates a new event.

  Description:
    This function allows a client to register a Meters&More DLL 4-32 DL_Event.indication event
    handling function for the module to call back when a Meters&More DLL event occurs.

    The callback once set, persists until the client closes the module or sets another callback
    (which could be a "NULL" pointer to indicate no callback).

  Parameters:
    callback - Pointer to the callback function.

  Returns:
    None.

  Example:
    <code>
    void APP_Event_Ind_callback(DLL_EVENT_IND_CALLBACK *indParams)
    {
        if (indParams->lsduLen > 0){

        }
    }

    DLL_EventIndicationCallbackRegister( APP_Event_Ind_callback );
    </code>

*/
DLL_RESULT DLL_EventIndicationCallbackRegister(DLL_EVENT_IND_CALLBACK callback);

// *****************************************************************************
/* Function:
    void DLL_DataRequest(DLL_DATA_REQUEST_PARAMS *drParams);

  Summary:
    DLL 4-32 Data request

  Description:
    Function that implements the DLL 4-32 DL_Data.request primitive

  Precondition:
    The low-level board initialization must have been completed and
    the module's initialization function must have been called before
    the system can call the tasks routine for any module.

  Parameters:
    drParams - Pointer to structure containing parameters related to DL_Data.request

  Returns:
    None.

  Example:
    <code>
    DLL_DATA_REQUEST_PARAMS drParams;
    ROUTING_ENTRY addr;

    drParams.dsap = DLL_DSAP_APPLICATION_FRAME;
    drParams.ecc = DLL_ECC_DISABLED;
    drParams.lsdu = appPlcTxDataBuffer;
    drParams.serviceClass = SERVICE_CLASS_RA;
    drParams.dstAddress = addr;
    drParams.maxResponseLen = 128;
    drParams.timeSlotNum = 8;
    drParams.lsduLen = 10;

    DLL_DataRequest(&drParams);
    </code>

  Remarks:
    None.
*/
void DLL_DataRequest(DLL_DATA_REQUEST_PARAMS *drParams);

// *****************************************************************************
/* Function:
    uint32_t DLL_GetTxTimeout(void);

  Summary:
    Gets the timeout that Upper Layer has to wait after a Data Request,
    according to previous Data Request info

  Description:
    This function returns the timeout that Upper Layer has to wait after issuing
    a Data Request before allowing further transmission.
    Function is implemented inside DLL layer, as it has all the information needed
    to perform the calculations.

  Precondition:
    DLL_DataRequest has to be called before calling this function, so DLL has the
    correct parameters information before performing the calculation.

  Parameters:
    None

  Returns:
    Timeout, in microseconds.

  Example:
    <code>
    DLL_DATA_REQUEST_PARAMS drParams;
    ROUTING_ENTRY addr;
    uint32_t responseWaitTimeout;

    drParams.dsap = DLL_DSAP_APPLICATION_FRAME;
    drParams.ecc = DLL_ECC_DISABLED;
    drParams.lsdu = appPlcTxDataBuffer;
    drParams.serviceClass = SERVICE_CLASS_RA;
    drParams.dstAddress = addr;
    drParams.maxResponseLen = 128;
    drParams.timeSlotNum = 8;
    drParams.lsduLen = 10;

    DLL_DataRequest(&drParams);

    responseWaitTimeout = DLL_GetTxTimeout();
    </code>

  Remarks:
    None.
*/
uint32_t DLL_GetTxTimeout(void);

// *****************************************************************************
/* Function:
    DLL_STATUS DLL_GetStatus(void);

  Summary:
    Get the status of the DLL module.

  Description:
    DLL function status:
        - DLL_STATUS_UNINITIALIZED: DLL module has not been initialized.
        - DLL_STATUS_IDLE: DLL module is idle.
        acquisition is performed.

    These status values are closely related to the Meters&Mores DLL module states.
    For further information about the Meters&Mores DLL module state diagram, refer to online documentation.

  Precondition:
    None.

  Parameters:
    None.

  Returns:
    Returns the status of the Meters&Mores DLL module.

  Example:
    <code>
        case APP_DLL_STATE_START:
        {
            if (DLL_GetStatus() == DLL_STATUS_READY)
            {
              app_DLLData.state = APP_DLL_STATE_RUNNING;
            }

            break;
        }
    </code>

  Remarks:
    None.
*/
DLL_STATUS DLL_GetStatus(void);

// *****************************************************************************
/* Function:
    SYS_MODULE_OBJ DLL_Tasks (SYS_MODULE_OBJ object);

  Summary:
    Routine that performs the tasks necessary to maintain a state machine in
    the Meters&Mores DLL module.

  Description:
    Routine that performs the tasks necessary to maintain a state machine in
    the Meters&Mores DLL module.

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

    DLL_Tasks(sysObj.metersandmore);
    </code>

  Remarks:
    None.
*/
void DLL_Tasks(SYS_MODULE_OBJ object);

// *****************************************************************************
/* Function:
    DLL_RESULT DLL_GetRequest(DLL_IB_ATTRIBUTE attribute, uint16_t index, DLL_IB_VALUE *ibValue)

  Summary:
    The DLL_GetRequest primitive gets the value of an attribute in the
    DLL layer Parameter Information Base (IB).

  Description:
    GetRequestSync primitive is used to get the value of an IB.
    Result is provided upon function call return, in the ibValue parameter.

  Precondition:
    None.

  Parameters:
    attribute - Identifier of the Attribute to retrieve value

    index - Index of element in case Attribute is a table
            Otherwise index must be set to '0'

    ibValue - Pointer to DLL_IB_VALUE object where value will be returned

  Returns:
    Result of get operation as an DLL_RESULT code.

  Example:
    <code>
    DLL_RESULT result;
    DLL_IB_VALUE value;
    result = DLL_GetRequest(LLC_NUM_RETRIES_IB, 0, &value);
    if (result == DLL_RESULT_SUCCESS)
    {

    }
    </code>

  Remarks:
    None.
*/
DLL_RESULT DLL_GetRequest(DLL_IB_ATTRIBUTE attribute, uint16_t index, DLL_IB_VALUE *ibValue);

// *****************************************************************************
/* Function:
    DLL_RESULT DLL_SetRequest(LL_IB_ATTRIBUTE attribute, uint16_t index, const DLL_IB_VALUE *ibValue)

  Summary:
    The DLL_SetRequest primitive sets the value of an attribute in the
    DLL layer Parameter Information Base (IB).

  Description:
    SetRequestSync primitive is used to set the value of an IB.
    Result of set operation is provided upon function call return,
    in the return result code.

  Precondition:
    None.

  Parameters:
    attribute - Identifier of the Attribute to provide value

    index - Index of element in case Attribute is a table
            Otherwise index must be set to '0'

    ibValue - Pointer to DLL_IB_VALUE object where value is contained

  Returns:
    Result of set operation as an DLL_RESULT code.

  Example:
    <code>
    DLL_RESULT result;
    const DLL_IB_VALUE value = {
        .length = 1,
        .value = 6
    };

    result = DLL_SetRequest(LLC_NUM_RETRIES_IB, 0, &value);
    if (result == DLL_RESULT_SUCCESS)
    {

    }
    </code>

  Remarks:
    None.
*/
DLL_RESULT DLL_SetRequest(DLL_IB_ATTRIBUTE attribute, uint16_t index, const DLL_IB_VALUE *ibValue);

#ifdef __cplusplus
 }
#endif

#endif // #ifndef DLL_H
/*******************************************************************************
 End of File
*/
