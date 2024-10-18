/* ************************************************************************** */

#include <string.h>
#include "stack/metersandmore/dll/dll.h"
#include "al_local.h"
#include "service/random/srv_random.h"
#include "service/pcrc/srv_pcrc.h"
#include "system/time/sys_time.h"
#include "crypto/common_crypto/MCHP_Crypto_Mac_Cipher.h"

#define ENCRYPTED_MESSAGE_HEADER_LENGTH     17U
#define AES_CMAC_LENGTH                     8U
#define RETRIES_LIMIT                       2U

uint8_t process_buff[MAX_LENGTH_432_DATA];
uint8_t dll_Tx_buffer[MAX_LENGTH_432_DATA];

static AL_DATA alData;

static DLL_DATA_REQUEST_PARAMS drParams;
static uint32_t confirmWaitTimeoutUs;
static uint64_t confirmWaitCount, nextwaitCount;
static DATETIME received_time, request_time;  

crypto_Mac_Status_E Cmac_status;

static ACA_NW_REQ ACA_Request;
static ACA_NW_RESP ACA_req_resp[4];
static uint8_t ACA_req_resp_count=0, retry_count;

static struct
{
    crypto_HandlerType_E crypto_handle;
    crypto_Sym_OpModes_E operating_mode;
    uint8_t *ptr_inputData;
    uint32_t inputDataLen;
    uint8_t *ptr_outData;
    uint8_t *ptr_key;
    uint32_t keyLen;
    uint8_t *ptr_initVect;
    uint32_t sessionID;
}AL_Downstream;

static struct
{
    crypto_HandlerType_E crypto_handle;
    crypto_Sym_OpModes_E operating_mode;
    uint8_t *ptr_inputData;
    uint32_t inputDataLen;
    uint8_t *ptr_outData;
    uint8_t *ptr_key;
    uint32_t keyLen;
    uint8_t *ptr_initVect;
    uint32_t sessionID;
}AL_Upstream;

static bool EncryptData_dll(uint8_t *data, uint8_t size, uint8_t *encrypted_data, uint8_t Operating_mode, uint8_t *key, uint8_t *counter_block)
{
    crypto_Sym_Status_E ret_val=0;
    
    AL_Downstream.crypto_handle = CRYPTO_HANDLER_SW_WOLFCRYPT; 
    AL_Downstream.operating_mode = Operating_mode;
    AL_Downstream.ptr_inputData = data;
    AL_Downstream.inputDataLen = size;
    AL_Downstream.ptr_outData = encrypted_data;
    AL_Downstream.ptr_key = key;
    AL_Downstream.keyLen = 16;
    AL_Downstream.ptr_initVect = counter_block;
    AL_Downstream.sessionID = 1;
    
    ret_val = Crypto_Sym_Aes_EncryptDirect(AL_Downstream.crypto_handle, AL_Downstream.operating_mode, AL_Downstream.ptr_inputData, 
                     AL_Downstream.inputDataLen, AL_Downstream.ptr_outData, AL_Downstream.ptr_key, AL_Downstream.keyLen, AL_Downstream.ptr_initVect, AL_Downstream.sessionID);
    
    if(ret_val == CRYPTO_SYM_CIPHER_SUCCESS)
        return true;
    else
        //TO_DO Handle Error messages for Encryption/Decryption 
        return false;
}

static crypto_Sym_Status_E DecryptData_Comm(uint8_t *data, uint8_t size, uint8_t *decrypted_data, uint8_t Operating_mode, uint8_t *key, uint8_t *counter_block)
{
    crypto_Sym_Status_E ret_val=0;
    
    AL_Upstream.crypto_handle = CRYPTO_HANDLER_SW_WOLFCRYPT; 
    AL_Upstream.operating_mode = Operating_mode;
    AL_Upstream.ptr_inputData = data;
    AL_Upstream.inputDataLen = size;
    AL_Upstream.ptr_outData = decrypted_data;
    AL_Upstream.ptr_key = key;
    AL_Upstream.keyLen = 16;
    AL_Upstream.ptr_initVect = counter_block;
    AL_Upstream.sessionID = 1;
    
    ret_val = Crypto_Sym_Aes_DecryptDirect(AL_Upstream.crypto_handle, AL_Upstream.operating_mode, AL_Upstream.ptr_inputData, 
                     AL_Upstream.inputDataLen, AL_Upstream.ptr_outData, AL_Upstream.ptr_key, AL_Upstream.keyLen, AL_Upstream.ptr_initVect, AL_Upstream.sessionID);
    
    return ret_val;
}

void counter_block_generation( uint64_t Msg_Order )
{
    DLL_IB_VALUE getValue;

    (void) DLL_GetRequest(MAC_ACA_ADDRESS_IB, 0, &getValue);

    memset(alData.keys.Counter_block, 0, KEY_LENGTH);
    
    alData.keys.Counter_block[0] = 1;
    memcpy(&alData.keys.Counter_block[2], &Msg_Order, 8);
    memcpy(&alData.keys.Counter_block[10], getValue.value, MAC_ADDRESS_SIZE);
}

static bool address_filtering( void )
{
    uint8_t address_byte;
    DLL_IB_VALUE getValue;

    (void) DLL_GetRequest(MAC_ACA_ADDRESS_IB, 0, &getValue);
    
    /* Last byte of Meter ACA */
    address_byte = getValue.value[5];
    
    address_byte = address_byte + ACA_Request.AddToAddress;
    /* address_byte = address_byte>>ACA_Request.RightShiftAdd; */

    if((address_byte % 2) == 1)
        return false;
    else if((address_byte % 2) == 0)
        return true;
    
    return false;
}

void AL_DataRequest( AL_DATA_REQ_PARAMS *reqParams )
{
    uint8_t process_bytes;
    DLL_IB_VALUE getValue;

    if( alData.isMaster )
    {
        /* Clear the Event Flag when new request received */
        alData.AL_Status.flags.DL_Event_sent = 0;
        
        if(( reqParams->Txdata != NULL ) && ( alData.state == AL_STATE_APP_PROCESS ) && ( SYS_TIME_Counter64Get() > nextwaitCount ))
        {
            switch (reqParams->Txdata[0])
            {
                case ADDRESS_REQ:
                case ADDRESS_RESP:
                case TCT_SET_REQ:
                case REQ_ADDRESS_REQ:
                case REQ_ADDRESS_RESP:
                case NACK_RESP:

                    drParams.lsdu = reqParams->Txdata;
                    drParams.lsduLen = reqParams->Txdata_Len;
                    drParams.dsap = DLL_DSAP_NETWORK_MANAGEMENT;
                    drParams.ecc = DLL_ECC_DISABLED;
                    drParams.serviceClass = reqParams->serviceClass;
                    drParams.timeSlotNum = reqParams->timeSlotNum;
                    memcpy(&drParams.dstAddress, &reqParams->dstAddress, sizeof(ROUTING_ENTRY));                /* testing needed */      
                    drParams.maxResponseLen = reqParams->maxResponseLen;

                    DLL_DataRequest(&drParams);
                    alData.AL_Status.flags.DL_Request_sent = 1;                                                        /* Network message Handling */

                    confirmWaitTimeoutUs = DLL_GetTxTimeout();                                                  /* ConfirmWait in uSec*/
                    confirmWaitCount = SYS_TIME_USToCount( confirmWaitTimeoutUs );
                    nextwaitCount = confirmWaitCount + SYS_TIME_Counter64Get();
                    
                    break;

                case CHALLENGE_REQ:

                    /* Storing Node info to use during DLL_IND */
                    memset(&alData.comm_node_configdata, 0, sizeof(NODE_INFO));
                    memcpy(alData.comm_node_configdata.ACA, reqParams->node_info.ACA, MAC_ADDRESS_SIZE);                          /* Use in Challenge_response Ind process */
                    memcpy(alData.comm_node_configdata.lmon.buff, reqParams->node_info.lmon.buff, LMON_LENGTH);             /* Not sure to use in Challenge_response Ind process */
                    
                    memset(alData.Transmit_Buff, 0, MAX_LENGTH_432_DATA);
                    memset(&alData.random_number, 0, 16);

                    alData.Transmit_Buff[0] = reqParams->Txdata[0];
                    SRV_RANDOM_Get128bits(alData.random_number);
                    memcpy(&alData.Transmit_Buff[3], alData.random_number, 16);

                    drParams.dsap = DLL_DSAP_APPLICATION_FRAME;                                     
                    drParams.ecc = DLL_ECC_DISABLED;
                    drParams.serviceClass = reqParams->serviceClass;
                    drParams.timeSlotNum = reqParams->timeSlotNum;
                    memcpy(&drParams.dstAddress, &reqParams->dstAddress, sizeof(ROUTING_ENTRY));    /* testing needed */      
                    drParams.maxResponseLen = reqParams->maxResponseLen;
                    drParams.lsduLen = 19;                                                          /* CM+T+Random.NO 19 bytes */
                    drParams.lsdu = alData.Transmit_Buff;

                    DLL_DataRequest(&drParams);
                    alData.AL_Status.flags.DL_Request_sent = 1;                                            /* Network message Handling */
                    
                    confirmWaitTimeoutUs = DLL_GetTxTimeout();                                      /* ConfirmWait in uSec*/
                    confirmWaitCount = SYS_TIME_USToCount( confirmWaitTimeoutUs );
                    nextwaitCount = confirmWaitCount + SYS_TIME_Counter64Get();

                    break;

                case CHALLENGE_RESP:    

                    break; 

                case WRITE_REQ:
                case WRITETAB_REQ:
                case SETTAB_REQ:
                case RESETTAB_REQ:
                case SETIC_REQ:
                case WRITETABIC_REQ:
                case READ_REQ:
                case READ_RESP :
                case READTAB_REQ_SEL:
                case READTAB_RESP_SEL:
                case READTAB_REQ:
                case READTAB_RESP:
                case GETTAB_REQ:
                case GETTAB_RESP:
                case DATASPONT:
                case REPROG_LOCAL:
                case REPROG_BROADCAST:
                case COMMAND:

                    drParams.lsdu = reqParams->Txdata;
                    drParams.lsduLen = reqParams->Txdata_Len;
                    drParams.dsap = DLL_DSAP_APPLICATION_FRAME;
                    drParams.ecc = DLL_ECC_DISABLED;
                    drParams.serviceClass = reqParams->serviceClass;
                    drParams.timeSlotNum = reqParams->timeSlotNum;
                    memcpy(&drParams.dstAddress, &reqParams->dstAddress, sizeof(ROUTING_ENTRY));                      /* testing needed */      
                    drParams.maxResponseLen = reqParams->maxResponseLen;
                    
                    DLL_DataRequest(&drParams);
                    alData.AL_Status.flags.DL_Request_sent = 1;

                    confirmWaitTimeoutUs = DLL_GetTxTimeout();                                          /* ConfirmWait in uSec*/
                    confirmWaitCount = SYS_TIME_USToCount( confirmWaitTimeoutUs );
                    nextwaitCount = confirmWaitCount + SYS_TIME_Counter64Get();
                    
                    break;

                case WRITE_REQ_AUTH:     
                case WRITETAB_REQ_AUTH:  
                case SETTAB_REQ_AUTH:    
                case RESETTAB_REQ_AUTH:  
                case SETIC_REQ_AUTH:      
                case WRITETABIC_REQ_AUTH: 

                    /* Storing Node info to use during DLL_IND */
                    memset(&alData.comm_node_configdata, 0, sizeof(NODE_INFO));
                    memcpy(alData.comm_node_configdata.ACA, reqParams->node_info.ACA, MAC_ADDRESS_SIZE);
                    memcpy(alData.comm_node_configdata.lmon.buff, reqParams->node_info.lmon.buff, LMON_LENGTH);
                    request_time.value = reqParams->timestamp;
                    
                    /* Updating CMON with new LMON received from Request and increment by 1 */
                    alData.cmon.value = alData.comm_node_configdata.lmon.value + 1;
                    
                    memset(alData.Transmit_Buff, 0, MAX_LENGTH_432_DATA);
                    alData.Transmit_Buff[0] = reqParams->Txdata[0];

                    memset(alData.crc.buffer, 0, MAX_LENGTH_432_DATA);
                    memcpy(alData.crc.buffer, alData.comm_node_configdata.ACA, MAC_ADDRESS_SIZE);                                /* Node ACA */
                    alData.crc.dataLen = MAC_ADDRESS_SIZE;
                    memcpy(&alData.crc.buffer[alData.crc.dataLen], &reqParams->Txdata[1], reqParams->Txdata_Len-1);
                    alData.crc.dataLen += reqParams->Txdata_Len-1;
                    alData.crc.result = SRV_PCRC_GetValue(alData.crc.buffer, alData.crc.dataLen, PCRC_HT_GENERIC, PCRC_CRC32, 1);                                         /* CRC Calculation */  
                    
                    memset(alData.cmac.inputBuf, 0, sizeof(alData.cmac.inputBuf));
                    alData.cmac.inputBuf[0] = reqParams->Txdata[0];                                                    /* CM */
                    alData.cmac.input_dataLen = 1;
                    memcpy(&alData.cmac.inputBuf[alData.cmac.input_dataLen], alData.comm_node_configdata.ACA, 3);                    /* Node ACA 3bytes(LSB) */ 
                    alData.cmac.input_dataLen += 3;
                    memcpy(&alData.cmac.inputBuf[alData.cmac.input_dataLen], alData.cmon.buff, CMON_LENGTH);             /* CMON (LMON+1) used for CMAC generation in CCU */
                    alData.cmac.input_dataLen += CMON_LENGTH;
                    memcpy(&alData.cmac.inputBuf[alData.cmac.input_dataLen], &alData.crc.result, 4);                                 /* CRC(ACA,DATA) */
                    alData.cmac.input_dataLen += 4;
                    memcpy(alData.cmac.key, alData.keys.Write_Key, 16);                                                /* KEY */

                    Cmac_status = Crypto_Mac_AesCmac_Direct(CRYPTO_HANDLER_SW_WOLFCRYPT, alData.cmac.inputBuf, alData.cmac.input_dataLen, alData.cmac.Computed_cmac, AES_CMAC_LENGTH, alData.cmac.key, KEY_LENGTH, 1);

                    if (Cmac_status == CRYPTO_MAC_CIPHER_SUCCESS)
                    {    
                        /* Encryption of Meter Data, POSIX timestamp, CMAC */
                        memset(dll_Tx_buffer, 0, MAX_LENGTH_432_DATA);
                        memcpy(dll_Tx_buffer, &reqParams->Txdata[1], reqParams->Txdata_Len-1);                  /* Tx DATA */
                        process_bytes = reqParams->Txdata_Len-1;
                        memcpy(&dll_Tx_buffer[process_bytes], &reqParams->timestamp, 8);                        /* POSIX Time stamp */
                        process_bytes += 8;
                        memcpy(&dll_Tx_buffer[process_bytes], alData.cmac.Computed_cmac, 8);                           /* LSB 64bits of CMAC */
                        process_bytes += 8;

                        counter_block_generation(alData.cmon.value);                                       /* IV generation */
                        
                        if(EncryptData_dll(dll_Tx_buffer, process_bytes, &alData.Transmit_Buff[1], CRYPTO_SYM_OPMODE_CTR, alData.keys.Write_Key, alData.keys.Counter_block) == true)
                        {
                            drParams.dsap = DLL_DSAP_APPLICATION_FRAME;
                            drParams.ecc = DLL_ECC_DISABLED;
                            drParams.lsduLen = process_bytes+1;                                                 /* CM */
                            drParams.lsdu = alData.Transmit_Buff;
                            drParams.serviceClass = reqParams->serviceClass;
                            drParams.timeSlotNum = reqParams->timeSlotNum;
                            memcpy(&drParams.dstAddress, &reqParams->dstAddress, sizeof(ROUTING_ENTRY));        /* testing needed */      
                            drParams.maxResponseLen = reqParams->maxResponseLen;
                            
                            DLL_DataRequest(&drParams);
                            alData.AL_Status.flags.DL_Request_sent = 1;

                            confirmWaitTimeoutUs = DLL_GetTxTimeout();                                          /* ConfirmWait in uSec*/
                            confirmWaitCount = SYS_TIME_USToCount( confirmWaitTimeoutUs );
                            nextwaitCount = confirmWaitCount + SYS_TIME_Counter64Get();
                        }    
                    }    

                    break; 


                case READ_REQ_AUTH:       
                case READ_RESP_AUTH:      
                case READTAB_REQ_SEL_AUTH:    
                case READTAB_RESP_SEL_AUTH:
                case READTAB_REQ_AUTH:    
                case READTAB_RESP_AUTH:
                case GETTAB_REQ_AUTH:     
                case GETTAB_RESP_AUTH:    
                case DATASPONT_AUTH:          
                case COMMAND_AUTH:            

                    /* Storing Node info to use during DLL_IND */
                    memset(&alData.comm_node_configdata, 0, sizeof(NODE_INFO));
                    memcpy(alData.comm_node_configdata.ACA, reqParams->node_info.ACA, MAC_ADDRESS_SIZE);
                    memcpy(alData.comm_node_configdata.lmon.buff, reqParams->node_info.lmon.buff, LMON_LENGTH);
                    request_time.value = reqParams->timestamp;
                    
                    /* Updating CMON with new LMON received from Request and increment by 1 */
                    alData.cmon.value = alData.comm_node_configdata.lmon.value + 1;
                    
                    memset(alData.Transmit_Buff, 0, MAX_LENGTH_432_DATA);
                    alData.Transmit_Buff[0] = reqParams->Txdata[0];

                    memset(alData.crc.buffer, 0, MAX_LENGTH_432_DATA);
                    memcpy(alData.crc.buffer, alData.comm_node_configdata.ACA, MAC_ADDRESS_SIZE);                                /* Node ACA */
                    alData.crc.dataLen = MAC_ADDRESS_SIZE;
                    memcpy(&alData.crc.buffer[alData.crc.dataLen], &reqParams->Txdata[1], reqParams->Txdata_Len-1);
                    alData.crc.dataLen += reqParams->Txdata_Len-1;
                    alData.crc.result = SRV_PCRC_GetValue(alData.crc.buffer, alData.crc.dataLen, PCRC_HT_GENERIC, PCRC_CRC32, 1);                                         /* CRC Calculation */  

                    memset(alData.cmac.inputBuf, 0, sizeof(alData.cmac.inputBuf));
                    alData.cmac.inputBuf[0] = reqParams->Txdata[0];                                                    /* CM */
                    alData.cmac.input_dataLen = 1;
                    memcpy(&alData.cmac.inputBuf[alData.cmac.input_dataLen], alData.comm_node_configdata.ACA, 3);                 /* Node ACA 3bytes(LSB) */ 
                    alData.cmac.input_dataLen += 3;
                    memcpy(&alData.cmac.inputBuf[alData.cmac.input_dataLen], alData.cmon.buff, LMON_LENGTH);             /* CMON (LMON+1) used for CMAC generation in CCU */
                    alData.cmac.input_dataLen += LMON_LENGTH;
                    memcpy(&alData.cmac.inputBuf[alData.cmac.input_dataLen], &alData.crc.result, 4);                                 /* CRC(ACA,DATA) */
                    alData.cmac.input_dataLen += 4;
                    memcpy(alData.cmac.key, alData.keys.Read_Key, 16);                                                        /* KEY */

                    Cmac_status = Crypto_Mac_AesCmac_Direct(CRYPTO_HANDLER_SW_WOLFCRYPT, alData.cmac.inputBuf, alData.cmac.input_dataLen, alData.cmac.Computed_cmac, AES_CMAC_LENGTH, alData.cmac.key, KEY_LENGTH, 1);

                    if (Cmac_status == CRYPTO_MAC_CIPHER_SUCCESS)
                    {    
                        /* Encryption of Meter Data, POSIX timestamp, CMAC */
                        memset(dll_Tx_buffer, 0, MAX_LENGTH_432_DATA);
                        memcpy(dll_Tx_buffer, &reqParams->Txdata[1], reqParams->Txdata_Len-1);
                        process_bytes = reqParams->Txdata_Len-1;
                        memcpy(&dll_Tx_buffer[process_bytes], &reqParams->timestamp, 8);
                        process_bytes += 8;
                        memcpy(&dll_Tx_buffer[process_bytes], alData.cmac.Computed_cmac, 8);
                        process_bytes += 8;

                        counter_block_generation(alData.cmon.value);                       /* IV generation */
                        
                        if(EncryptData_dll(dll_Tx_buffer, process_bytes, &alData.Transmit_Buff[1], CRYPTO_SYM_OPMODE_CTR, alData.keys.Read_Key, alData.keys.Counter_block) == true)
                        {
                            drParams.dsap = DLL_DSAP_APPLICATION_FRAME;
                            drParams.ecc = DLL_ECC_DISABLED;
                            drParams.lsduLen = process_bytes+1;                                 /* CM */
                            drParams.lsdu = alData.Transmit_Buff;
                            drParams.serviceClass = reqParams->serviceClass;
                            drParams.timeSlotNum = reqParams->timeSlotNum;
                            memcpy(&drParams.dstAddress, &reqParams->dstAddress, sizeof(ROUTING_ENTRY));                      /* testing needed */      
                            drParams.maxResponseLen = reqParams->maxResponseLen;
                    
                            DLL_DataRequest(&drParams);
                            alData.AL_Status.flags.DL_Request_sent = 1;

                            confirmWaitTimeoutUs = DLL_GetTxTimeout();                                          /* ConfirmWait in uSec*/
                            confirmWaitCount = SYS_TIME_USToCount( confirmWaitTimeoutUs );
                            nextwaitCount = confirmWaitCount + SYS_TIME_Counter64Get();
                        }    
                    }    
                    break;

            /*  case Concentrator_ACK:                                                          // No ACK/NACK CM from CCU in Spec.Doc 
                
                    break;  */
            }
        }
    }
    else
    {
        if(( reqParams->Txdata != NULL ) && ( alData.state == AL_STATE_APP_PROCESS ) && ( SYS_TIME_Counter64Get() > nextwaitCount ))
        {
            (void) DLL_GetRequest(MAC_ACA_ADDRESS_IB, 0, &getValue);

            switch (reqParams->Txdata[0])
            {
                case ADDRESS_REQ:
                case ADDRESS_RESP:
                case REQ_ADDRESS_RESP:
                case NACK_RESP:

                    drParams.lsdu = reqParams->Txdata;
                    drParams.lsduLen = reqParams->Txdata_Len;
                    drParams.dsap = DLL_DSAP_NETWORK_MANAGEMENT;
                    drParams.ecc = DLL_ECC_DISABLED;

                    DLL_DataRequest(&drParams);
                    alData.AL_NWStatus.flags.ACA_ACK_sent = 1;                                                 /* Network message Handling */

                    confirmWaitTimeoutUs = DLL_GetTxTimeout();                                          /* ConfirmWait in uSec*/
                    confirmWaitCount = SYS_TIME_USToCount( confirmWaitTimeoutUs );
                    nextwaitCount = confirmWaitCount + SYS_TIME_Counter64Get();
                    
                    break;

                case CHALLENGE_REQ:

                    break;

                case CHALLENGE_RESP:    

                    if(alData.lmon_recovery.challenge_req_received == 1)
                    {    
                        alData.Transmit_Buff[0] = reqParams->Txdata[0];
                        memset(alData.crc.buffer, 0, MAX_LENGTH_432_DATA);
                        memcpy(alData.crc.buffer, getValue.value, MAC_ADDRESS_SIZE);
                        alData.crc.dataLen = MAC_ADDRESS_SIZE;
                        memcpy(&alData.crc.buffer[alData.crc.dataLen], alData.lmon_recovery.random_num, 16);
                        alData.crc.dataLen += 16;
                        alData.crc.result = SRV_PCRC_GetValue(alData.crc.buffer, alData.crc.dataLen, PCRC_HT_GENERIC, PCRC_CRC32, 1);                         /* CRC Calculation */  

                        memset(alData.cmac.inputBuf, 0, sizeof(alData.cmac.inputBuf));
                        alData.cmac.inputBuf[0] = reqParams->Txdata[0];                                    /* CM */
                        alData.cmac.input_dataLen = 1;
                        memcpy(&alData.cmac.inputBuf[alData.cmac.input_dataLen], getValue.value, 3);             /* ACA 3bytes(LSB) */
                        alData.cmac.input_dataLen += 3;
                        memcpy(&alData.cmac.inputBuf[alData.cmac.input_dataLen], alData.lmon.buff, LMON_LENGTH);       /* LMON used for CMAC generation in Meter */
                        alData.cmac.input_dataLen += LMON_LENGTH;
                        memcpy(&alData.cmac.inputBuf[alData.cmac.input_dataLen], &alData.crc.result, 4);                 /* CRC(ACA,DATA) */
                        alData.cmac.input_dataLen += 4;
                        memcpy(alData.cmac.key, alData.keys.Write_Key, 16);                                       /* KEY */

                        Cmac_status = Crypto_Mac_AesCmac_Direct(CRYPTO_HANDLER_SW_WOLFCRYPT, alData.cmac.inputBuf, alData.cmac.input_dataLen, alData.cmac.Computed_cmac, AES_CMAC_LENGTH, alData.cmac.key, KEY_LENGTH, 1);

                        if (Cmac_status == CRYPTO_MAC_CIPHER_SUCCESS)
                        {    
                            memset(dll_Tx_buffer, 0, MAX_LENGTH_432_DATA);
                            memcpy(dll_Tx_buffer, alData.lmon.buff, LMON_LENGTH);
                            process_bytes = LMON_LENGTH;
                            memcpy(&dll_Tx_buffer[LMON_LENGTH], alData.cmac.Computed_cmac, LMON_LENGTH);
                            process_bytes += LMON_LENGTH;

                            /* ECB mode doesn't require Counter Block */
                            if(EncryptData_dll(dll_Tx_buffer, process_bytes, &alData.Transmit_Buff[3], CRYPTO_SYM_OPMODE_ECB, alData.keys.Write_Key, NULL ) == true)
                            {
                                drParams.dsap = DLL_DSAP_APPLICATION_FRAME;
                                drParams.ecc = DLL_ECC_DISABLED;
                                drParams.lsduLen = process_bytes+3;                                 /* CM+T 3bytes */
                                drParams.lsdu = alData.Transmit_Buff;

                                DLL_DataRequest(&drParams);
                                alData.lmon_recovery.challenge_req_received = 0;
                                
                                confirmWaitTimeoutUs = DLL_GetTxTimeout();                          /* ConfirmWait in uSec*/
                                confirmWaitCount = SYS_TIME_USToCount( confirmWaitTimeoutUs );
                                nextwaitCount = confirmWaitCount + SYS_TIME_Counter64Get();
                            }    
                        }    
                    }
                    break; 

                case WRITE_REQ:
                case WRITETAB_REQ:
                case SETTAB_REQ:
                case RESETTAB_REQ:
                case SETIC_REQ:
                case WRITETABIC_REQ:
                case READ_REQ:
                case READ_RESP :
                case READTAB_REQ_SEL:
                case READTAB_RESP_SEL:
                case READTAB_REQ:
                case READTAB_RESP:
                case GETTAB_REQ:
                case GETTAB_RESP:
                case DATASPONT:
                case REPROG_LOCAL:
                case REPROG_BROADCAST:
                case COMMAND:

                    drParams.lsdu = reqParams->Txdata;
                    drParams.lsduLen = reqParams->Txdata_Len;
                    drParams.dsap = DLL_DSAP_APPLICATION_FRAME;
                    drParams.ecc = DLL_ECC_DISABLED;

                    DLL_DataRequest(&drParams);
                    
                    confirmWaitTimeoutUs = DLL_GetTxTimeout();                                          /* ConfirmWait in uSec*/
                    confirmWaitCount = SYS_TIME_USToCount( confirmWaitTimeoutUs );
                    nextwaitCount = confirmWaitCount + SYS_TIME_Counter64Get();
                    
                    break;

                case WRITE_REQ_AUTH:     
                case WRITETAB_REQ_AUTH:  
                case SETTAB_REQ_AUTH:    
                case RESETTAB_REQ_AUTH:  
                case SETIC_REQ_AUTH:      
                case WRITETABIC_REQ_AUTH: 

                    memset(alData.Transmit_Buff, 0, MAX_LENGTH_432_DATA);
                    alData.Transmit_Buff[0] = reqParams->Txdata[0];

                    memset(alData.crc.buffer, 0, MAX_LENGTH_432_DATA);
                    memcpy(alData.crc.buffer, getValue.value, MAC_ADDRESS_SIZE);
                    alData.crc.dataLen = MAC_ADDRESS_SIZE;
                    memcpy(&alData.crc.buffer[alData.crc.dataLen], &reqParams->Txdata[1], reqParams->Txdata_Len-1);
                    alData.crc.dataLen += reqParams->Txdata_Len-1;
                    alData.crc.result = SRV_PCRC_GetValue(alData.crc.buffer, alData.crc.dataLen, PCRC_HT_GENERIC, PCRC_CRC32, 1);                                     /* CRC Calculation */  

                    memset(alData.cmac.inputBuf, 0, sizeof(alData.cmac.inputBuf));
                    alData.cmac.inputBuf[0] = reqParams->Txdata[0];                                                /* CM */
                    alData.cmac.input_dataLen = 1;
                    memcpy(&alData.cmac.inputBuf[alData.cmac.input_dataLen], getValue.value, 3);                         /* ACA 3bytes(LSB) */
                    alData.cmac.input_dataLen += 3;
                    memcpy(&alData.cmac.inputBuf[alData.cmac.input_dataLen], alData.lmon.buff, LMON_LENGTH);         /* LMON used for CMAC generation in Meter */
                    alData.cmac.input_dataLen += LMON_LENGTH;
                    memcpy(&alData.cmac.inputBuf[alData.cmac.input_dataLen], &alData.crc.result, 4);                             /* CRC(ACA,DATA) */
                    alData.cmac.input_dataLen += 4;
                    memcpy(alData.cmac.key, alData.keys.Write_Key, 16);                                                   /* KEY */

                    Cmac_status = Crypto_Mac_AesCmac_Direct(CRYPTO_HANDLER_SW_WOLFCRYPT, alData.cmac.inputBuf, alData.cmac.input_dataLen, alData.cmac.Computed_cmac, AES_CMAC_LENGTH, alData.cmac.key, KEY_LENGTH, 1);

                    if (Cmac_status == CRYPTO_MAC_CIPHER_SUCCESS)
                    {    
                        /* Encryption of Meter Data, POSIX timestamp, CMAC */
                        memset(dll_Tx_buffer, 0, MAX_LENGTH_432_DATA);
                        memcpy(dll_Tx_buffer, &reqParams->Txdata[1], reqParams->Txdata_Len-1);
                        process_bytes = reqParams->Txdata_Len-1;
                        memcpy(&dll_Tx_buffer[process_bytes], &reqParams->timestamp, 8);
                        process_bytes += 8;
                        memcpy(&dll_Tx_buffer[process_bytes], alData.cmac.Computed_cmac, 8);
                        process_bytes += 8;

                        counter_block_generation(alData.lmon.value);                                   /* IV generation */
                        if(EncryptData_dll(dll_Tx_buffer, process_bytes, &alData.Transmit_Buff[1], CRYPTO_SYM_OPMODE_CTR, alData.keys.Write_Key, alData.keys.Counter_block) == true)
                        {
                            drParams.dsap = DLL_DSAP_APPLICATION_FRAME;
                            drParams.ecc = DLL_ECC_DISABLED;
                            drParams.lsduLen = process_bytes+1;                                             /* CM */
                            drParams.lsdu = alData.Transmit_Buff;

                            DLL_DataRequest(&drParams);
                            
                            confirmWaitTimeoutUs = DLL_GetTxTimeout();                                          /* ConfirmWait in uSec*/
                            confirmWaitCount = SYS_TIME_USToCount( confirmWaitTimeoutUs );
                            nextwaitCount = confirmWaitCount + SYS_TIME_Counter64Get();
                        }    
                    }    

                    break; 


                case READ_REQ_AUTH:       
                case READ_RESP_AUTH:      
                case READTAB_REQ_SEL_AUTH:    
                case READTAB_RESP_SEL_AUTH:
                case READTAB_REQ_AUTH:    
                case READTAB_RESP_AUTH:
                case GETTAB_REQ_AUTH:     
                case GETTAB_RESP_AUTH:    
                case DATASPONT_AUTH:            
                case COMMAND_AUTH:            

                    memset(alData.Transmit_Buff, 0, MAX_LENGTH_432_DATA);
                    alData.Transmit_Buff[0] = reqParams->Txdata[0];

                    memset(alData.crc.buffer, 0, MAX_LENGTH_432_DATA);
                    memcpy(alData.crc.buffer, getValue.value, MAC_ADDRESS_SIZE);
                    alData.crc.dataLen = MAC_ADDRESS_SIZE;
                    memcpy(&alData.crc.buffer[alData.crc.dataLen], &reqParams->Txdata[1], reqParams->Txdata_Len-1);
                    alData.crc.dataLen += reqParams->Txdata_Len-1;
                    alData.crc.result = SRV_PCRC_GetValue(alData.crc.buffer, alData.crc.dataLen, PCRC_HT_GENERIC, PCRC_CRC32, 1);                                     /* CRC Calculation */  

                    memset(alData.cmac.inputBuf, 0, sizeof(alData.cmac.inputBuf));
                    alData.cmac.inputBuf[0] = reqParams->Txdata[0];                                                /* CM */
                    alData.cmac.input_dataLen = 1;
                    memcpy(&alData.cmac.inputBuf[alData.cmac.input_dataLen], getValue.value, 3);                         /* ACA 3bytes(LSB) */
                    alData.cmac.input_dataLen += 3;
                    memcpy(&alData.cmac.inputBuf[alData.cmac.input_dataLen], alData.lmon.buff, LMON_LENGTH);         /* LMON used for CMAC generation in Meter */
                    alData.cmac.input_dataLen += LMON_LENGTH;
                    memcpy(&alData.cmac.inputBuf[alData.cmac.input_dataLen], &alData.crc.result, 4);                             /* CRC(ACA,DATA) */
                    alData.cmac.input_dataLen += 4;
                    memcpy(alData.cmac.key, alData.keys.Read_Key, 16);                                                    /* KEY */

                    Cmac_status = Crypto_Mac_AesCmac_Direct(CRYPTO_HANDLER_SW_WOLFCRYPT, alData.cmac.inputBuf, alData.cmac.input_dataLen, alData.cmac.Computed_cmac, AES_CMAC_LENGTH, alData.cmac.key, KEY_LENGTH, 1);

                    if (Cmac_status == CRYPTO_MAC_CIPHER_SUCCESS)
                    {    
                        /* Encryption of Meter Data, POSIX timestamp, CMAC */
                        memset(dll_Tx_buffer, 0, MAX_LENGTH_432_DATA);
                        memcpy(dll_Tx_buffer, &reqParams->Txdata[1], reqParams->Txdata_Len-1);
                        process_bytes = reqParams->Txdata_Len-1;
                        memcpy(&dll_Tx_buffer[process_bytes], &reqParams->timestamp, 8);
                        process_bytes += 8;
                        memcpy(&dll_Tx_buffer[process_bytes], alData.cmac.Computed_cmac, 8);
                        process_bytes += 8;

                        counter_block_generation(alData.lmon.value);                                   /* IV generation */
                        if(EncryptData_dll(dll_Tx_buffer, process_bytes, &alData.Transmit_Buff[1], CRYPTO_SYM_OPMODE_CTR, alData.keys.Read_Key, alData.keys.Counter_block) == true)
                        {
                            drParams.dsap = DLL_DSAP_APPLICATION_FRAME;
                            drParams.ecc = DLL_ECC_DISABLED;
                            drParams.lsduLen = process_bytes+1;                                             /* CM */
                            drParams.lsdu = alData.Transmit_Buff;

                            DLL_DataRequest(&drParams);
                            
                            confirmWaitTimeoutUs = DLL_GetTxTimeout();                                          /* ConfirmWait in uSec*/
                            confirmWaitCount = SYS_TIME_USToCount( confirmWaitTimeoutUs );
                            nextwaitCount = confirmWaitCount + SYS_TIME_Counter64Get();
                        }    
                    }    
                    break;

                case A_Node_ACK:
                case A_Node_NACK:

                    drParams.lsdu = reqParams->Txdata;
                    drParams.lsduLen = reqParams->Txdata_Len;
                    drParams.dsap = DLL_DSAP_APPLICATION_FRAME;
                    drParams.ecc = DLL_ECC_DISABLED;

                    DLL_DataRequest(&drParams);

                    confirmWaitTimeoutUs = DLL_GetTxTimeout();                                          /* ConfirmWait in uSec*/
                    confirmWaitCount = SYS_TIME_USToCount( confirmWaitTimeoutUs );
                    nextwaitCount = confirmWaitCount + SYS_TIME_Counter64Get();
                    
                    break;

                case A_Node_ACK_AUTH:
                
                    memset(alData.Transmit_Buff, 0, MAX_LENGTH_432_DATA);
                    alData.Transmit_Buff[0] = reqParams->Txdata[0];

                    memset(alData.crc.buffer, 0, MAX_LENGTH_432_DATA);
                    memcpy(alData.crc.buffer, getValue.value, MAC_ADDRESS_SIZE);
                    alData.crc.dataLen = MAC_ADDRESS_SIZE;
                    memcpy(&alData.crc.buffer[alData.crc.dataLen], &reqParams->Txdata[1], reqParams->Txdata_Len-1);
                    alData.crc.dataLen += reqParams->Txdata_Len-1;
                    alData.crc.result = SRV_PCRC_GetValue(alData.crc.buffer, alData.crc.dataLen, PCRC_HT_GENERIC, PCRC_CRC32, 1);                                     /* CRC Calculation */  

                    memset(alData.cmac.inputBuf, 0, sizeof(alData.cmac.inputBuf));
                    alData.cmac.inputBuf[0] = reqParams->Txdata[0];                                                /* CM */
                    alData.cmac.input_dataLen = 1;
                    memcpy(&alData.cmac.inputBuf[alData.cmac.input_dataLen], getValue.value, 3);                         /* ACA 3bytes(LSB) */
                    alData.cmac.input_dataLen += 3;
                    memcpy(&alData.cmac.inputBuf[alData.cmac.input_dataLen], alData.cmon.buff, LMON_LENGTH);         /* CMON used for CMAC generation in Meter for ACK */
                    alData.cmac.input_dataLen += LMON_LENGTH;
                    memcpy(&alData.cmac.inputBuf[alData.cmac.input_dataLen], &alData.crc.result, 4);                             /* CRC(ACA,DATA) */
                    alData.cmac.input_dataLen += 4;
                    memcpy(alData.cmac.key, alData.keys.Write_Key, 16);                                                    /* KEY */

                    Cmac_status = Crypto_Mac_AesCmac_Direct(CRYPTO_HANDLER_SW_WOLFCRYPT, alData.cmac.inputBuf, alData.cmac.input_dataLen, alData.cmac.Computed_cmac, AES_CMAC_LENGTH, alData.cmac.key, KEY_LENGTH, 1);

                    if (Cmac_status == CRYPTO_MAC_CIPHER_SUCCESS)
                    {    
                        /* Encryption of Meter Data, POSIX timestamp, CMAC */
                        memset(dll_Tx_buffer, 0, MAX_LENGTH_432_DATA);
                        memcpy(dll_Tx_buffer, &reqParams->Txdata[1], reqParams->Txdata_Len-1);
                        process_bytes = reqParams->Txdata_Len-1;
                        memcpy(&dll_Tx_buffer[process_bytes], &reqParams->timestamp, 8);
                        process_bytes += 8;
                        memcpy(&dll_Tx_buffer[process_bytes], alData.cmac.Computed_cmac, 8);
                        process_bytes += 8;

                        counter_block_generation(alData.cmon.value);                                   /* IV generation */
                        if (EncryptData_dll(dll_Tx_buffer, process_bytes, &alData.Transmit_Buff[1], CRYPTO_SYM_OPMODE_CTR, alData.keys.Write_Key, alData.keys.Counter_block) == true)
                        {
                            drParams.dsap = DLL_DSAP_APPLICATION_FRAME;
                            drParams.ecc = DLL_ECC_DISABLED;
                            drParams.lsduLen = process_bytes+1;                                             /* CM */
                            drParams.lsdu = alData.Transmit_Buff;

                            DLL_DataRequest(&drParams);

                            confirmWaitTimeoutUs = DLL_GetTxTimeout();                                          /* ConfirmWait in uSec*/
                            confirmWaitCount = SYS_TIME_USToCount( confirmWaitTimeoutUs );
                            nextwaitCount = confirmWaitCount + SYS_TIME_Counter64Get();
                        }    
                    }    
                    break;
                    
                case A_Node_NACK_AUTH:
                    
                    /* TO_DO Implementation not clear as SSAP bits NA in AL, could be same as A_Node_ACK_AUTH */
                    break;
            }
        }
    }
}

void AL_data_indication_process( DLL_DATA_IND_PARAMS *indParams )
{
    AL_DATA_IND_PARAMS indication;
    AL_DATA_REQ_PARAMS request;
    DLL_IB_VALUE getValue;
    DLL_RESULT result;
    LMON lmon_recover;
    uint8_t Index;
    uint8_t decrypt_length;
    uint8_t process_bytes;
    MAC_ADDRESS aca;
    
    memset(&indication, 0, sizeof(AL_DATA_IND_PARAMS));
    memset(&request, 0, sizeof(AL_DATA_REQ_PARAMS));
    
    if( alData.isMaster )
    {
        alData.AL_Status.flags.DL_Indication_req = 1;
        
        switch (indParams->lsdu[0])
        {
            case ADDRESS_REQ:
                
                break;

            case ADDRESS_RESP:
                
                /* NW messages Data is sent to concentrator with out processing in AL */
                indication.command_message = indParams->lsdu[0];
                indication.app_dataLen = indParams->lsduLen-1;
                indication.message_type = AL_ENCRYPTION_DISABLED;
                memcpy(indication.app_data, &indParams->lsdu[1], indication.app_dataLen);
                alData.dataIndCallback( &indication );
                
                break;
                
            case TCT_SET_REQ:    
                
                break;
                
            case REQ_ADDRESS_REQ:    
                
                break;
                
            case REQ_ADDRESS_RESP:    
                
                /* Data is sent to concentrator with out processing in AL */
                indication.command_message = indParams->lsdu[0];
                indication.app_dataLen = indParams->lsduLen-1;
                indication.message_type = AL_ENCRYPTION_DISABLED;
                memcpy(indication.app_data, &indParams->lsdu[1], indication.app_dataLen);
                alData.dataIndCallback( &indication );
                
                break;
                
            case CHALLENGE_REQ:
                
                break;  
            
            case CHALLENGE_RESP:
                
                indication.command_message = indParams->lsdu[0];
                indication.message_type = AL_ENCRYPTION_ENABLED;
                decrypt_length = indParams->lsduLen-1;
                memset(process_buff, 0, MAX_LENGTH_432_DATA);
                
                /* ECB mode doesn't require Counter Block */
                indication.decryption_status = DecryptData_Comm(&indParams->lsdu[1], decrypt_length, process_buff, CRYPTO_SYM_OPMODE_CTR, alData.keys.Write_Key, NULL);
                
                /* writing data after decryption to meter_AL */
                memcpy(lmon_recover.buff, process_buff, LMON_LENGTH);                               /* LMON received */
                memcpy(alData.cmac.Received_cmac, &process_buff[LMON_LENGTH], 8);                          /* CMAC */
                indication.app_dataLen = 0U;                                                        /* data length is 0 as LMON is only data. its value is updated in indication.node_info */
                
                if(CRYPTO_SYM_CIPHER_SUCCESS == indication.decryption_status)
                {
                    /* Calculating 32-bit CRC for CMAC generation */
                    memset(alData.crc.buffer, 0, sizeof(alData.crc.buffer));
                    memcpy(alData.crc.buffer, alData.comm_node_configdata.ACA, MAC_ADDRESS_SIZE);
                    alData.crc.dataLen = MAC_ADDRESS_SIZE;
                    memcpy(&alData.crc.buffer[6], alData.random_number, 16);                                      /* Random number used in challenge Request */
                    alData.crc.dataLen += 16;
                    alData.crc.result = SRV_PCRC_GetValue(alData.crc.buffer, alData.crc.dataLen, PCRC_HT_GENERIC, PCRC_CRC32, 1);                             /* CRC Calculation */  

                    memset(alData.cmac.inputBuf, 0, sizeof(alData.cmac.inputBuf));
                    alData.cmac.inputBuf[0] = indParams->lsdu[0];                                          /* CM */
                    alData.cmac.input_dataLen = 1;
                    memcpy(&alData.cmac.inputBuf[1], alData.comm_node_configdata.ACA, 3);                         /* Node ACA 3bytes(LSB) */ 
                    alData.cmac.input_dataLen += 3;
                    memcpy(&alData.cmac.inputBuf[4], lmon_recover.buff, LMON_LENGTH); 
                    alData.cmac.input_dataLen += LMON_LENGTH;
                    memcpy(&alData.cmac.inputBuf[12], &alData.crc.result, 4);                                     /* CRC(ACA,DATA) */
                    alData.cmac.input_dataLen += 4;
                    memcpy(alData.cmac.key, alData.keys.Write_Key, 16);                                           /* Write KEY */

                    Cmac_status = Crypto_Mac_AesCmac_Direct(CRYPTO_HANDLER_SW_WOLFCRYPT, alData.cmac.inputBuf, alData.cmac.input_dataLen, alData.cmac.Computed_cmac, AES_CMAC_LENGTH, alData.cmac.key, KEY_LENGTH, 1);

                    if (Cmac_status == CRYPTO_MAC_CIPHER_SUCCESS)
                    {
                        if (memcmp(alData.cmac.Computed_cmac, alData.cmac.Received_cmac, AES_CMAC_LENGTH) == 0)
                        {
                            indication.authentication_status = 1;                                   /* CMAC verification successful */  
                            indication.node_info.lmon.value = lmon_recover.value;                   /* updating LMON to CMON */ 
                        }
                        else
                        {
                            indication.authentication_status = 0;                                   /* CMAC verification fail */
                            indication.node_info.lmon.value = 0;
                        }    
                    }  
                    else
                    {
                        indication.authentication_status = Cmac_status;                             /* CMAC generation failure with error status updated */
                    }
                }
                
                alData.dataIndCallback( &indication );
                break;
                 
            case WRITE_REQ:
            case WRITETAB_REQ:
            case SETTAB_REQ:
            case RESETTAB_REQ:
            case SETIC_REQ:
            case WRITETABIC_REQ:
            case READ_REQ:
            case READ_RESP :
            case READTAB_REQ_SEL:
            case READTAB_RESP_SEL:
            case READTAB_REQ:
            case READTAB_RESP:
            case GETTAB_REQ:
            case GETTAB_RESP:
            case DATASPONT:
            case REPROG_LOCAL:
            case REPROG_BROADCAST:
            case COMMAND:
                
                indication.command_message = indParams->lsdu[0];
                indication.app_dataLen = indParams->lsduLen-1;
                indication.message_type = AL_ENCRYPTION_DISABLED;
                memcpy(indication.app_data, &indParams->lsdu[1], indication.app_dataLen);
                alData.dataIndCallback( &indication );
                
                break;
                
            case WRITE_REQ_AUTH:     
            case WRITETAB_REQ_AUTH:  
            case SETTAB_REQ_AUTH:    
            case RESETTAB_REQ_AUTH:  
            case SETIC_REQ_AUTH:      
            case WRITETABIC_REQ_AUTH: 
                
                indication.command_message = indParams->lsdu[0];
                indication.message_type = AL_ENCRYPTION_ENABLED;
                decrypt_length = indParams->lsduLen-1;
                memset(process_buff, 0, MAX_LENGTH_432_DATA);
                
                counter_block_generation(alData.cmon.value);                                       /* CMON for Decryption and Authentication */
                indication.decryption_status = DecryptData_Comm(&indParams->lsdu[1], decrypt_length, process_buff, CRYPTO_SYM_OPMODE_CTR, alData.keys.Write_Key, alData.keys.Counter_block);
                
                /* writing data after decryption to meter_AL */
                memcpy(indication.app_data, process_buff, decrypt_length-16);                           /* Data, excluding Timestamp & CMAC */
                indication.app_dataLen = indParams->lsduLen-ENCRYPTED_MESSAGE_HEADER_LENGTH;            /* received data length */
                memcpy(received_time.data, &process_buff[decrypt_length-16], 8);                        /* POSIX timestamp */
                memcpy(alData.cmac.Received_cmac, &process_buff[decrypt_length-8], 8);                         /* CMAC */
                
                if(received_time.value > request_time.value )                            
                {    
                    if(CRYPTO_SYM_CIPHER_SUCCESS == indication.decryption_status)
                    {
                        /* Calculating 32-bit CRC(ACA, Data) for CMAC generation */
                        memset(alData.crc.buffer, 0, sizeof(alData.crc.buffer));
                        memcpy(alData.crc.buffer, alData.comm_node_configdata.ACA, MAC_ADDRESS_SIZE);                       /* ACA of Node */
                        alData.crc.dataLen = MAC_ADDRESS_SIZE;
                        memcpy(&alData.crc.buffer[6], indication.app_data, (decrypt_length-16));           
                        alData.crc.dataLen += decrypt_length-16;
                        alData.crc.result = SRV_PCRC_GetValue(alData.crc.buffer, alData.crc.dataLen, PCRC_HT_GENERIC, PCRC_CRC32, 1);                             /* CRC Calculation */  

                        memset(alData.cmac.inputBuf, 0, sizeof(alData.cmac.inputBuf));
                        alData.cmac.inputBuf[0] = indParams->lsdu[0];                                          /* CM */
                        alData.cmac.input_dataLen = 1;
                        memcpy(&alData.cmac.inputBuf[1], alData.comm_node_configdata.ACA, 3);                         /* ACA 3bytes(LSB) */ 
                        alData.cmac.input_dataLen += 3;
                        memcpy(&alData.cmac.inputBuf[4], alData.cmon.buff, 8);                            /* updated CMON value */
                        alData.cmac.input_dataLen += 8;
                        memcpy(&alData.cmac.inputBuf[12], &alData.crc.result, 4);                                     /* CRC(ACA,DATA) */
                        alData.cmac.input_dataLen += 4;
                        memcpy(alData.cmac.key, alData.keys.Write_Key, 16);                                           /* Write KEY */

                        Cmac_status = Crypto_Mac_AesCmac_Direct(CRYPTO_HANDLER_SW_WOLFCRYPT, alData.cmac.inputBuf, alData.cmac.input_dataLen, alData.cmac.Computed_cmac, AES_CMAC_LENGTH, alData.cmac.key, KEY_LENGTH, 1);

                        if (Cmac_status == CRYPTO_MAC_CIPHER_SUCCESS)
                        {
                            if (memcmp(alData.cmac.Computed_cmac, alData.cmac.Received_cmac, AES_CMAC_LENGTH) == 0)
                            {
                                indication.authentication_status = 1;                                   /* CMAC verification successful */  
                                indication.node_info.lmon.value = alData.cmon.value;               /* Updating Node LMON to CMON and indicate to CCU */
                                memcpy(indication.node_info.ACA, alData.comm_node_configdata.ACA, MAC_ADDRESS_SIZE);
                            }
                            else
                            {
                                indication.authentication_status = 0;                                   /* CMAC verification fail */
                                indication.node_info.lmon.value = 0;
                            }    
                        }  
                        else
                        {
                            indication.authentication_status = Cmac_status;                             /* CMAC generation failure with error status updated */
                        }
                    }
                }
                
                alData.dataIndCallback( &indication );
                break;
                
                
            case READ_REQ_AUTH:       
            case READ_RESP_AUTH:      
            case READTAB_REQ_SEL_AUTH:    
            case READTAB_RESP_SEL_AUTH:
            case READTAB_REQ_AUTH:    
            case READTAB_RESP_AUTH:    
            case GETTAB_REQ_AUTH:     
            case GETTAB_RESP_AUTH:    
            case DATASPONT_AUTH:          
            case COMMAND_AUTH:            
                
                indication.command_message = indParams->lsdu[0];
                indication.message_type = AL_ENCRYPTION_ENABLED;
                decrypt_length = indParams->lsduLen-1;
                memset(process_buff, 0, MAX_LENGTH_432_DATA);
                
                counter_block_generation(alData.cmon.value);                                           /* CMON for Decryption and Authentication */
                indication.decryption_status = DecryptData_Comm(&indParams->lsdu[1], decrypt_length, process_buff, CRYPTO_SYM_OPMODE_CTR, alData.keys.Read_Key, alData.keys.Counter_block);
                
                /* writing data after decryption to meter_AL */
                memcpy(indication.app_data, process_buff, decrypt_length-16);                               /* Data */
                indication.app_dataLen = indParams->lsduLen-ENCRYPTED_MESSAGE_HEADER_LENGTH;                /* received data length */
                memcpy(received_time.data, &process_buff[decrypt_length-16], 8);                            /* POSIX timestamp */
                memcpy(alData.cmac.Received_cmac, &process_buff[decrypt_length-8], 8);                             /* CMAC */
                
                if(received_time.value > request_time.value )                            
                {    
                    if(CRYPTO_SYM_CIPHER_SUCCESS == indication.decryption_status)
                    {
                        /* Calculating 32-bit CRC for CMAC generation */
                        memset(alData.crc.buffer, 0, sizeof(alData.crc.buffer));
                        memcpy(alData.crc.buffer, alData.comm_node_configdata.ACA, MAC_ADDRESS_SIZE);                           /* ACA of Node */
                        alData.crc.dataLen = MAC_ADDRESS_SIZE;
                        memcpy(&alData.crc.buffer[6], indication.app_data, (decrypt_length-16));           
                        alData.crc.dataLen += decrypt_length-16;
                        alData.crc.result = SRV_PCRC_GetValue(alData.crc.buffer, alData.crc.dataLen, PCRC_HT_GENERIC, PCRC_CRC32, 1);                                 /* CRC Calculation */  
                    
                        memset(alData.cmac.inputBuf, 0, sizeof(alData.cmac.inputBuf));
                        alData.cmac.inputBuf[0] = indParams->lsdu[0];                                              /* CM */
                        alData.cmac.input_dataLen = 1;
                        memcpy(&alData.cmac.inputBuf[1], alData.comm_node_configdata.ACA, 3);                             /* ACA 3bytes(LSB) */ 
                        alData.cmac.input_dataLen += 3;
                        memcpy(&alData.cmac.inputBuf[4], alData.cmon.buff, 8);                                /* updated CMON value */
                        alData.cmac.input_dataLen += 8;
                        memcpy(&alData.cmac.inputBuf[12], &alData.crc.result, 4);                                         /* CRC(ACA,DATA) */
                        alData.cmac.input_dataLen += 4;
                        memcpy(alData.cmac.key, alData.keys.Read_Key, 16);                                                /* KEY */
                        
                        Cmac_status = Crypto_Mac_AesCmac_Direct(CRYPTO_HANDLER_SW_WOLFCRYPT, alData.cmac.inputBuf, alData.cmac.input_dataLen, alData.cmac.Computed_cmac, AES_CMAC_LENGTH, alData.cmac.key, KEY_LENGTH, 1);

                        if (Cmac_status == CRYPTO_MAC_CIPHER_SUCCESS)
                        {
                            if (memcmp(alData.cmac.Computed_cmac, alData.cmac.Received_cmac, AES_CMAC_LENGTH) == 0)
                            {
                                indication.authentication_status = 1;                                   /* CMAC verification successful */  
                                indication.node_info.lmon.value = alData.cmon.value;               /* Updating Node LMON to CMON and indicate to CCU */
                                memcpy(indication.node_info.ACA, alData.comm_node_configdata.ACA, MAC_ADDRESS_SIZE);
                            }
                            else
                            {
                                indication.authentication_status = 0;                                   /* CMAC verification fail */
                                indication.node_info.lmon.value = 0;
                            }    
                        }  
                        else
                        {
                            indication.authentication_status = Cmac_status;                       /* CMAC generation failure with error status updated */
                        }
                    }
                }
                alData.dataIndCallback( &indication );
                break;
                
            case A_Node_ACK:
            case A_Node_NACK:    
                
                indication.command_message = indParams->lsdu[0];
                indication.app_dataLen = indParams->lsduLen-1;
                indication.message_type = AL_ENCRYPTION_DISABLED;
                memcpy(indication.app_data, &indParams->lsdu[1], indication.app_dataLen);
                alData.dataIndCallback( &indication );
                
                break;
                
            case A_Node_ACK_AUTH:
                
                indication.command_message = indParams->lsdu[0];
                indication.message_type = AL_ENCRYPTION_ENABLED;
                decrypt_length = indParams->lsduLen-1;
                memset(process_buff, 0, MAX_LENGTH_432_DATA);
                
                counter_block_generation(alData.cmon.value);                                           /* CMON for Decryption and Authentication */
                indication.decryption_status = DecryptData_Comm(&indParams->lsdu[1], decrypt_length, process_buff, CRYPTO_SYM_OPMODE_CTR, alData.keys.Write_Key, alData.keys.Counter_block);
                
                /* writing data after decryption to meter_AL */
                memcpy(indication.app_data, process_buff, decrypt_length-16);                               /* Data */
                indication.app_dataLen = indParams->lsduLen-ENCRYPTED_MESSAGE_HEADER_LENGTH;                /* received data length */
                memcpy(received_time.data, &process_buff[decrypt_length-16], 8);                            /* POSIX timestamp */
                memcpy(alData.cmac.Received_cmac, &process_buff[decrypt_length-8], 8);                             /* CMAC */
                
                if(received_time.value > request_time.value )                            
                {    
                    if(CRYPTO_SYM_CIPHER_SUCCESS == indication.decryption_status)
                    {
                        /* Calculating 32-bit CRC for CMAC generation */
                        memset(alData.crc.buffer, 0, sizeof(alData.crc.buffer));
                        memcpy(alData.crc.buffer, alData.comm_node_configdata.ACA, MAC_ADDRESS_SIZE);                           /* ACA of Node */
                        alData.crc.dataLen = MAC_ADDRESS_SIZE;
                        memcpy(&alData.crc.buffer[6], indication.app_data, (decrypt_length-16));           
                        alData.crc.dataLen += decrypt_length-16;
                        alData.crc.result = SRV_PCRC_GetValue(alData.crc.buffer, alData.crc.dataLen, PCRC_HT_GENERIC, PCRC_CRC32, 1);                                 /* CRC Calculation */  
                    
                        memset(alData.cmac.inputBuf, 0, sizeof(alData.cmac.inputBuf));
                        alData.cmac.inputBuf[0] = indParams->lsdu[0];                                              /* CM */
                        alData.cmac.input_dataLen = 1;
                        memcpy(&alData.cmac.inputBuf[1], alData.comm_node_configdata.ACA, 3);                             /* ACA 3bytes(LSB) */ 
                        alData.cmac.input_dataLen += 3;
                        memcpy(&alData.cmac.inputBuf[4], alData.cmon.buff, 8);                                /* updated CMON value */
                        alData.cmac.input_dataLen += 8;
                        memcpy(&alData.cmac.inputBuf[12], &alData.crc.result, 4);                                         /* CRC(ACA,DATA) */
                        alData.cmac.input_dataLen += 4;
                        memcpy(alData.cmac.key, alData.keys.Write_Key, 16);                                                /* KEY */
                        
                        Cmac_status = Crypto_Mac_AesCmac_Direct(CRYPTO_HANDLER_SW_WOLFCRYPT, alData.cmac.inputBuf, alData.cmac.input_dataLen, alData.cmac.Computed_cmac, AES_CMAC_LENGTH, alData.cmac.key, KEY_LENGTH, 1);

                        if (Cmac_status == CRYPTO_MAC_CIPHER_SUCCESS)
                        {
                            if (memcmp(alData.cmac.Computed_cmac, alData.cmac.Received_cmac, AES_CMAC_LENGTH) == 0)
                            {
                                indication.authentication_status = 1;                                   /* CMAC verification successful */  
                                indication.node_info.lmon.value = alData.cmon.value;               /* Updating Node LMON to CMON and indicate to CCU */
                                memcpy(indication.node_info.ACA, alData.comm_node_configdata.ACA, MAC_ADDRESS_SIZE);
                            }
                            else
                            {
                                indication.authentication_status = 0;                                   /* CMAC verification fail */
                                indication.node_info.lmon.value = 0;
                            }    
                        }  
                        else
                        {
                            indication.authentication_status = Cmac_status;                       /* CMAC generation failure with error status updated */
                        }
                    }
                }
                alData.dataIndCallback( &indication );
                
                break;
                
            case A_Node_NACK_AUTH:
                
                /* TO_DO */
                break;
        }
    }
    else
    {
        result = DLL_GetRequest(MAC_ACA_ADDRESS_IB, 0, &getValue);
        memcpy(aca.address, getValue.value, MAC_ADDRESS_SIZE);

        switch (indParams->lsdu[0])
        {
            case ADDRESS_REQ:
                
                ACA_Request.Phase = indParams->lsdu[1];
                ACA_Request.TCR = indParams->lsdu[2];
                ACA_Request.AddToAddress = indParams->lsdu[3];
                ACA_Request.RightShiftAdd = indParams->lsdu[4];
                
                result = DLL_GetRequest(MAC_LAST_RX_IN_PHASE_IB, 0, &getValue);                               /* TO_DO Phase value? */
                
                if((alData.TCT >= ACA_Request.TCR) || (ACA_Request.Phase == getValue.value[0]) || (address_filtering() == true))                /* TO_DO in phase value or AddToAddress value is true */
                {
                    memset(process_buff, 0, MAX_LENGTH_432_DATA);
                    
                    process_buff[0] = ADDRESS_RESP;
                    
                    memcpy(&process_buff[1], aca.address, MAC_ADDRESS_SIZE);
                    
                    result = DLL_GetRequest(MAC_LAST_RX_SIGNAL_LEVEL_IB, 0, &getValue);                       /* Av_SIGNAL */
                    if(result == DLL_SUCCESS)
                        process_buff[7] = getValue.value[0];
                    else
                        process_buff[7] = 0xFF;

                    result = DLL_GetRequest(MAC_LAST_RX_SNR_IB, 0, &getValue);                                /* Av_SNR */
                    if(result == DLL_SUCCESS)
                        process_buff[8] = getValue.value[0];
                    else
                        process_buff[8] = 0xFF;

                    result = DLL_GetRequest(MAC_ESTIMATED_IMPDEDANCE_IB, 0, &getValue);                       /* Av_Tx */
                    if(result == DLL_SUCCESS)
                        process_buff[9] = getValue.value[0];
                    else
                        process_buff[9] = 0xFF;
                
                    process_buff[10] = 0xFF;
                    process_buff[11] = 0xFF;
                    process_buff[12] = 0xFF;
                    
                    request.Txdata = process_buff;
                    request.Txdata_Len = 13;
                    
                    AL_DataRequest( &request );
                }
                break;

            case ADDRESS_RESP:
                
                if((alData.AL_NWStatus.flags.ACA_Req_Address_Req_rcvd == 1) && (alData.AL_NWStatus.flags.ACA_Address_Req_Sent == 1))
                {
                    if(ACA_req_resp_count<4)
                    {
                        memcpy(&ACA_req_resp[ACA_req_resp_count], &indParams->lsdu[1], 12);
                        ACA_req_resp_count++;
                    }
                    
                    if(ACA_req_resp_count == 4)
                    {
                        memset(process_buff, 0, MAX_LENGTH_432_DATA);
                        process_buff[0] = REQ_ADDRESS_RESP;
                        process_buff[1] = ACA_req_resp_count;
                        process_bytes = 2;
                        
                        for(Index=0; Index < ACA_req_resp_count; Index++)
                        {
                            memcpy(&process_buff[process_bytes], &ACA_req_resp[Index], 12);
                            process_bytes += 12;
                        }    
                        request.Txdata = process_buff;
                        request.Txdata_Len = process_bytes;

                        AL_DataRequest( &request );
                        
                        alData.AL_NWStatus.flags.ACA_Req_Address_Resp_sent = 1;
                    }    
                }
                break;
                
            case TCT_SET_REQ:    
                
                memset(process_buff, 0, MAX_LENGTH_432_DATA);
                
                if(indParams->lsduLen == 2)
                {
                    /* Incoming TCT (min 1 to max 255) */
                    if((indParams->lsdu[1] > 0) && (indParams->lsdu[1] < 256))
                    {    
                        alData.TCT = indParams->lsdu[1];
                        process_buff[0] = NACK_RESP;
                        process_buff[1] = 0;                                                    /* ACK */
                    }
                    else
                    {
                        process_buff[0] = NACK_RESP;
                        process_buff[1] = 1;                                                    /* Error Status */
                    }
                }
                else
                {
                    process_buff[0] = NACK_RESP;
                    process_buff[1] = 1;                                                        /* Error Status */
                }
                
                result = DLL_GetRequest(MAC_LAST_RX_SIGNAL_LEVEL_IB, 0, &getValue);             /* Av_SIGNAL */
                if(result == DLL_SUCCESS)
                    process_buff[2] = getValue.value[0];
                else
                    process_buff[2] = 0xFF;

                result = DLL_GetRequest(MAC_LAST_RX_SNR_IB, 0, &getValue);                      /* Av_SNR */
                if(result == DLL_SUCCESS)
                    process_buff[3] = getValue.value[0];
                else
                    process_buff[3] = 0xFF;

                result = DLL_GetRequest(MAC_ESTIMATED_IMPDEDANCE_IB, 0, &getValue);             /* Av_Tx */
                if(result == DLL_SUCCESS)
                    process_buff[4] = getValue.value[0];
                else
                    process_buff[4] = 0xFF;

                request.Txdata = process_buff;
                request.Txdata_Len = 5;

                AL_DataRequest( &request );
                
                break;
                
            case REQ_ADDRESS_REQ:    
                
                memset(process_buff, 0, MAX_LENGTH_432_DATA);
                process_buff[0] = ADDRESS_REQ;
                memcpy(&process_buff[1], &indParams->lsdu[1], 4);
                
                request.Txdata = process_buff;
                request.Txdata_Len = 5;
                    
                AL_DataRequest( &request );
                
                alData.AL_NWStatus.flags.ACA_Req_Address_Req_rcvd = 1;
                
                break;
                
            case CHALLENGE_REQ:
                
                alData.lmon_recovery.challenge_req_received = 1;
                memcpy(alData.lmon_recovery.random_num, &indParams->lsdu[3], KEY_LENGTH);
                memset(process_buff, 0, MAX_LENGTH_432_DATA);
                process_buff[0] = CHALLENGE_RESP;
                request.Txdata = process_buff;
                request.Txdata_Len = 1;
                
                AL_DataRequest( &request );
                break;  
                
            case WRITE_REQ:
            case WRITETAB_REQ:
            case SETTAB_REQ:
            case RESETTAB_REQ:
            case SETIC_REQ:
            case WRITETABIC_REQ:
            case READ_REQ:
            case READ_RESP :
            case READTAB_REQ_SEL:
            case READTAB_RESP_SEL:
            case READTAB_REQ:
            case READTAB_RESP:
            case GETTAB_REQ:
            case GETTAB_RESP:
            case DATASPONT:
            case REPROG_LOCAL:
            case REPROG_BROADCAST:
            case COMMAND:
                
                indication.command_message = indParams->lsdu[0];
                indication.app_dataLen = indParams->lsduLen-1;
                indication.message_type = AL_ENCRYPTION_DISABLED;
                memcpy(indication.app_data, &indParams->lsdu[1], indication.app_dataLen);
                alData.dataIndCallback( &indication );
                
                break;
                
            case WRITE_REQ_AUTH:     
            case WRITETAB_REQ_AUTH:  
            case SETTAB_REQ_AUTH:    
            case RESETTAB_REQ_AUTH:  
            case SETIC_REQ_AUTH:      
            case WRITETABIC_REQ_AUTH: 
                
                indication.command_message = indParams->lsdu[0];
                indication.message_type = AL_ENCRYPTION_ENABLED;
                decrypt_length = indParams->lsduLen-1;
                memset(process_buff, 0, MAX_LENGTH_432_DATA);
                
                alData.cmon.value = alData.lmon.value +1;                                     /* CMON for Decryption and Authentication */
                counter_block_generation(alData.cmon.value);
                indication.decryption_status = DecryptData_Comm(&indParams->lsdu[1], decrypt_length, process_buff, CRYPTO_SYM_OPMODE_CTR, alData.keys.Write_Key, alData.keys.Counter_block);
                
                /* writing data after decryption to meter_AL */
                memcpy(indication.app_data, process_buff, decrypt_length-16);                           /* Data */
                indication.app_dataLen = indParams->lsduLen-ENCRYPTED_MESSAGE_HEADER_LENGTH;            /* received data length */
                memcpy(received_time.data, &process_buff[decrypt_length-16], 8);                        /* POSIX timestamp */
                memcpy(alData.cmac.Received_cmac, &process_buff[decrypt_length-8], 8);                         /* CMAC */
                
                if(received_time.value > request_time.value )                            
                {    
                    if(CRYPTO_SYM_CIPHER_SUCCESS == indication.decryption_status)
                    {
                        /* Calculating 32-bit CRC for CMAC generation */
                        memset(alData.crc.buffer, 0, sizeof(alData.crc.buffer));
                        memcpy(alData.crc.buffer, aca.address, MAC_ADDRESS_SIZE);
                        alData.crc.dataLen += MAC_ADDRESS_SIZE;
                        memcpy(&alData.crc.buffer[6], indication.app_data, (decrypt_length-16));           
                        alData.crc.dataLen += decrypt_length-16;
                        alData.crc.result = SRV_PCRC_GetValue(alData.crc.buffer, alData.crc.dataLen, PCRC_HT_GENERIC, PCRC_CRC32, 1);                             /* CRC Calculation */  

                        memset(alData.cmac.inputBuf, 0, sizeof(alData.cmac.inputBuf));
                        alData.cmac.inputBuf[0] = indParams->lsdu[0];                                          /* CM */
                        alData.cmac.input_dataLen = 1;
                        memcpy(&alData.cmac.inputBuf[1], aca.address, 3);                                  /* ACA 3bytes(LSB) */
                        alData.cmac.input_dataLen += 3;
                        memcpy(&alData.cmac.inputBuf[4], alData.cmon.buff, 8);
                        alData.cmac.input_dataLen += 8;
                        memcpy(&alData.cmac.inputBuf[12], &alData.crc.result, 4);                                     /* CRC(ACA,DATA) */
                        alData.cmac.input_dataLen += 4;
                        memcpy(alData.cmac.key, alData.keys.Write_Key, 16);                                           /* Write KEY */

                        Cmac_status = Crypto_Mac_AesCmac_Direct(CRYPTO_HANDLER_SW_WOLFCRYPT, alData.cmac.inputBuf, alData.cmac.input_dataLen, alData.cmac.Computed_cmac, AES_CMAC_LENGTH, alData.cmac.key, KEY_LENGTH, 1);

                        if (Cmac_status == CRYPTO_MAC_CIPHER_SUCCESS)
                        {
                            if (memcmp(alData.cmac.Computed_cmac, alData.cmac.Received_cmac, AES_CMAC_LENGTH) == 0)
                            {
                                indication.authentication_status = 1;                                   /* CMAC verification successful */  
                                alData.lmon.value = alData.lmon.value +1;                     /* TO_DO updating LMON to CMON */
                            }
                            else
                            {
                                indication.authentication_status = 0;                                   /* CMAC verification fail */
                            }    
                        }  
                        else
                        {
                            indication.authentication_status = Cmac_status;                             /* CMAC generation failure with error status updated */
                        }
                    }
                }
                
                alData.dataIndCallback( &indication );
                break;
                
                
            case READ_REQ_AUTH:       
            case READ_RESP_AUTH:      
            case READTAB_REQ_SEL_AUTH:    
            case READTAB_RESP_SEL_AUTH:
            case READTAB_REQ_AUTH:    
            case READTAB_RESP_AUTH:    
            case GETTAB_REQ_AUTH:     
            case GETTAB_RESP_AUTH:    
            case DATASPONT_AUTH:          
            case COMMAND_AUTH:            
                
                indication.command_message = indParams->lsdu[0];
                indication.message_type = AL_ENCRYPTION_ENABLED;
                decrypt_length = indParams->lsduLen-1;
                memset(process_buff, 0, MAX_LENGTH_432_DATA);
                
                alData.cmon.value = alData.lmon.value+1;                                     /* CMON for Decryption and Authentication */
                counter_block_generation(alData.cmon.value);
                indication.decryption_status = DecryptData_Comm(&indParams->lsdu[1], decrypt_length, process_buff, CRYPTO_SYM_OPMODE_CTR, alData.keys.Read_Key, alData.keys.Counter_block);
                
                /* writing data after decryption to meter_AL */
                memcpy(indication.app_data, process_buff, decrypt_length-16);                           /* Data */
                indication.app_dataLen = indParams->lsduLen-ENCRYPTED_MESSAGE_HEADER_LENGTH;            /* received data length */
                memcpy(received_time.data, &process_buff[decrypt_length-16], 8);                        /* POSIX timestamp */
                memcpy(alData.cmac.Received_cmac, &process_buff[decrypt_length-8], 8);                         /* CMAC */
                
                if(received_time.value > request_time.value )                            
                {    
                    if(CRYPTO_SYM_CIPHER_SUCCESS == indication.decryption_status)
                    {
                        /* Calculating 32-bit CRC for CMAC generation */
                        memset(alData.crc.buffer, 0, sizeof(alData.crc.buffer));
                        memcpy(alData.crc.buffer, aca.address, MAC_ADDRESS_SIZE);
                        alData.crc.dataLen += MAC_ADDRESS_SIZE;
                        memcpy(&alData.crc.buffer[6], indication.app_data, (decrypt_length-16));           
                        alData.crc.dataLen += decrypt_length-16;
                        alData.crc.result = SRV_PCRC_GetValue(alData.crc.buffer, alData.crc.dataLen, PCRC_HT_GENERIC, PCRC_CRC32, 1);                       /* CRC Calculation */  
                    
                        memset(alData.cmac.inputBuf, 0, sizeof(alData.cmac.inputBuf));
                        alData.cmac.inputBuf[0] = indParams->lsdu[0];                                    /* CM */
                        alData.cmac.input_dataLen = 1;
                        memcpy(&alData.cmac.inputBuf[1], aca.address, 3);                            /* ACA 3bytes(LSB) */
                        alData.cmac.input_dataLen += 3;
                        memcpy(&alData.cmac.inputBuf[4], alData.cmon.buff, 8);                      /* CMON */
                        alData.cmac.input_dataLen += 8;
                        memcpy(&alData.cmac.inputBuf[12], &alData.crc.result, 4);                               /* CRC(ACA,DATA) */
                        alData.cmac.input_dataLen += 4;
                        memcpy(alData.cmac.key, alData.keys.Read_Key, 16);                                      /* TO_DO KEY */
                        
                        Cmac_status = Crypto_Mac_AesCmac_Direct(CRYPTO_HANDLER_SW_WOLFCRYPT, alData.cmac.inputBuf, alData.cmac.input_dataLen, alData.cmac.Computed_cmac, AES_CMAC_LENGTH, alData.cmac.key, KEY_LENGTH, 1);

                        if (Cmac_status == CRYPTO_MAC_CIPHER_SUCCESS)
                        {
                            if (memcmp(alData.cmac.Computed_cmac, alData.cmac.Received_cmac, AES_CMAC_LENGTH) == 0)
                            {
                                indication.authentication_status = 1;                             /* CMAC verification successful */  
                                alData.lmon.value = alData.lmon.value +1;               /* TO_DO updating LMON to CMON */
                            }
                            else
                            {
                                indication.authentication_status = 0;                             /* CMAC verification fail */
                            }    
                        }  
                        else
                        {
                            indication.authentication_status = Cmac_status;                       /* CMAC generation failure with error status updated */
                        }
                    }
                }
                alData.dataIndCallback( &indication );
                break;
        }
    }
}

void AL_data_confirm_process( DLL_DATA_CONFIRM_PARAMS *cfmParams )
{
    AL_DATA_IND_PARAMS indication;
    
    if( alData.isMaster == false )
    {
        switch(cfmParams->txStatus)
        {
            case DLL_TX_STATUS_SUCCESS:

                if (cfmParams->dsap == DLL_DSAP_APPLICATION_FRAME)
                {    
                    /* Do Nothing */
                }
                else if (cfmParams->dsap == DLL_DSAP_NETWORK_MANAGEMENT)
                {   
                    /* Set flag once Req_Address_Req received and Address_Req sent to B_Nodes */
                    if ((alData.AL_NWStatus.flags.ACA_Req_Address_Req_rcvd == 1U) && (alData.AL_NWStatus.flags.ACA_Address_Req_Sent == 0U))
                    {
                        alData.AL_NWStatus.flags.ACA_Address_Req_Sent = 1U;
                    }    
                        
                    if (alData.AL_NWStatus.flags.ACA_ACK_sent == 1)
                    {
                        alData.AL_NWStatus.flags.ACA_ACK_sent = 0;
                    }
                    if (alData.AL_NWStatus.status_byte == 7)                                   /* Check all NW flags are set */ 
                    {
                        alData.AL_NWStatus.status_byte = 0;
                    }    
                }
                break;

            case DLL_TX_STATUS_ERROR:

                if(retry_count < RETRIES_LIMIT)
                {
                    DLL_DataRequest(&drParams);
                    
                    confirmWaitTimeoutUs = DLL_GetTxTimeout();                                /* ConfirmWait in uSec*/
                    confirmWaitCount = SYS_TIME_USToCount( confirmWaitTimeoutUs );
                    nextwaitCount = confirmWaitCount + SYS_TIME_Counter64Get();
                    
                    retry_count++;
                }
                else if(retry_count == RETRIES_LIMIT)
                {
                    if (cfmParams->dsap == DLL_DSAP_APPLICATION_FRAME)
                    {    
                        /* Inform Meter when retries failed */
                        memset(&indication, 0, sizeof(AL_DATA_IND_PARAMS));
                        
                        indication.command_message = drParams.lsdu[0];
                        indication.Last_Request_Tx_Failure = 1U;
                        
                        alData.dataIndCallback( &indication );
                    }
                    else if (cfmParams->dsap == DLL_DSAP_NETWORK_MANAGEMENT)
                    {    
                        if ( alData.AL_NWStatus.status_byte )                                      /* Check all NW flags are set */ 
                        {
                            alData.AL_NWStatus.status_byte = 0;
                        }    
                    }
                    retry_count = 0;
                }
                break;
        }
    }
    else
    {
        switch(cfmParams->txStatus)
        {
            case DLL_TX_STATUS_SUCCESS:

                if (alData.AL_Status.flags.DL_Confirm_rcvd == 0)
                {
                    alData.AL_Status.flags.DL_Confirm_rcvd = 1;
                }
                
                break;

            case DLL_TX_STATUS_ERROR:

                if(retry_count < RETRIES_LIMIT)
                {
                    DLL_DataRequest(&drParams);
                    
                    confirmWaitTimeoutUs = DLL_GetTxTimeout();                                /* ConfirmWait in uSec*/
                    confirmWaitCount = SYS_TIME_USToCount( confirmWaitTimeoutUs );
                    nextwaitCount = confirmWaitCount + SYS_TIME_Counter64Get();
            
                    retry_count++;
                }
                else if(retry_count == RETRIES_LIMIT)
                {
                    /* Inform CCU when retries failed */
                    memset(&indication, 0, sizeof(AL_DATA_IND_PARAMS));
                    
                    indication.command_message = drParams.lsdu[0];
                    indication.Last_Request_Tx_Failure = 1U;
                    alData.dataIndCallback( &indication );
                    
                    retry_count = 0;
                }
                break;
        }
    }
}

void AL_data_event_process( DLL_EVENT_IND_PARAMS *evParams )
{
    AL_EVENT_IND_PARAMS event;

    if (alData.eventIndCallback != NULL)
    {
        event.eventId = (AL_EVENT_ID)evParams->eventId;
        event.eventValue.length = evParams->eventValue.length;
        memcpy(event.eventValue.value, evParams->eventValue.value, evParams->eventValue.length);
        alData.eventIndCallback( &event );
    }
}

AL_RESULT AL_DataIndicationCallbackRegister( AL_DATA_IND_CALLBACK callback )
{
    alData.dataIndCallback = callback;
    return AL_SUCCESS;
}

AL_RESULT AL_EventIndicationCallbackRegister( AL_EVENT_IND_CALLBACK callback )
{
    alData.eventIndCallback = callback;
    return AL_SUCCESS;
}

SYS_MODULE_OBJ AL_Initialize ( const SYS_MODULE_INDEX index, const SYS_MODULE_INIT * const init )
{
    const AL_INIT * const alInit = (const AL_INIT * const)init;

    if ((index >= AL_INSTANCES_NUMBER) || (init == NULL))
    {
        return SYS_MODULE_OBJ_INVALID;
    }

    alData.status = SYS_STATUS_BUSY;
    alData.state = AL_STATE_WAIT_DLL_READY;

    alData.taskRateCount = SYS_TIME_MSToCount(alInit->taskRateMs);
    alData.nextTaskTimeCount = SYS_TIME_Counter64Get();
    alData.isMaster = alInit->isMaster;

    alData.dataIndCallback = NULL;
    alData.eventIndCallback = NULL;

    DLL_DataIndicationCallbackRegister( AL_data_indication_process );
    DLL_DataConfirmCallbackRegister( AL_data_confirm_process );
    DLL_EventIndicationCallbackRegister( AL_data_event_process );
    
    return (SYS_MODULE_OBJ)0;
}

void AL_HandlingTasks ( void )
{
    AL_DATA_REQ_PARAMS request;
    AL_EVENT_IND_PARAMS event;
    uint8_t process_bytes;
    uint8_t Index;
    
    if( alData.isMaster == false )
    {
        /* REQ_ADDRESS_REQ received, ADDRESS_REQ sent to B nodes. REQ_ADDRESS_RESP will be sent when it receives 4 responses or after timeout */
        if (((alData.AL_NWStatus.status_byte & 0x07) == 0x03) && (SYS_TIME_Counter64Get() > nextwaitCount ))
        {
            if(ACA_req_resp_count != 0U)
            {
                memset(process_buff, 0, MAX_LENGTH_432_DATA);
                process_buff[0] = REQ_ADDRESS_RESP;
                process_buff[1] = ACA_req_resp_count;
                process_bytes = 2;

                for(Index=0; Index < ACA_req_resp_count; Index++)
                {
                    memcpy(&process_buff[process_bytes], &ACA_req_resp[Index], 12);
                    process_bytes += 12;
                }    
                request.Txdata = process_buff;
                request.Txdata_Len = process_bytes;

                AL_DataRequest( &request );

                alData.AL_NWStatus.flags.ACA_Req_Address_Resp_sent = 1;
            } 
        }    
    }   
    else
    {   
        /* Request & Confirm are set and Indication received, clear flags */
        if ((alData.AL_Status.status_byte & 0x07) == 0x07)
        {
            alData.AL_Status.status_byte = 0;
        } 
        
        /* Request & Confirm are set, Indication not received, Generating Event at CCU End after timeout */
        if ((SYS_TIME_Counter64Get() > nextwaitCount ) && ((alData.AL_Status.status_byte & 0x07) == 0x03))
        {
            if (alData.eventIndCallback !=  NULL)
            {
                event.eventId = AL_EVENT_ID_MASTER_TX_TIMEOUT;
                event.eventValue.length = 0;
                alData.eventIndCallback( &event );
            }
        }    
    }    
}

void AL_Tasks( SYS_MODULE_OBJ object )
{
    if (object != (SYS_MODULE_OBJ)0)
    {
        // Invalid object
        return;
    }

    // Execute tasks according to defined rate
    if ((alData.taskRateCount != 0) && (SYS_TIME_Counter64Get() < alData.nextTaskTimeCount))
    {
        return;
    }
    alData.nextTaskTimeCount += alData.taskRateCount;

    switch (alData.state)
    {
        case AL_STATE_WAIT_DLL_READY:
            /* Wait for DLL to be ready */
            if (DLL_GetStatus() == SYS_STATUS_READY)
            {
                /* Set Status */
                alData.status = SYS_STATUS_READY;
                alData.state = AL_STATE_APP_PROCESS;
            }
            break;

        case AL_STATE_APP_PROCESS: 
            AL_HandlingTasks();
            break;

        default:
            break;
    }
}

SYS_STATUS AL_GetStatus(void)
{
    return alData.status;
}

AL_RESULT AL_GetRequest(AL_IB_ATTRIBUTE attribute, uint16_t index, AL_IB_VALUE *ibValue)
{
    AL_RESULT result = AL_SUCCESS;

    switch (attribute)
    {
        case AL_WRITE_KEY_K1_IB:
            /* Ignore index */
            ibValue->length = KEY_LENGTH;
            memcpy(ibValue->value, alData.Key_K1, KEY_LENGTH);
            break;

        case AL_READ_KEY_K2_IB:
            /* Ignore index */
            ibValue->length = KEY_LENGTH;
            memcpy(ibValue->value, alData.Key_K2, KEY_LENGTH);
            break;

        case AL_LMON_IB:
            /* Ignore index */
            ibValue->length = LMON_LENGTH;
            memcpy(ibValue->value, alData.lmon.buff, LMON_LENGTH);
            break;

        case AL_CMON_IB:
            /* Ignore index */
            ibValue->length = LMON_LENGTH;
            memcpy(ibValue->value, alData.cmon.buff, LMON_LENGTH);
            break;

        default:
            /* No AL IB, try with DLL */
            result = DLL_GetRequest((DLL_IB_ATTRIBUTE) attribute, index, (DLL_IB_VALUE *) ibValue);
    }

    return result;
}

AL_RESULT AL_SetRequest(AL_IB_ATTRIBUTE attribute, uint16_t index, const AL_IB_VALUE *ibValue)
{
    AL_RESULT result = AL_ERROR;

    switch (attribute)
    {
        case AL_WRITE_KEY_K1_IB:
            /* Ignore index */
            if (ibValue->length == KEY_LENGTH)
            {
                memcpy(alData.Key_K1, ibValue->value, KEY_LENGTH);
                memcpy(alData.keys.Write_Key, &alData.Key_K1[4], 12);
                memcpy(&alData.keys.Write_Key[12], alData.Key_K1, 4);
                result = AL_SUCCESS;
            }
            break;

        case AL_READ_KEY_K2_IB:
            /* Ignore index */
            if (ibValue->length == KEY_LENGTH)
            {
                memcpy(alData.Key_K2, ibValue->value, KEY_LENGTH);
                memcpy(alData.keys.Read_Key, &alData.Key_K2[4], 12);
                memcpy(&alData.keys.Read_Key[12], alData.Key_K2, 4);
                result = AL_SUCCESS;
            }
            break;

        case AL_LMON_IB:
            /* Ignore index */
            if (ibValue->length == LMON_LENGTH)
            {
                memcpy(alData.lmon.buff, ibValue->value, LMON_LENGTH);
                result = AL_SUCCESS;
            }
            break;

        case AL_CMON_IB:
            /* Ignore index */
            if (ibValue->length == LMON_LENGTH)
            {
                memcpy(alData.cmon.buff, ibValue->value, LMON_LENGTH);
                result = AL_SUCCESS;
            }
            break;

        default:
            /* No AL IB, try with DLL */
            result = DLL_GetRequest((DLL_IB_ATTRIBUTE) attribute, index, (DLL_IB_VALUE *) ibValue);
    }

    return result;
}

/* *****************************************************************************
 End of File
 */
