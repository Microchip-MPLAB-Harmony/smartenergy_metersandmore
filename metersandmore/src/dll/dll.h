/*******************************************************************************
  Interface definition of Meters&More DLL (Data Link Layer) driver.

  Company:
    Microchip Technology Inc.

  File Name:
    LLC.h

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

#define LLC_INSTANCES_NUMBER          1U

/* Sizes */

/* Max LSDU Data length according to Meters&More */
#define MAX_LENGTH_432_DATA 128


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
/* LLC State Machine Definition

  Summary:
    Defines the states of the MAC State Machine.

  Description:
    None.

  Remarks:
    None.
*/
typedef enum
{
    LLC_STATE_IDLE,
    LLC_STATE_WAIT_MAC_READY,
    LLC_STATE_WAITING_TX_CFM,
} LLC_STATE;

/* CTL PF Bit for Meters&More LLC 432 layer
   - Request-response for RA, RB & RC disciplines.
   - Send-No reply for S discipline. */
typedef enum {
    LLC_CTL_SEND_NOREPLY = 0x0,
    LLC_CTL_REQUEST_RESPONSE = 0x1
} LLC_CTL_PF;

/* DSAP (Destination Service Access Point) values for Meters&More LLC 432 layer */
typedef enum {
    LLC_DSAP_APPLICATION_FRAME = 0x0,
    LLC_DSAP_NETWORK_MANAGEMENT = 0x2
} LLC_DSAP;

/* SSAP (Source Service Access Point) values for Meters&More LLC 432 layer - Encryption type:
   - Disabled for network commands
   - AES CTR for LMON recovery
   - AES ECB for common application messages */
typedef enum {
    LLC_SSAP_ENCRYPTION_DISABLED = 0x0,
    LLC_SSAP_ENCRYPTION_AES_CTR = 0x1,
    LLC_SSAP_ENCRYPTION_AES_ECB = 0x2
} LLC_SSAP_ENCRYPTION;

/* SSAP (Source Service Access Point) values for Meters&More LLC 432 layer - Read/Write
  Specifies which key is used (Read or Write). */
typedef enum {
    LLC_SSAP_ENCRYPTION_READ_KEY = 0x0,
    LLC_SSAP_ENCRYPTION_WRITE_KEY = 0x1
} LLC_SSAP_RW;

/* Transmission errors defined in LLC 432 layer */
typedef enum {
    LLC_TX_STATUS_SUCCESS = 0x25,
    LLC_TX_STATUS_ERROR = 0x27
} LLC_TX_STATUS;


// *****************************************************************************
/* Meters&More LLC 4-32 Data request struct

  Summary:
    This struct includes LLC 4-32 DL_Data.request

  Remarks:
    None.
*/
typedef struct {
  /* Control pf bit */
  LLC_CTL_PF ctrlPF,
  /* Destination LSAP */
  LLC_DSAP dsap,
  /* Source LSAP - Encryption */
  LLC_SSAP_ENCRYPTION ssapEncryption,
  /* Source LSAP - Read/Write key. */
  LLC_SSAP_RW ssapRw,
  /* Destination 432 Address */
  uint16_t dstAddress,
  /* Pointer to the data to be sent (max length: MAX_LENGTH_432_DATA) */
  struct LLC_BUFFER *lsdu,
  /* Length of the data */
  uint16_t lsduLen,
  /* Link class (non used) */
  uint8_t linkClass
} LLC_DL_DATA_REQUEST_PARAMS;


// *****************************************************************************
/* Meters&More LLC 4-32 DL_Data.indication struct

  Summary:
    This struct includes LLC 4-32 Data indication

  Remarks:
    None.
*/
typedef struct {
  /* Control pf bit */
  LLC_CTL_PF ctrlPF,
  /* Destination LSAP */
  LLC_DSAP dsap,
  /* Source LSAP - Encryption */
  LLC_SSAP_ENCRYPTION ssapEncryption,
  /* Source LSAP - Read/Write key. */
  LLC_SSAP_RW ssapRw,
  /* Destination 432 Address */
  uint16_t dstAddress,
  /* Source 432 Address */
  uint16_t srcAddress,
  /* Pointer to received data (max length: MAX_LENGTH_432_DATA)*/
  uint8_t *lsdu,
  /* Length of the data */
  uint16_t lsduLen,
  /* Link class (non used) */
  uint8_t linkClass
} LLC_DL_DATA_IND_PARAMS;

// *****************************************************************************
/* Meters&More LLC 4-32 DL_Data.confirm struct

  Summary:
    This struct includes LLC 4-32 Data confirm

  Remarks:
    None.
*/
typedef struct {
    /* Destination LSAP */
    enum LLC_DSAP dsap,
    /* Source LSAP - Encryption */
    enum LLC_SSAP_ENCRYPTION ssapEncryption,
    /* Source LSAP - Read/Write key. */
    enum LLC_SSAP_RW ssapRw,
    /* Destination 432 Address */
    uint16_t dstAddress,
    /* Tx status (see mac_defs.h) ToDo: REVIEW */
    LLC_TX_STATUS txStatus
} LLC_DL_DATA_CONFIRM_PARAMS;


/* Meters&More LLC Driver Initialization Data

  Summary:
    Defines the data required to initialize the Meters&More LLC driver

  Description:


  Remarks:
    None.
*/
typedef struct {
  uint8_t taskRateMs;
} LLC_INIT;

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

    LLC_Tasks(sysObj.drvLLC);
    </code>

  Remarks:
    None.
*/
void LLC_dl_data_request( LLC_DL_DATA_REQUEST_PARAMS *drParams );


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
        ToDo: REVIEW
        switch(indParams->status)
        {
            case LLC_RT_STATUS_SUCCESS:
                break;
            case LLC_RT_STATUS_CHANNEL_ACCESS_FAILURE:
                break;
            case LLC_RT_STATUS_NO_ACK:
                break;
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
        ToDo: REVIEW
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
    SYS_MODULE_OBJ   sysObjDrvMet;

    extern uint8_t met_bin_start;
    extern uint8_t met_bin_end;

    LLC_INIT drvLLCInitData = {
        .regBaseAddress = LLC_REG_BASE_ADDRESS,
        .binStartAddress = (uint32_t)&met_bin_start,
        .binEndAddress = (uint32_t)&met_bin_end,

    };

    sysObjDrvMet = LLC_Initialize((SYS_MODULE_INIT *)&drvLLCInitData);
    </code>

  Remarks:
    This routine must be called before any other LLC routine is called.
*/
SYS_MODULE_OBJ LLC_Initialize(const SYS_MODULE_INDEX index, const SYS_MODULE_INIT * const init);

// *****************************************************************************
/* Function:
    LLC_RESULT LLC_Open (    );

  Summary:
    Opens the LLC driver according to the mode parameter.

  Description:


  Precondition:
    None.

  Parameters:
    None.

  Returns:
    If successful, returns LLC_SUCCESS. Otherwise, it returns LLC_ERROR.

  Example:


  Remarks:
    None.
*/
LLC_RESULT LLC_Open(void);

// *****************************************************************************
/* Function:
    LLC_RESULT LLC_Close (void);

  Summary:
    Closes the LLC driver.

  Description:
    This routine closes the LLC driver making it unusable.

  Precondition:
    None.

  Parameters:
    None.

  Returns:
    If successful, returns LLC_SUCCESS. Otherwise, it returns LLC_ERROR.

  Example:


  Remarks:
    None.
*/
LLC_RESULT LLC_Close (void);

// *****************************************************************************
/* Function:
    LLC_RESULT LLC_dl_data_ind_CallbackRegister(
        const DRV_HANDLE handle,
        LLC_DL_DATA_IND_CALLBACK callback
    );

  Summary:
    Allows a client to set a Meters&More LLC 4-32 DL_Data.indication event handling function
    for the driver to call back when the requested transmission has finished.

  Description:
    This function allows a client to register a Meters&More LLC 4-32 DL_Data.indication event
    handling function for the driver to call back when a Meters&More LLC data indication event
    occurs.

    The event handler should be set before the client submits any transmission
    requests that could generate events. The callback once set, persists until
    the client closes the driver or sets another callback (which could be a
    "NULL" pointer to indicate no callback).

  Precondition:
    LLC_Open must have been called to obtain a valid opened device
    handle.

  Parameters:
    handle   - A valid open-instance handle, returned from the driver's open
               routine.

    callback - Pointer to the callback function.

  Returns:
    None.

  Example:
    <code>
    void APP_Rx_Ind_callback(LLC_DL_DATA_IND_CALLBACK *indParams)
    {
        if (indParams->lsduLen > 0){

        }
    }

    MY_APP_OBJ myAppObj;

    LLC_dl_data_ind_CallbackRegister( myAppObj.myHandle, APP_Rx_Ind_callback );

    LLC_dl_data_request(LLC_DSAP_APPLICATION_FRAME,
    LLC_SSAP_ENCRYPTION_AES_CTR, LLC_SSAP_ENCRYPTION_READ_KEY
    myAppObj.dstAddr, myAppObj.pData, myAppObj.dataLength, 0);
    </code>

*/

LLC_RESULT LLC_dl_data_ind_CallbackRegister(
    const DRV_HANDLE handle,
    LLC_DL_DATA_IND_CALLBACK callback
);

// *****************************************************************************
/* Function:
    LLC_RESULT LLC_dl_data_cfm_CallbackRegister(
        const DRV_HANDLE handle,
        LLC_DL_DATA_CONFIRM_CALLBACK callback
    );

  Summary:
    Allows a client to set a Meters&More LLC 4-32 DL_Data.confirm event handling function
    for the driver to call back when the requested transmission has finished.

  Description:
    This function allows a client to register a Meters&More LLC 4-32 DL_Data.confirm event
    handling function for the driver to call back when a Meters&More LLC data confirm event
    occurs.

    The event handler should be set before the client submits any transmission
    requests that could generate events. The callback once set, persists until
    the client closes the driver or sets another callback (which could be a
    "NULL" pointer to indicate no callback).

  Precondition:
    LLC_Open must have been called to obtain a valid opened device
    handle.

  Parameters:
    handle   - A valid open-instance handle, returned from the driver's open
               routine.

    callback - Pointer to the callback function.

  Returns:
    None.

  Example:
    <code>
    void APP_Tx_Cfm_callback(LLC_DL_DATA_CONFIRM_CALLBACK *cfmParams)
    {
        if (cfmParams->result == LLC_SUCCESS)
        {

        }
        else
        {

        }
    }

    MY_APP_OBJ myAppObj;

    LLC_dl_data_cfm_CallbackRegister( myAppObj.myHandle, APP_Tx_Cfm_callback );

    LLC_dl_data_request(LLC_DSAP_APPLICATION_FRAME,
    LLC_SSAP_ENCRYPTION_AES_CTR, LLC_SSAP_ENCRYPTION_READ_KEY
    myAppObj.dstAddr, myAppObj.pData, myAppObj.dataLength, 0);
    </code>

*/

LLC_RESULT LLC_dl_data_cfm_CallbackRegister(
    const DRV_HANDLE handle,
    LLC_DL_DATA_CONFIRM_CALLBACK callback
);

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
                if (LLC_Start() == LLC_SUCCESS)
                {
                    app_LLCData.state = APP_LLC_STATE_RUNNING;
                }
                else
                {
                    app_LLCData.state = APP_LLC_STATE_ERROR;
                }
            }

            break;
        }
    </code>

  Remarks:
    None.
*/
LLC_STATUS LLC_GetStatus(void);

/* Function:
    SYS_MODULE_OBJ LLC_Tasks (
        SYS_MODULE_OBJ object
    );

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

    LLC_Tasks(sysObj.drvLLC);
    </code>

  Remarks:
    None.
*/
void LLC_Tasks(SYS_MODULE_OBJ object);

#ifdef __cplusplus
 }
#endif

#endif // #ifndef DLL_H
/*******************************************************************************
 End of File
*/
