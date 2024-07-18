/*******************************************************************************
  Interface definition of Meters&More DLL (Data Link Layer) driver.

  Company:
    Microchip Technology Inc.

  File Name:
    dll.h

  Summary:
    Interface definition of Meters&More DLL (Data Link Layer) driver.

  Description:
    This file defines the interface for the Meters&More DLL (Data Link Layer)
    driver.
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
/* Meters&More LLC Driver Result

  Summary:
    Result of a Meters&More LLC driver interface operation.

  Description:
    Identifies the result of certain Meters&More LLC driver operations.
*/
typedef enum
{
    LLC_SUCCESS,
    LLC_ERROR
} LLC_RESULT;


// *****************************************************************************
/* LLC Driver Status

  Summary:
    Defines the status of the LLC driver.

  Description:
    This enumeration defines the status of the LLC Driver:
        - LLC_STATUS_UNINITIALIZED: LLC driver has not been initialized.
        - LLC_STATUS_READY: LLC driver is ready to be used.
  Remarks:
    None.
*/
typedef enum
{
    LLC_STATUS_UNINITIALIZED = SYS_STATUS_UNINITIALIZED,
    LLC_STATUS_READY = SYS_STATUS_READY,
} LLC_STATUS;

// *****************************************************************************
/* DSAP definition

   Summary:
    DSAP (Destination Service Access Point) values for Meters&More LLC layer.

   Description:
    This enumeration identifies the possible DSAP values
    0 - Application Frame
    1 - Network Management

   Remarks:
    None.
*/
typedef enum
{
    LLC_DSAP_APPLICATION_FRAME  = 0x0,
    LLC_DSAP_NETWORK_MANAGEMENT = 0x1
} LLC_DSAP;

// *****************************************************************************
/* ECC definition

   Summary:
    ECC (Encryption Coding Control) values for Meters&More LLC layer.

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
    LLC_ECC_DISABLED = 0x0,
} LLC_ECC;

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
    Transmission results defined in LLC layer.

   Description:
    This enumeration identifies the possible Transmission result values
    0 - Success
    1 - Error

   Remarks:
    None.
*/
typedef enum
{
    LLC_TX_STATUS_SUCCESS = 0x00,
    LLC_TX_STATUS_ERROR   = 0x01
} LLC_TX_STATUS;

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
    A Routing Table Entry is pased to LLC in DL_Data.request, containing
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
/* MAC Event Values

   Summary:
    Identifies the possible MAC Event values.

   Description:
    This enumeration identifies the possible MAC Event values.

   Remarks:
    None.
*/
typedef enum
{
    uint8_t length;
    uint8_t value[MAC_EVENT_VALUE_MAX_LENGTH];
} MAC_EVENT_VALUE;

// *****************************************************************************
/* Meters&More LLC 4-32 Data request struct

  Summary:
    This struct includes LLC 4-32 DL_Data.request

  Remarks:
    None.
*/
typedef struct
{
  /* Pointer to the data to be sent (max length: MAX_LENGTH_432_DATA) */
  uint8_t *lsdu;
  /* Destination LSAP */
  LLC_DSAP dsap;
  /* ECC (Encryption Coding Control) */
  LLC_ECC ecc;
  /* Service class - MASTER ONLY */
  SERVICE_CLASS service_class;
  /* Destination route - MASTER ONLY */
  ROUTING_ENTRY dstAddress;
  /* Max length of the response - MASTER ONLY */
  uint16_t max_resp_len;
  /* Number of time slots alocated in data request with Service_Class RC - MASTER ONLY */
  uint16_t t_slot_num ;
  /* Length of the data */
  uint16_t lsduLen;
} LLC_DL_DATA_REQUEST_PARAMS;


// *****************************************************************************
/* Meters&More LLC 4-32 DL_Data.indication struct

  Summary:
    This struct includes LLC 4-32 Data indication

  Remarks:
    None.
*/
typedef struct
{
  /* Destination LSAP */
  LLC_DSAP dsap;
  /* ECC (Encryption Coding Control) */
  LLC_ECC ecc;
  /* Source address */
  MAC_ADDRESS srcAddress;
  /* Pointer to received data (max length: MAX_LENGTH_432_DATA)*/
  uint8_t *lsdu;
  /* Length of the data */
  uint16_t lsduLen;
} LLC_DL_DATA_IND_PARAMS;

// *****************************************************************************
/* Meters&More LLC 4-32 DL_Data.confirm struct

  Summary:
    This struct includes LLC 4-32 Data confirm

  Remarks:
    None.
*/
typedef struct
{
    /* Destination LSAP */
    LLC_DSAP dsap;
    /* ECC (Encryption Coding Control) */
    LLC_ECC ecc;
    /* Destination address */
    MAC_ADDRESS dstAddress;
    /* Tx status */
    LLC_TX_STATUS txStatus;
} LLC_DL_DATA_CONFIRM_PARAMS;

// *****************************************************************************
/* Meters&More LLC 4-32 DL_Event.indication struct

  Summary:
    This struct includes LLC 4-32 Event indication

  Remarks:
    None.
*/
typedef struct
{
    /* Event Identifier */
    MAC_EVENT_ID eventId;
    /* First additional information */
    MAC_EVENT_VALUE eventValue;
} LLC_DL_EVENT_IND_PARAMS;

// *****************************************************************************
/* Meters&More LLC Driver Initialization Data

  Summary:
    Defines the data required to initialize the Meters&More LLC driver

  Description:


  Remarks:
    None.
*/
typedef struct
{
  /* LLC repeats */
  uint8_t repeats;

  /* ADP task rate in milliseconds */
  uint8_t taskRateMs;

  /* Is master node (false in slave node) */
  bool isMaster;
} LLC_INIT;

// *****************************************************************************
/* Meters&More LLC 4-32 Driver DL_Data.indication Function Pointer

  Summary:
    Pointer to a Meters&More LLC 4-32 Driver DL_Data.indication Function Pointer.

  Description:
    This data type defines the required function signature for the Meters&More LLC 4-32
    driver DL_Data.indication callback function. A client must
    register a pointer using the callback register function whose function
    signature (parameter and return value types) match the types specified by
    this function pointer in order to receive transfer related event calls back
    from the driver.

    The parameters and return values are described here and a partial example
    implementation is provided.

  Parameters:
    indParams - Pointer to the object containing any data necessary to process the
             DL_Data.indication primitive.

  Returns:
    None.

  Example:
    <code>
    void APP_MyDataIndEventHandler( LLC_DL_DATA_IND_PARAMS *indParams )
    {
        if(indParams->lsduLen > 0)
        {

        }
    }
    </code>
*/
typedef void ( *LLC_DL_DATA_IND_CALLBACK )( LLC_DL_DATA_IND_PARAMS *indParams );

// *****************************************************************************
/* Meters&More LLC 4-32 Driver DL_Data.indication Function Pointer

  Summary:
    Pointer to a Meters&More LLC 4-32 Driver DL_Data.indication Function Pointer.

  Description:
    This data type defines the required function signature for the Meters&More LLC 4-32
    driver DL_Data.indication callback function. A client must
    register a pointer using the callback register function whose function
    signature (parameter and return value types) match the types specified by
    this function pointer in order to receive transfer related event calls back
    from the driver.

    The parameters and return values are described here and a partial example
    implementation is provided.

  Parameters:
    cfmParams - Pointer to the object containing any data necessary to identify the
             result of the last transmission.

  Returns:
    None.

  Example:
    <code>
    void APP_MyDataCfmEventHandler( LLC_DL_DATA_CONFIRM_PARAMS *cfmParams )
    {
        switch(cfmParams->uc_tx_status)
        {
            case LLC_TX_STATUS_SUCCESS:
                break;
            case LLC_TX_STATUS_ERROR:
                break;
        }
    }
    </code>

  Remarks:
    - If the status field is LLC_TX_STATUS_SUCCESS, it means that the data was
      transferred successfully.

    - Otherwise, it means that the data was not transferred successfully.

*/
typedef void ( *LLC_DL_DATA_CONFIRM_CALLBACK )( LLC_DL_DATA_CONFIRM_PARAMS *cfmParams );


// *****************************************************************************
/* Meters&More LLC 4-32 Driver DL_Event.indication Function Pointer

  Summary:
    Pointer to a Meters&More LLC 4-32 Driver DL_Event.indication Function Pointer.

  Description:
    This data type defines the required function signature for the Meters&More LLC 4-32
    driver DL_Event.indication callback function. A client must
    register a pointer using the callback register function whose function
    signature (parameter and return value types) match the types specified by
    this function pointer in order to receive transfer related event calls back
    from the driver.

    The parameters and return values are described here and a partial example
    implementation is provided.

  Parameters:
    indParams - Pointer to the object containing any data necessary to process the
             DL_Event.indication primitive.

  Returns:
    None.

  Example:
    <code>
    void APP_MyEventIndEventHandler( LLC_DL_EVENT_IND_PARAMS *indParams )
    {
        if (indParams->lsduLen > 0){

        }
    }
    </code>
*/
typedef void ( *LLC_DL_EVENT_IND_CALLBACK )( LLC_DL_EVENT_IND_PARAMS *indParams );


// *****************************************************************************

// *****************************************************************************
// *****************************************************************************
// Section: Driver System Interface Routines
// *****************************************************************************
// *****************************************************************************

// *****************************************************************************
/* Function:
    SYS_MODULE_OBJ LLC_Initialize (
      const SYS_MODULE_INDEX index,
      const SYS_MODULE_INIT * const init
    );

  Summary:
    Initializes the Meters&More LLC driver according to the init parameter and the cause of the reset of the main processor.

  Description:
    This routine initializes the Meters&More LLC driver making it ready for clients to open and use.
    The initialization data is specified by the init parameter.
    It is a single instance driver.

  Precondition:
    The low-level processor and board initialization must be completed before the
    system can call the initialization functions for any modules.

  Parameters:
    index - Identifier for the instance to be initialized (single instance allowed)
    init  - Pointer to the init data structure containing any data necessary to initialize the driver.
    resetCause - Reset cause of the main processor.

  Returns:
    If successful, returns a valid handle to a driver instance object.
    Otherwise, it returns SYS_MODULE_OBJ_INVALID.

  Example:
    <code>
    SYS_MODULE_OBJ   sysObjMetersandmore;

    LLC_INIT llcInitData = {
        .taskRateMs = 1U
    };

    sysObjMetersandmore = LLC_Initialize((SYS_MODULE_INIT *)&llcInitData);
    </code>

  Remarks:
    This routine must be called before any other LLC routine is called.
*/
SYS_MODULE_OBJ LLC_Initialize(const SYS_MODULE_INDEX index, const SYS_MODULE_INIT * const init);


// *****************************************************************************
/* Function:
    LLC_RESULT LLC_dl_data_ind_CallbackRegister(LLC_DL_DATA_IND_CALLBACK callback);

  Summary:
    Allows a client to set a Meters&More LLC 4-32 DL_Data.indication event handling function
    for the driver to call back when the requested transmission has finished.

  Description:
    This function allows a client to register a Meters&More LLC 4-32 DL_Data.indication event
    handling function for the driver to call back when a Meters&More LLC data indication event
    occurs.

    The callback once set, persists until the client closes the driver or sets another callback
    (which could be a "NULL" pointer to indicate no callback).

  Parameters:
    callback - Pointer to the callback function.

  Returns:
    None.

  Example:
    <code>
    void APP_Rx_Ind_callback(LLC_DL_DATA_IND_PARAMS *indParams)
    {
        if (indParams->lsduLen > 0){

        }
    }

    LLC_dl_data_ind_CallbackRegister( APP_Rx_Ind_callback );
    </code>

*/
LLC_RESULT LLC_dl_data_ind_CallbackRegister(LLC_DL_DATA_IND_CALLBACK callback);

// *****************************************************************************
/* Function:
    LLC_RESULT LLC_dl_data_cfm_CallbackRegister(LLC_DL_DATA_CONFIRM_CALLBACK callback);

  Summary:
    Allows a client to set a Meters&More LLC 4-32 DL_Data.confirm event handling function
    for the driver to call back when the requested transmission has finished.

  Description:
    This function allows a client to register a Meters&More LLC 4-32 DL_Data.confirm event
    handling function for the driver to call back when a Meters&More LLC data confirm event
    occurs.

    The callback once set, persists until the client closes the driver or sets another callback
    (which could be a "NULL" pointer to indicate no callback).

  Parameters:
    callback - Pointer to the callback function.

  Returns:
    None.

  Example:
    <code>
    void APP_Tx_Cfm_callback(LLC_DL_DATA_CONFIRM_PARAMS *cfmParams)
    {
        if (cfmParams->result == LLC_SUCCESS)
        {

        }
        else
        {

        }
    }

    LLC_dl_data_cfm_CallbackRegister( APP_Tx_Cfm_callback );

    </code>

*/
LLC_RESULT LLC_dl_data_cfm_CallbackRegister(LLC_DL_DATA_CONFIRM_CALLBACK callback);

// *****************************************************************************
/* Function:
    LLC_RESULT LLC_dl_event_ind_CallbackRegister(LLC_DL_EVENT_IND_CALLBACK callback);

  Summary:
    Allows a client to set a Meters&More LLC 4-32 DL_Event.indication event handling function
    for the driver to call back when DLL generates a new event.

  Description:
    This function allows a client to register a Meters&More LLC 4-32 DL_Event.indication event
    handling function for the driver to call back when a Meters&More LLC event occurs.

    The callback once set, persists until the client closes the driver or sets another callback
    (which could be a "NULL" pointer to indicate no callback).

  Parameters:
    callback - Pointer to the callback function.

  Returns:
    None.

  Example:
    <code>
    void APP_Event_Ind_callback(LLC_DL_EVENT_IND_CALLBACK *indParams)
    {
        if (indParams->lsduLen > 0){

        }
    }

    LLC_dl_event_ind_CallbackRegister( APP_Event_Ind_callback );
    </code>

*/
LLC_RESULT LLC_dl_event_ind_CallbackRegister(LLC_DL_EVENT_IND_CALLBACK callback);

// *****************************************************************************
/* Function:
    void LLC_dl_data_request(LLC_DL_DATA_REQUEST_PARAMS *drParams);

  Summary:
    LLC 4-32 Data request

  Description:
    Function that implements the LLC 4-32 DL_Data.request primitive

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
    LLC_DL_DATA_REQUEST_PARAMS drParams;
    ROUTING_ENTRY addr;

    drParams.dsap = LLC_DSAP_APPLICATION_FRAME;
    drParams.ecc = LLC_ECC_DISABLED;
    drParams.lsdu = appPlcTxDataBuffer;
    drParams.service_class = SERVICE_CLASS_RA;
    drParams.dstAddress = addr;
    drParams.max_resp_len = 128;
    drParams.t_slot_num = 8;
    drParams.lsduLen = 10;

    LLC_dl_data_request(&drParams);
    </code>

  Remarks:
    None.
*/
void LLC_dl_data_request(LLC_DL_DATA_REQUEST_PARAMS *drParams);

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
    LLC_DL_DATA_REQUEST_PARAMS drParams;
    ROUTING_ENTRY addr;
    uint32_t responseWaitTimeout;

    drParams.dsap = LLC_DSAP_APPLICATION_FRAME;
    drParams.ecc = LLC_ECC_DISABLED;
    drParams.lsdu = appPlcTxDataBuffer;
    drParams.service_class = SERVICE_CLASS_RA;
    drParams.dstAddress = addr;
    drParams.max_resp_len = 128;
    drParams.t_slot_num = 8;
    drParams.lsduLen = 10;

    LLC_dl_data_request(&drParams);

    responseWaitTimeout = DLL_GetTxTimeout();
    </code>

  Remarks:
    None.
*/
uint32_t DLL_GetTxTimeout(void);

// *****************************************************************************
/* Function:
    LLC_STATUS LLC_GetStatus(void);

  Summary:
    Get the status of the LLC driver.

  Description:
    LLC function status:
        - LLC_STATUS_UNINITIALIZED: LLC driver has not been initialized.
        - LLC_STATUS_IDLE: LLC library is idle.
        acquisition is performed.

    These status values are closely related to the Meters&Mores LLC library states.
    For further information about the Meters&Mores LLC library state diagram, refer to online documentation.

  Precondition:
    None.

  Parameters:
    None.

  Returns:
    Returns the status of the Meters&Mores LLC driver.

  Example:
    <code>
        case APP_LLC_STATE_START:
        {
            if (LLC_GetStatus() == LLC_STATUS_READY)
            {
              app_LLCData.state = APP_LLC_STATE_RUNNING;
            }

            break;
        }
    </code>

  Remarks:
    None.
*/
LLC_STATUS LLC_GetStatus(void);

// *****************************************************************************
/* Function:
    SYS_MODULE_OBJ LLC_Tasks (SYS_MODULE_OBJ object);

  Summary:
    Routine that performs the tasks necessary to maintain a state machine in
    the Meters&Mores LLC driver.

  Description:
    Routine that performs the tasks necessary to maintain a state machine in
    the Meters&Mores LLC driver.

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

    LLC_Tasks(sysObj.metersandmore);
    </code>

  Remarks:
    None.
*/
void LLC_Tasks(SYS_MODULE_OBJ object);

// *****************************************************************************
/* Function:
    LLC_RESULT DLL_GetRequest(DLL_IB_ATTRIBUTE attribute, uint16_t index, DLL_IB_VALUE *ibValue)

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
    Result of get operation as an LLC_RESULT code.

  Example:
    <code>
    LLC_RESULT result;
    DLL_IB_VALUE value;
    result = DLL_GetRequest(LLC_NUM_RETRIES_IB, 0, &value);
    if (result == LLC_RESULT_SUCCESS)
    {

    }
    </code>

  Remarks:
    None.
*/
LLC_RESULT DLL_GetRequest(DLL_IB_ATTRIBUTE attribute, uint16_t index, DLL_IB_VALUE *ibValue);

// *****************************************************************************
/* Function:
    LLC_RESULT DLL_SetRequest(LL_IB_ATTRIBUTE attribute, uint16_t index, const DLL_IB_VALUE *ibValue)

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
    Result of set operation as an LLC_RESULT code.

  Example:
    <code>
    LLC_RESULT result;
    const DLL_IB_VALUE value = {
        .length = 1,
        .value = 6
    };

    result = DLL_SetRequest(LLC_NUM_RETRIES_IB, 0, &value);
    if (result == LLC_RESULT_SUCCESS)
    {

    }
    </code>

  Remarks:
    None.
*/
LLC_RESULT DLL_SetRequest(DLL_IB_ATTRIBUTE attribute, uint16_t index, const DLL_IB_VALUE *ibValue);

#ifdef __cplusplus
 }
#endif

#endif // #ifndef DLL_H
/*******************************************************************************
 End of File
*/
