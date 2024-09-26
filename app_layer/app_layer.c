/* ************************************************************************** */

#include "stack/metersandmore/dll/dll.h"
#include <string.h>
#include "app_layer.h"
#include "service/random/srv_random.h"



#define MAX_DATA_LENGTH                     128U
#define ENCRYPTED_MESSAGE_HEADER_LENGTH     17U
#define AES_CMAC_LENGTH                     8U
#define RETRIES_LIMIT                       2U

uint8_t encrypt_length, decrypt_length;
uint8_t process_buff[MAX_DATA_LENGTH], process_bytes;
uint8_t dll_Tx_buffer[MAX_DATA_LENGTH];

static uint8_t Transmit_Buff[MAX_DATA_LENGTH];

/* Random Number Generated for LMON Recovery */
static uint8_t random_number[16];

static DLL_DATA_REQUEST_PARAMS drParams;
static uint32_t confirmWaitTimeoutUs;
static uint64_t confirmWaitCount, nextwaitCount;

static AL_STATUS App_Data;
static AL_HANDLERS al_handlers;
static AL_CONFIG_DATA config_data;
static uint8_t configparams_rcvd=0;
static KEYS keys;

static DATETIME received_time, request_time;  
static uint64_t nextTaskTimeCount;

/* Incoming TCT (min 1 to max 255) */
static uint8_t TCT;                                                    /* TO_DO Move to a modem specific structure */

/* Used in CCU AL to store node info(ACA, LMON) received from Concentrator Table, for AUTH & ENCRYPT handling*/
static NODE_INFO comm_node_configdata;

CRC_DATA crc;
CMAC_PARAMS cmac;
crypto_Mac_Status_E Cmac_status;

static ACA_NW_REQ ACA_Request;
static ACA_NW_RESP ACA_req_resp[4];
static uint8_t ACA_req_resp_count=0, retry_count;

/* This structure is used in meter side AL to store random number from CCU to Meter */
static struct
{
    uint8_t random_num[KEY_LENGTH];
    uint8_t challenge_req_received;
}lmon_recovery;

/* This variable is used only in Concentrator AL */
static union
{
    uint8_t status_byte;
    
    struct{
        int DL_Request_sent                 : 1;
        int DL_Confirm_rcvd                 : 1;
        int DL_Indication_req               : 1;
        int DL_Event_sent                   : 1;
    }flags;
}AL_Status;

static union
{
    uint8_t status_byte;
    
    struct{
        int ACA_Req_Address_Req_rcvd        : 1;
        int ACA_Address_Req_Sent            : 1;
        int ACA_Req_Address_Resp_sent       : 1;
        int ACA_ACK_sent                    : 1;                                    /* Same flag used for ACK & NACK */
        
    }flags;
}AL_NWStatus;

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

AL_M_STATUS AL_set_encryption_keys( AL_CONFIG_DATA *configparams )
{
    uint32_t lsb_32bits;
    
    if (configparams_rcvd == 1U)
    {
        memset(keys.Write_Key, 0, KEY_LENGTH);
        memcpy(&lsb_32bits,configparams->Key_K1, 4);
        memcpy(keys.Write_Key,&configparams->Key_K1[4], 12);
        memcpy(&keys.Write_Key[12],&lsb_32bits, 4);
        
        lsb_32bits=0;
        memset(keys.Read_Key, 0, KEY_LENGTH);
        memcpy(&lsb_32bits,configparams->Key_K2, 4);
        memcpy(keys.Read_Key,&configparams->Key_K2[4], 12);
        memcpy(&keys.Read_Key[12],&lsb_32bits, 4);
        
        keys.Keys_generation_status = 1;
    } 
    return AL_SUCCESS;
}

AL_M_STATUS AL_data_config_process( AL_CONFIG_DATA *configParams )
{
    memset(&config_data, 0, sizeof(AL_CONFIG_DATA));

    memcpy(config_data.ACA, configParams->ACA, 6);
    memcpy(config_data.SCA, configParams->SCA, 6);
    memcpy(config_data.Key_K1, configParams->Key_K1, 16);
    memcpy(config_data.Key_K2, configParams->Key_K2, 16);
    memcpy(config_data.lmon.buff, configParams->lmon.buff, 8);
    config_data.config_device = configParams->config_device;

    configparams_rcvd = 1U;
    AL_set_encryption_keys( &config_data );
    
    return AL_SUCCESS;
}

void counter_block_generation( uint64_t Msg_Order )
{
    memset(keys.Counter_block, 0, KEY_LENGTH);
    
    keys.Counter_block[0] = 1;
    memcpy(&keys.Counter_block[2], &Msg_Order, 8);
    memcpy(&keys.Counter_block[10],config_data.ACA, 6);
}

static bool address_filtering( void )
{
    uint8_t address_byte;
    
    /* Last byte of Meter ACA */
    address_byte = config_data.ACA[5];
    
    address_byte = address_byte + ACA_Request.AddToAddress;
    /* address_byte = address_byte>>ACA_Request.RightShiftAdd; */

    if((address_byte % 2) == 1)
        return false;
    else if((address_byte % 2) == 0)
        return true;
    
    return false;
}

AL_M_STATUS AL_data_request_process( AL_DATA_REQ_PARAMS *reqParams )
{
    if( config_data.config_device == AL_CONCENTRATOR )
    {
        /* Clear the Event Flag when new request received */
        AL_Status.flags.DL_Event_sent = 0;
        
        if(( reqParams->Txdata != NULL ) && ( configparams_rcvd == 1U ) && ( SYS_TIME_Counter64Get() > nextwaitCount ))
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
                    AL_Status.flags.DL_Request_sent = 1;                                                        /* Network message Handling */

                    confirmWaitTimeoutUs = DLL_GetTxTimeout();                                                  /* ConfirmWait in uSec*/
                    confirmWaitCount = SYS_TIME_USToCount( confirmWaitTimeoutUs );
                    nextwaitCount = confirmWaitCount + SYS_TIME_Counter64Get();
                    
                    break;

                case CHALLENGE_REQ:

                    /* Storing Node info to use during DLL_IND */
                    memset(&comm_node_configdata, 0, sizeof(NODE_INFO));
                    memcpy(comm_node_configdata.ACA, reqParams->node_info.ACA, ACA_LENGTH);                          /* Use in Challenge_response Ind process */
                    memcpy(comm_node_configdata.lmon.buff, reqParams->node_info.lmon.buff, LMON_LENGTH);             /* Not sure to use in Challenge_response Ind process */
                    
                    memset(Transmit_Buff, 0, MAX_DATA_LENGTH);
                    memset(random_number, 0, 16);

                    Transmit_Buff[0] = reqParams->Txdata[0];
                    SRV_RANDOM_Get128bits(random_number);
                    memcpy(&Transmit_Buff[3], random_number, 16);

                    drParams.dsap = DLL_DSAP_APPLICATION_FRAME;                                     
                    drParams.ecc = DLL_ECC_DISABLED;
                    drParams.serviceClass = reqParams->serviceClass;
                    drParams.timeSlotNum = reqParams->timeSlotNum;
                    memcpy(&drParams.dstAddress, &reqParams->dstAddress, sizeof(ROUTING_ENTRY));    /* testing needed */      
                    drParams.maxResponseLen = reqParams->maxResponseLen;
                    drParams.lsduLen = 19;                                                          /* CM+T+Random.NO 19 bytes */
                    drParams.lsdu = Transmit_Buff;

                    DLL_DataRequest(&drParams);
                    AL_Status.flags.DL_Request_sent = 1;                                            /* Network message Handling */
                    
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
                    AL_Status.flags.DL_Request_sent = 1;

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
                    memset(&comm_node_configdata, 0, sizeof(NODE_INFO));
                    memcpy(comm_node_configdata.ACA, reqParams->node_info.ACA, ACA_LENGTH);
                    memcpy(comm_node_configdata.lmon.buff, reqParams->node_info.lmon.buff, LMON_LENGTH);
                    request_time.value = reqParams->timestamp;
                    
                    /* Updating CMON with new LMON received from Request and increment by 1 */
                    config_data.cmon.value = comm_node_configdata.lmon.value + 1;
                    
                    memset(Transmit_Buff, 0, MAX_DATA_LENGTH);
                    Transmit_Buff[0] = reqParams->Txdata[0];

                    memset(crc.buffer, 0, MAX_DATA_LENGTH);
                    memcpy(crc.buffer, comm_node_configdata.ACA, ACA_LENGTH);                                /* Node ACA */
                    crc.dataLen = ACA_LENGTH;
                    memcpy(&crc.buffer[crc.dataLen], &reqParams->Txdata[1], reqParams->Txdata_Len-1);
                    crc.dataLen += reqParams->Txdata_Len-1;
                    crc.result = SRV_PCRC_GetValue(crc.buffer, crc.dataLen, PCRC_HT_USI, PCRC_CRC32, 1);    /* CRC Calculation */  
                    
                    memset(cmac.inputBuf, 0, sizeof(cmac.inputBuf));
                    cmac.inputBuf[0] = reqParams->Txdata[0];                                                    /* CM */
                    cmac.input_dataLen = 1;
                    memcpy(&cmac.inputBuf[cmac.input_dataLen], comm_node_configdata.ACA, 3);                 /* Node ACA 3bytes(LSB) */ 
                    cmac.input_dataLen += 3;
                    memcpy(&cmac.inputBuf[cmac.input_dataLen], config_data.cmon.buff, CMON_LENGTH);             /* CMON (LMON+1) used for CMAC generation in CCU */
                    cmac.input_dataLen += CMON_LENGTH;
                    memcpy(&cmac.inputBuf[cmac.input_dataLen], &crc.result, 4);                                 /* CRC(ACA,DATA) */
                    cmac.input_dataLen += 4;
                    memcpy(cmac.key, keys.Write_Key, 16);                                                       /* KEY */

                    Cmac_status = Crypto_Mac_AesCmac_Direct(CRYPTO_HANDLER_SW_WOLFCRYPT, cmac.inputBuf, cmac.input_dataLen, cmac.Computed_cmac, AES_CMAC_LENGTH, cmac.key, KEY_LENGTH, SessionID);

                    if (Cmac_status == CRYPTO_MAC_CIPHER_SUCCESS)
                    {    
                        /* Encryption of Meter Data, POSIX timestamp, CMAC */
                        memset(dll_Tx_buffer, 0, MAX_DATA_LENGTH);
                        memcpy(dll_Tx_buffer, &reqParams->Txdata[1], reqParams->Txdata_Len-1);                  /* Tx DATA */
                        process_bytes = reqParams->Txdata_Len-1;
                        memcpy(&dll_Tx_buffer[process_bytes], &reqParams->timestamp, 8);                        /* POSIX Time stamp */
                        process_bytes += 8;
                        memcpy(&dll_Tx_buffer[process_bytes], cmac.Computed_cmac, 8);                           /* LSB 64bits of CMAC */
                        process_bytes += 8;

                        counter_block_generation(config_data.cmon.value);                                       /* IV generation */
                        
                        if(EncryptData_dll(dll_Tx_buffer, process_bytes, &Transmit_Buff[1], CRYPTO_SYM_OPMODE_CTR, keys.Write_Key, keys.Counter_block) == true)
                        {
                            drParams.dsap = DLL_DSAP_APPLICATION_FRAME;
                            drParams.ecc = DLL_ECC_DISABLED;
                            drParams.lsduLen = process_bytes+1;                                                 /* CM */
                            drParams.lsdu = Transmit_Buff;
                            drParams.serviceClass = reqParams->serviceClass;
                            drParams.timeSlotNum = reqParams->timeSlotNum;
                            memcpy(&drParams.dstAddress, &reqParams->dstAddress, sizeof(ROUTING_ENTRY));        /* testing needed */      
                            drParams.maxResponseLen = reqParams->maxResponseLen;
                            
                            DLL_DataRequest(&drParams);
                            AL_Status.flags.DL_Request_sent = 1;

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
                    memset(&comm_node_configdata, 0, sizeof(NODE_INFO));
                    memcpy(comm_node_configdata.ACA, reqParams->node_info.ACA, ACA_LENGTH);
                    memcpy(comm_node_configdata.lmon.buff, reqParams->node_info.lmon.buff, LMON_LENGTH);
                    request_time.value = reqParams->timestamp;
                    
                    /* Updating CMON with new LMON received from Request and increment by 1 */
                    config_data.cmon.value = comm_node_configdata.lmon.value + 1;
                    
                    memset(Transmit_Buff, 0, MAX_DATA_LENGTH);
                    Transmit_Buff[0] = reqParams->Txdata[0];

                    memset(crc.buffer, 0, MAX_DATA_LENGTH);
                    memcpy(crc.buffer, comm_node_configdata.ACA, ACA_LENGTH);                                /* Node ACA */
                    crc.dataLen = ACA_LENGTH;
                    memcpy(&crc.buffer[crc.dataLen], &reqParams->Txdata[1], reqParams->Txdata_Len-1);
                    crc.dataLen += reqParams->Txdata_Len-1;
                    crc.result = SRV_PCRC_GetValue(crc.buffer, crc.dataLen, PCRC_HT_USI, PCRC_CRC32, 1);     /* CRC Calculation */  

                    memset(cmac.inputBuf, 0, sizeof(cmac.inputBuf));
                    cmac.inputBuf[0] = reqParams->Txdata[0];                                                    /* CM */
                    cmac.input_dataLen = 1;
                    memcpy(&cmac.inputBuf[cmac.input_dataLen], comm_node_configdata.ACA, 3);                 /* Node ACA 3bytes(LSB) */ 
                    cmac.input_dataLen += 3;
                    memcpy(&cmac.inputBuf[cmac.input_dataLen], config_data.cmon.buff, LMON_LENGTH);             /* CMON (LMON+1) used for CMAC generation in CCU */
                    cmac.input_dataLen += LMON_LENGTH;
                    memcpy(&cmac.inputBuf[cmac.input_dataLen], &crc.result, 4);                                 /* CRC(ACA,DATA) */
                    cmac.input_dataLen += 4;
                    memcpy(cmac.key, keys.Read_Key, 16);                                                        /* KEY */

                    Cmac_status = Crypto_Mac_AesCmac_Direct(CRYPTO_HANDLER_SW_WOLFCRYPT, cmac.inputBuf, cmac.input_dataLen, cmac.Computed_cmac, AES_CMAC_LENGTH, cmac.key, KEY_LENGTH, SessionID);

                    if (Cmac_status == CRYPTO_MAC_CIPHER_SUCCESS)
                    {    
                        /* Encryption of Meter Data, POSIX timestamp, CMAC */
                        memset(dll_Tx_buffer, 0, MAX_DATA_LENGTH);
                        memcpy(dll_Tx_buffer, &reqParams->Txdata[1], reqParams->Txdata_Len-1);
                        process_bytes = reqParams->Txdata_Len-1;
                        memcpy(&dll_Tx_buffer[process_bytes], &reqParams->timestamp, 8);
                        process_bytes += 8;
                        memcpy(&dll_Tx_buffer[process_bytes], cmac.Computed_cmac, 8);
                        process_bytes += 8;

                        counter_block_generation(config_data.cmon.value);                       /* IV generation */
                        
                        if(EncryptData_dll(dll_Tx_buffer, process_bytes, &Transmit_Buff[1], CRYPTO_SYM_OPMODE_CTR, keys.Read_Key, keys.Counter_block) == true)
                        {
                            drParams.dsap = DLL_DSAP_APPLICATION_FRAME;
                            drParams.ecc = DLL_ECC_DISABLED;
                            drParams.lsduLen = process_bytes+1;                                 /* CM */
                            drParams.lsdu = Transmit_Buff;
                            drParams.serviceClass = reqParams->serviceClass;
                            drParams.timeSlotNum = reqParams->timeSlotNum;
                            memcpy(&drParams.dstAddress, &reqParams->dstAddress, sizeof(ROUTING_ENTRY));                      /* testing needed */      
                            drParams.maxResponseLen = reqParams->maxResponseLen;
                    
                            DLL_DataRequest(&drParams);
                            AL_Status.flags.DL_Request_sent = 1;

                            confirmWaitTimeoutUs = DLL_GetTxTimeout();                                          /* ConfirmWait in uSec*/
                            confirmWaitCount = SYS_TIME_USToCount( confirmWaitTimeoutUs );
                            nextwaitCount = confirmWaitCount + SYS_TIME_Counter64Get();
                        }    
                    }    
                    break;

            /*  case Concentrator_ACK:                                                          // No ACK/NACK CM from CCU in Spec.Doc 
                
                    break;  */
            }
            return AL_PROCESSED;
        }
    }
    else if( config_data.config_device == AL_METER )
    {
        if(( reqParams->Txdata != NULL ) && ( configparams_rcvd == 1U ) && ( SYS_TIME_Counter64Get() > nextwaitCount ))
        {
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
                    AL_NWStatus.flags.ACA_ACK_sent = 1;                                                 /* Network message Handling */

                    confirmWaitTimeoutUs = DLL_GetTxTimeout();                                          /* ConfirmWait in uSec*/
                    confirmWaitCount = SYS_TIME_USToCount( confirmWaitTimeoutUs );
                    nextwaitCount = confirmWaitCount + SYS_TIME_Counter64Get();
                    
                    break;

                case CHALLENGE_REQ:

                    break;

                case CHALLENGE_RESP:    

                    if(lmon_recovery.challenge_req_received == 1)
                    {    
                        Transmit_Buff[0] = reqParams->Txdata[0];
                        memset(crc.buffer, 0, MAX_DATA_LENGTH);
                        memcpy(crc.buffer, config_data.ACA, ACA_LENGTH);  
                        crc.dataLen = ACA_LENGTH;
                        memcpy(&crc.buffer[crc.dataLen], lmon_recovery.random_num, 16);
                        crc.dataLen += 16;
                        crc.result = SRV_PCRC_GetValue(crc.buffer, crc.dataLen, PCRC_HT_USI, PCRC_CRC32, 1);      /* CRC Calculation */  

                        memset(cmac.inputBuf, 0, sizeof(cmac.inputBuf));
                        cmac.inputBuf[0] = reqParams->Txdata[0];                                    /* CM */
                        cmac.input_dataLen = 1;
                        memcpy(&cmac.inputBuf[cmac.input_dataLen], config_data.ACA, 3);             /* ACA 3bytes(LSB) */ 
                        cmac.input_dataLen += 3;
                        memcpy(&cmac.inputBuf[cmac.input_dataLen], config_data.lmon.buff, LMON_LENGTH);       /* LMON used for CMAC generation in Meter */
                        cmac.input_dataLen += LMON_LENGTH;
                        memcpy(&cmac.inputBuf[cmac.input_dataLen], &crc.result, 4);                 /* CRC(ACA,DATA) */
                        cmac.input_dataLen += 4;
                        memcpy(cmac.key, keys.Write_Key, 16);                                       /* KEY */

                        Cmac_status = Crypto_Mac_AesCmac_Direct(CRYPTO_HANDLER_SW_WOLFCRYPT, cmac.inputBuf, cmac.input_dataLen, cmac.Computed_cmac, AES_CMAC_LENGTH, cmac.key, KEY_LENGTH, SessionID);

                        if (Cmac_status == CRYPTO_MAC_CIPHER_SUCCESS)
                        {    
                            memset(dll_Tx_buffer, 0, MAX_DATA_LENGTH);
                            memcpy(dll_Tx_buffer, config_data.lmon.buff, LMON_LENGTH);
                            process_bytes = LMON_LENGTH;
                            memcpy(&dll_Tx_buffer[LMON_LENGTH], cmac.Computed_cmac, LMON_LENGTH);
                            process_bytes += LMON_LENGTH;

                            /* ECB mode doesn't require Counter Block */
                            if(EncryptData_dll(dll_Tx_buffer, process_bytes, &Transmit_Buff[3], CRYPTO_SYM_OPMODE_ECB, keys.Write_Key, NULL ) == true)
                            {
                                drParams.dsap = DLL_DSAP_APPLICATION_FRAME;
                                drParams.ecc = DLL_ECC_DISABLED;
                                drParams.lsduLen = process_bytes+3;                                 /* CM+T 3bytes */
                                drParams.lsdu = Transmit_Buff;

                                DLL_DataRequest(&drParams);
                                lmon_recovery.challenge_req_received = 0;
                                
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

                    memset(Transmit_Buff, 0, MAX_DATA_LENGTH);
                    Transmit_Buff[0] = reqParams->Txdata[0];

                    memset(crc.buffer, 0, MAX_DATA_LENGTH);
                    memcpy(crc.buffer, config_data.ACA, ACA_LENGTH);  
                    crc.dataLen = ACA_LENGTH;
                    memcpy(&crc.buffer[crc.dataLen], &reqParams->Txdata[1], reqParams->Txdata_Len-1);
                    crc.dataLen += reqParams->Txdata_Len-1;
                    crc.result = SRV_PCRC_GetValue(crc.buffer, crc.dataLen, PCRC_HT_USI, PCRC_CRC32, 1);    /* CRC Calculation */  

                    memset(cmac.inputBuf, 0, sizeof(cmac.inputBuf));
                    cmac.inputBuf[0] = reqParams->Txdata[0];                                                /* CM */
                    cmac.input_dataLen = 1;
                    memcpy(&cmac.inputBuf[cmac.input_dataLen], config_data.ACA, 3);                         /* ACA 3bytes(LSB) */ 
                    cmac.input_dataLen += 3;
                    memcpy(&cmac.inputBuf[cmac.input_dataLen], config_data.lmon.buff, LMON_LENGTH);         /* LMON used for CMAC generation in Meter */
                    cmac.input_dataLen += LMON_LENGTH;
                    memcpy(&cmac.inputBuf[cmac.input_dataLen], &crc.result, 4);                             /* CRC(ACA,DATA) */
                    cmac.input_dataLen += 4;
                    memcpy(cmac.key, keys.Write_Key, 16);                                                   /* KEY */

                    Cmac_status = Crypto_Mac_AesCmac_Direct(CRYPTO_HANDLER_SW_WOLFCRYPT, cmac.inputBuf, cmac.input_dataLen, cmac.Computed_cmac, AES_CMAC_LENGTH, cmac.key, KEY_LENGTH, SessionID);

                    if (Cmac_status == CRYPTO_MAC_CIPHER_SUCCESS)
                    {    
                        /* Encryption of Meter Data, POSIX timestamp, CMAC */
                        memset(dll_Tx_buffer, 0, MAX_DATA_LENGTH);
                        memcpy(dll_Tx_buffer, &reqParams->Txdata[1], reqParams->Txdata_Len-1);
                        process_bytes = reqParams->Txdata_Len-1;
                        memcpy(&dll_Tx_buffer[process_bytes], &reqParams->timestamp, 8);
                        process_bytes += 8;
                        memcpy(&dll_Tx_buffer[process_bytes], cmac.Computed_cmac, 8);
                        process_bytes += 8;

                        counter_block_generation(config_data.lmon.value);                                   /* IV generation */
                        if(EncryptData_dll(dll_Tx_buffer, process_bytes, &Transmit_Buff[1], CRYPTO_SYM_OPMODE_CTR, keys.Write_Key, keys.Counter_block) == true)
                        {
                            drParams.dsap = DLL_DSAP_APPLICATION_FRAME;
                            drParams.ecc = DLL_ECC_DISABLED;
                            drParams.lsduLen = process_bytes+1;                                             /* CM */
                            drParams.lsdu = Transmit_Buff;

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

                    memset(Transmit_Buff, 0, MAX_DATA_LENGTH);
                    Transmit_Buff[0] = reqParams->Txdata[0];

                    memset(crc.buffer, 0, MAX_DATA_LENGTH);
                    memcpy(crc.buffer, config_data.ACA, ACA_LENGTH);  
                    crc.dataLen = ACA_LENGTH;
                    memcpy(&crc.buffer[crc.dataLen], &reqParams->Txdata[1], reqParams->Txdata_Len-1);
                    crc.dataLen += reqParams->Txdata_Len-1;
                    crc.result = SRV_PCRC_GetValue(crc.buffer, crc.dataLen, PCRC_HT_USI, PCRC_CRC32, 1);    /* CRC Calculation */  

                    memset(cmac.inputBuf, 0, sizeof(cmac.inputBuf));
                    cmac.inputBuf[0] = reqParams->Txdata[0];                                                /* CM */
                    cmac.input_dataLen = 1;
                    memcpy(&cmac.inputBuf[cmac.input_dataLen], config_data.ACA, 3);                         /* ACA 3bytes(LSB) */ 
                    cmac.input_dataLen += 3;
                    memcpy(&cmac.inputBuf[cmac.input_dataLen], config_data.lmon.buff, LMON_LENGTH);         /* LMON used for CMAC generation in Meter */
                    cmac.input_dataLen += LMON_LENGTH;
                    memcpy(&cmac.inputBuf[cmac.input_dataLen], &crc.result, 4);                             /* CRC(ACA,DATA) */
                    cmac.input_dataLen += 4;
                    memcpy(cmac.key, keys.Read_Key, 16);                                                    /* KEY */

                    Cmac_status = Crypto_Mac_AesCmac_Direct(CRYPTO_HANDLER_SW_WOLFCRYPT, cmac.inputBuf, cmac.input_dataLen, cmac.Computed_cmac, AES_CMAC_LENGTH, cmac.key, KEY_LENGTH, SessionID);

                    if (Cmac_status == CRYPTO_MAC_CIPHER_SUCCESS)
                    {    
                        /* Encryption of Meter Data, POSIX timestamp, CMAC */
                        memset(dll_Tx_buffer, 0, MAX_DATA_LENGTH);
                        memcpy(dll_Tx_buffer, &reqParams->Txdata[1], reqParams->Txdata_Len-1);
                        process_bytes = reqParams->Txdata_Len-1;
                        memcpy(&dll_Tx_buffer[process_bytes], &reqParams->timestamp, 8);
                        process_bytes += 8;
                        memcpy(&dll_Tx_buffer[process_bytes], cmac.Computed_cmac, 8);
                        process_bytes += 8;

                        counter_block_generation(config_data.lmon.value);                                   /* IV generation */
                        if(EncryptData_dll(dll_Tx_buffer, process_bytes, &Transmit_Buff[1], CRYPTO_SYM_OPMODE_CTR, keys.Read_Key, keys.Counter_block) == true)
                        {
                            drParams.dsap = DLL_DSAP_APPLICATION_FRAME;
                            drParams.ecc = DLL_ECC_DISABLED;
                            drParams.lsduLen = process_bytes+1;                                             /* CM */
                            drParams.lsdu = Transmit_Buff;

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
                
                    memset(Transmit_Buff, 0, MAX_DATA_LENGTH);
                    Transmit_Buff[0] = reqParams->Txdata[0];

                    memset(crc.buffer, 0, MAX_DATA_LENGTH);
                    memcpy(crc.buffer, config_data.ACA, ACA_LENGTH);  
                    crc.dataLen = ACA_LENGTH;
                    memcpy(&crc.buffer[crc.dataLen], &reqParams->Txdata[1], reqParams->Txdata_Len-1);
                    crc.dataLen += reqParams->Txdata_Len-1;
                    crc.result = SRV_PCRC_GetValue(crc.buffer, crc.dataLen, PCRC_HT_USI, PCRC_CRC32, 1);    /* CRC Calculation */  

                    memset(cmac.inputBuf, 0, sizeof(cmac.inputBuf));
                    cmac.inputBuf[0] = reqParams->Txdata[0];                                                /* CM */
                    cmac.input_dataLen = 1;
                    memcpy(&cmac.inputBuf[cmac.input_dataLen], config_data.ACA, 3);                         /* ACA 3bytes(LSB) */ 
                    cmac.input_dataLen += 3;
                    memcpy(&cmac.inputBuf[cmac.input_dataLen], config_data.cmon.buff, LMON_LENGTH);         /* CMON used for CMAC generation in Meter for ACK */
                    cmac.input_dataLen += LMON_LENGTH;
                    memcpy(&cmac.inputBuf[cmac.input_dataLen], &crc.result, 4);                             /* CRC(ACA,DATA) */
                    cmac.input_dataLen += 4;
                    memcpy(cmac.key, keys.Write_Key, 16);                                                    /* KEY */

                    Cmac_status = Crypto_Mac_AesCmac_Direct(CRYPTO_HANDLER_SW_WOLFCRYPT, cmac.inputBuf, cmac.input_dataLen, cmac.Computed_cmac, AES_CMAC_LENGTH, cmac.key, KEY_LENGTH, SessionID);

                    if (Cmac_status == CRYPTO_MAC_CIPHER_SUCCESS)
                    {    
                        /* Encryption of Meter Data, POSIX timestamp, CMAC */
                        memset(dll_Tx_buffer, 0, MAX_DATA_LENGTH);
                        memcpy(dll_Tx_buffer, &reqParams->Txdata[1], reqParams->Txdata_Len-1);
                        process_bytes = reqParams->Txdata_Len-1;
                        memcpy(&dll_Tx_buffer[process_bytes], &reqParams->timestamp, 8);
                        process_bytes += 8;
                        memcpy(&dll_Tx_buffer[process_bytes], cmac.Computed_cmac, 8);
                        process_bytes += 8;

                        counter_block_generation(config_data.cmon.value);                                   /* IV generation */
                        if (EncryptData_dll(dll_Tx_buffer, process_bytes, &Transmit_Buff[1], CRYPTO_SYM_OPMODE_CTR, keys.Write_Key, keys.Counter_block) == true)
                        {
                            drParams.dsap = DLL_DSAP_APPLICATION_FRAME;
                            drParams.ecc = DLL_ECC_DISABLED;
                            drParams.lsduLen = process_bytes+1;                                             /* CM */
                            drParams.lsdu = Transmit_Buff;

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
            return AL_PROCESSED;
        }
    }
    return AL_BUSY;
}

void AL_data_indication_process( DLL_DATA_IND_PARAMS *indParams )
{
    AL_DATA_IND_PARAMS indication;
    AL_DATA_REQ_PARAMS request;
    DLL_IB_VALUE getValue;
    DLL_RESULT result;
    LMON lmon_recover;
    uint8_t Index;
    
    memset(&indication, 0, sizeof(AL_DATA_IND_PARAMS));
    memset(&request, 0, sizeof(AL_DATA_REQ_PARAMS));
    
    if( config_data.config_device == AL_CONCENTRATOR )
    {
        AL_Status.flags.DL_Indication_req = 1;
        
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
                al_handlers.dataIndCallback( &indication );
                
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
                al_handlers.dataIndCallback( &indication );
                
                break;
                
            case CHALLENGE_REQ:
                
                break;  
            
            case CHALLENGE_RESP:
                
                indication.command_message = indParams->lsdu[0];
                indication.message_type = AL_ENCRYPTION_ENABLED;
                decrypt_length = indParams->lsduLen-1;
                memset(process_buff, 0, MAX_DATA_LENGTH);
                
                /* ECB mode doesn't require Counter Block */
                indication.decryption_status = DecryptData_Comm(&indParams->lsdu[1], decrypt_length, process_buff, CRYPTO_SYM_OPMODE_CTR, keys.Write_Key, NULL);
                
                /* writing data after decryption to meter_AL */
                memcpy(lmon_recover.buff, process_buff, LMON_LENGTH);                               /* LMON received */
                memcpy(cmac.Received_cmac, &process_buff[LMON_LENGTH], 8);                          /* CMAC */
                indication.app_dataLen = 0U;                                                        /* data length is 0 as LMON is only data. its value is updated in indication.node_info */
                
                if(CRYPTO_SYM_CIPHER_SUCCESS == indication.decryption_status)
                {
                    /* Calculating 32-bit CRC for CMAC generation */
                    memset(crc.buffer, 0, sizeof(crc.buffer));
                    memcpy(crc.buffer, comm_node_configdata.ACA, ACA_LENGTH);                             
                    crc.dataLen = ACA_LENGTH;
                    memcpy(&crc.buffer[6], random_number, 16);                                      /* Random number used in challenge Request */
                    crc.dataLen += 16;
                    crc.result = SRV_PCRC_GetValue(crc.buffer, crc.dataLen, PCRC_HT_USI, PCRC_CRC32, 1); /* CRC Calculation */  

                    memset(cmac.inputBuf, 0, sizeof(cmac.inputBuf));
                    cmac.inputBuf[0] = indParams->lsdu[0];                                          /* CM */
                    cmac.input_dataLen = 1;
                    memcpy(&cmac.inputBuf[1], comm_node_configdata.ACA, 3);                         /* Node ACA 3bytes(LSB) */ 
                    cmac.input_dataLen += 3;
                    memcpy(&cmac.inputBuf[4], lmon_recover.buff, LMON_LENGTH); 
                    cmac.input_dataLen += LMON_LENGTH;
                    memcpy(&cmac.inputBuf[12], &crc.result, 4);                                     /* CRC(ACA,DATA) */
                    cmac.input_dataLen += 4;
                    memcpy(cmac.key, keys.Write_Key, 16);                                           /* Write KEY */

                    Cmac_status = Crypto_Mac_AesCmac_Direct(CRYPTO_HANDLER_SW_WOLFCRYPT, cmac.inputBuf, cmac.input_dataLen, cmac.Computed_cmac, AES_CMAC_LENGTH, cmac.key, KEY_LENGTH, 1);

                    if (Cmac_status == CRYPTO_MAC_CIPHER_SUCCESS)
                    {
                        if (memcmp(cmac.Computed_cmac, cmac.Received_cmac, AES_CMAC_LENGTH) == 0)
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
                
                al_handlers.dataIndCallback( &indication );
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
                al_handlers.dataIndCallback( &indication );
                
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
                memset(process_buff, 0, MAX_DATA_LENGTH);
                
                counter_block_generation(config_data.cmon.value);                                       /* CMON for Decryption and Authentication */                        
                indication.decryption_status = DecryptData_Comm(&indParams->lsdu[1], decrypt_length, process_buff, CRYPTO_SYM_OPMODE_CTR, keys.Write_Key, keys.Counter_block);
                
                /* writing data after decryption to meter_AL */
                memcpy(indication.app_data, process_buff, decrypt_length-16);                           /* Data, excluding Timestamp & CMAC */
                indication.app_dataLen = indParams->lsduLen-ENCRYPTED_MESSAGE_HEADER_LENGTH;            /* received data length */
                memcpy(received_time.data, &process_buff[decrypt_length-16], 8);                        /* POSIX timestamp */
                memcpy(cmac.Received_cmac, &process_buff[decrypt_length-8], 8);                         /* CMAC */
                
                if(received_time.value > request_time.value )                            
                {    
                    if(CRYPTO_SYM_CIPHER_SUCCESS == indication.decryption_status)
                    {
                        /* Calculating 32-bit CRC(ACA, Data) for CMAC generation */
                        memset(crc.buffer, 0, sizeof(crc.buffer));
                        memcpy(crc.buffer, comm_node_configdata.ACA, ACA_LENGTH);                       /* ACA of Node */         
                        crc.dataLen = ACA_LENGTH;
                        memcpy(&crc.buffer[6], indication.app_data, (decrypt_length-16));           
                        crc.dataLen += decrypt_length-16;
                        crc.result = SRV_PCRC_GetValue(crc.buffer, crc.dataLen, PCRC_HT_USI, PCRC_CRC32, 1); /* CRC Calculation */  

                        memset(cmac.inputBuf, 0, sizeof(cmac.inputBuf));
                        cmac.inputBuf[0] = indParams->lsdu[0];                                          /* CM */
                        cmac.input_dataLen = 1;
                        memcpy(&cmac.inputBuf[1], comm_node_configdata.ACA, 3);                         /* ACA 3bytes(LSB) */ 
                        cmac.input_dataLen += 3;
                        memcpy(&cmac.inputBuf[4], config_data.cmon.buff, 8);                            /* updated CMON value */ 
                        cmac.input_dataLen += 8;
                        memcpy(&cmac.inputBuf[12], &crc.result, 4);                                     /* CRC(ACA,DATA) */
                        cmac.input_dataLen += 4;
                        memcpy(cmac.key, keys.Write_Key, 16);                                           /* Write KEY */

                        Cmac_status = Crypto_Mac_AesCmac_Direct(CRYPTO_HANDLER_SW_WOLFCRYPT, cmac.inputBuf, cmac.input_dataLen, cmac.Computed_cmac, AES_CMAC_LENGTH, cmac.key, KEY_LENGTH, 1);

                        if (Cmac_status == CRYPTO_MAC_CIPHER_SUCCESS)
                        {
                            if (memcmp(cmac.Computed_cmac, cmac.Received_cmac, AES_CMAC_LENGTH) == 0)
                            {
                                indication.authentication_status = 1;                                   /* CMAC verification successful */  
                                indication.node_info.lmon.value = config_data.cmon.value;               /* Updating Node LMON to CMON and indicate to CCU */ 
                                memcpy(indication.node_info.ACA, comm_node_configdata.ACA, ACA_LENGTH);
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
                
                al_handlers.dataIndCallback( &indication );
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
                memset(process_buff, 0, MAX_DATA_LENGTH);
                
                counter_block_generation(config_data.cmon.value);                                           /* CMON for Decryption and Authentication */         
                indication.decryption_status = DecryptData_Comm(&indParams->lsdu[1], decrypt_length, process_buff, CRYPTO_SYM_OPMODE_CTR, keys.Read_Key, keys.Counter_block);
                
                /* writing data after decryption to meter_AL */
                memcpy(indication.app_data, process_buff, decrypt_length-16);                               /* Data */
                indication.app_dataLen = indParams->lsduLen-ENCRYPTED_MESSAGE_HEADER_LENGTH;                /* received data length */
                memcpy(received_time.data, &process_buff[decrypt_length-16], 8);                            /* POSIX timestamp */
                memcpy(cmac.Received_cmac, &process_buff[decrypt_length-8], 8);                             /* CMAC */
                
                if(received_time.value > request_time.value )                            
                {    
                    if(CRYPTO_SYM_CIPHER_SUCCESS == indication.decryption_status)
                    {
                        /* Calculating 32-bit CRC for CMAC generation */
                        memset(crc.buffer, 0, sizeof(crc.buffer));
                        memcpy(crc.buffer, comm_node_configdata.ACA, ACA_LENGTH);                           /* ACA of Node */          
                        crc.dataLen = ACA_LENGTH;
                        memcpy(&crc.buffer[6], indication.app_data, (decrypt_length-16));           
                        crc.dataLen += decrypt_length-16;
                        crc.result = SRV_PCRC_GetValue(crc.buffer, crc.dataLen, PCRC_HT_USI, PCRC_CRC32, 1); /* CRC Calculation */  
                    
                        memset(cmac.inputBuf, 0, sizeof(cmac.inputBuf));
                        cmac.inputBuf[0] = indParams->lsdu[0];                                              /* CM */
                        cmac.input_dataLen = 1;
                        memcpy(&cmac.inputBuf[1], comm_node_configdata.ACA, 3);                             /* ACA 3bytes(LSB) */ 
                        cmac.input_dataLen += 3;
                        memcpy(&cmac.inputBuf[4], config_data.cmon.buff, 8);                                /* updated CMON value */ 
                        cmac.input_dataLen += 8;
                        memcpy(&cmac.inputBuf[12], &crc.result, 4);                                         /* CRC(ACA,DATA) */
                        cmac.input_dataLen += 4;
                        memcpy(cmac.key, keys.Read_Key, 16);                                                /* KEY */
                        
                        Cmac_status = Crypto_Mac_AesCmac_Direct(CRYPTO_HANDLER_SW_WOLFCRYPT, cmac.inputBuf, cmac.input_dataLen, cmac.Computed_cmac, AES_CMAC_LENGTH, cmac.key, KEY_LENGTH, 1);

                        if (Cmac_status == CRYPTO_MAC_CIPHER_SUCCESS)
                        {
                            if (memcmp(cmac.Computed_cmac, cmac.Received_cmac, AES_CMAC_LENGTH) == 0)
                            {
                                indication.authentication_status = 1;                                   /* CMAC verification successful */  
                                indication.node_info.lmon.value = config_data.cmon.value;               /* Updating Node LMON to CMON and indicate to CCU */ 
                                memcpy(indication.node_info.ACA, comm_node_configdata.ACA, ACA_LENGTH);
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
                al_handlers.dataIndCallback( &indication );
                break;
                
            case A_Node_ACK:
            case A_Node_NACK:    
                
                indication.command_message = indParams->lsdu[0];
                indication.app_dataLen = indParams->lsduLen-1;
                indication.message_type = AL_ENCRYPTION_DISABLED;
                memcpy(indication.app_data, &indParams->lsdu[1], indication.app_dataLen);
                al_handlers.dataIndCallback( &indication );
                
                break;
                
            case A_Node_ACK_AUTH:
                
                indication.command_message = indParams->lsdu[0];
                indication.message_type = AL_ENCRYPTION_ENABLED;
                decrypt_length = indParams->lsduLen-1;
                memset(process_buff, 0, MAX_DATA_LENGTH);
                
                counter_block_generation(config_data.cmon.value);                                           /* CMON for Decryption and Authentication */         
                indication.decryption_status = DecryptData_Comm(&indParams->lsdu[1], decrypt_length, process_buff, CRYPTO_SYM_OPMODE_CTR, keys.Write_Key, keys.Counter_block);
                
                /* writing data after decryption to meter_AL */
                memcpy(indication.app_data, process_buff, decrypt_length-16);                               /* Data */
                indication.app_dataLen = indParams->lsduLen-ENCRYPTED_MESSAGE_HEADER_LENGTH;                /* received data length */
                memcpy(received_time.data, &process_buff[decrypt_length-16], 8);                            /* POSIX timestamp */
                memcpy(cmac.Received_cmac, &process_buff[decrypt_length-8], 8);                             /* CMAC */
                
                if(received_time.value > request_time.value )                            
                {    
                    if(CRYPTO_SYM_CIPHER_SUCCESS == indication.decryption_status)
                    {
                        /* Calculating 32-bit CRC for CMAC generation */
                        memset(crc.buffer, 0, sizeof(crc.buffer));
                        memcpy(crc.buffer, comm_node_configdata.ACA, ACA_LENGTH);                           /* ACA of Node */          
                        crc.dataLen = ACA_LENGTH;
                        memcpy(&crc.buffer[6], indication.app_data, (decrypt_length-16));           
                        crc.dataLen += decrypt_length-16;
                        crc.result = SRV_PCRC_GetValue(crc.buffer, crc.dataLen, PCRC_HT_USI, PCRC_CRC32, 1); /* CRC Calculation */  
                    
                        memset(cmac.inputBuf, 0, sizeof(cmac.inputBuf));
                        cmac.inputBuf[0] = indParams->lsdu[0];                                              /* CM */
                        cmac.input_dataLen = 1;
                        memcpy(&cmac.inputBuf[1], comm_node_configdata.ACA, 3);                             /* ACA 3bytes(LSB) */ 
                        cmac.input_dataLen += 3;
                        memcpy(&cmac.inputBuf[4], config_data.cmon.buff, 8);                                /* updated CMON value */ 
                        cmac.input_dataLen += 8;
                        memcpy(&cmac.inputBuf[12], &crc.result, 4);                                         /* CRC(ACA,DATA) */
                        cmac.input_dataLen += 4;
                        memcpy(cmac.key, keys.Write_Key, 16);                                                /* KEY */
                        
                        Cmac_status = Crypto_Mac_AesCmac_Direct(CRYPTO_HANDLER_SW_WOLFCRYPT, cmac.inputBuf, cmac.input_dataLen, cmac.Computed_cmac, AES_CMAC_LENGTH, cmac.key, KEY_LENGTH, 1);

                        if (Cmac_status == CRYPTO_MAC_CIPHER_SUCCESS)
                        {
                            if (memcmp(cmac.Computed_cmac, cmac.Received_cmac, AES_CMAC_LENGTH) == 0)
                            {
                                indication.authentication_status = 1;                                   /* CMAC verification successful */  
                                indication.node_info.lmon.value = config_data.cmon.value;               /* Updating Node LMON to CMON and indicate to CCU */ 
                                memcpy(indication.node_info.ACA, comm_node_configdata.ACA, ACA_LENGTH);
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
                al_handlers.dataIndCallback( &indication );
                
                break;
                
            case A_Node_NACK_AUTH:
                
                /* TO_DO */
                break;
        }
    }
    else if( config_data.config_device == AL_METER )
    {
        switch (indParams->lsdu[0])
        {
            case ADDRESS_REQ:
                
                ACA_Request.Phase = indParams->lsdu[1];
                ACA_Request.TCR = indParams->lsdu[2];
                ACA_Request.AddToAddress = indParams->lsdu[3];
                ACA_Request.RightShiftAdd = indParams->lsdu[4];
                
                result = DLL_GetRequest(MAC_LAST_RX_IN_PHASE_IB, 0, &getValue);                               /* TO_DO Phase value? */
                
                if((TCT >= ACA_Request.TCR) || (ACA_Request.Phase == getValue.value[0]) || (address_filtering() == true))                /* TO_DO in phase value or AddToAddress value is true */
                {
                    memset(process_buff, 0, MAX_DATA_LENGTH);
                    
                    process_buff[0] = ADDRESS_RESP;
                    
                    memcpy(&process_buff[1], config_data.ACA, 6);
                    
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
                    
                    AL_data_request_process( &request );
                }
                break;

            case ADDRESS_RESP:
                
                if((AL_NWStatus.flags.ACA_Req_Address_Req_rcvd == 1) && (AL_NWStatus.flags.ACA_Address_Req_Sent == 1))
                {
                    if(ACA_req_resp_count<4)
                    {
                        memcpy(&ACA_req_resp[ACA_req_resp_count], &indParams->lsdu[1], 12);
                        ACA_req_resp_count++;
                    }
                    
                    if(ACA_req_resp_count == 4)
                    {
                        memset(process_buff, 0, MAX_DATA_LENGTH);
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

                        AL_data_request_process( &request );
                        
                        AL_NWStatus.flags.ACA_Req_Address_Resp_sent = 1;
                    }    
                }
                break;
                
            case TCT_SET_REQ:    
                
                memset(process_buff, 0, MAX_DATA_LENGTH);
                
                if(indParams->lsduLen == 2)
                {
                    /* Incoming TCT (min 1 to max 255) */
                    if((indParams->lsdu[1] > 0) && (indParams->lsdu[1] < 256))
                    {    
                        TCT = indParams->lsdu[1];
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

                AL_data_request_process( &request );
                
                break;
                
            case REQ_ADDRESS_REQ:    
                
                memset(process_buff, 0, MAX_DATA_LENGTH);
                process_buff[0] = ADDRESS_REQ;
                memcpy(&process_buff[1], &indParams->lsdu[1], 4);
                
                request.Txdata = process_buff;
                request.Txdata_Len = 5;
                    
                AL_data_request_process( &request );
                
                AL_NWStatus.flags.ACA_Req_Address_Req_rcvd = 1;
                
                break;
                
            case CHALLENGE_REQ:
                
                lmon_recovery.challenge_req_received = 1;
                memcpy(lmon_recovery.random_num, &indParams->lsdu[3], KEY_LENGTH);
                memset(process_buff, 0, MAX_DATA_LENGTH);
                process_buff[0] = CHALLENGE_RESP;
                request.Txdata = process_buff;
                request.Txdata_Len = 1;
                
                AL_data_request_process( &request );
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
                al_handlers.dataIndCallback( &indication );
                
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
                memset(process_buff, 0, MAX_DATA_LENGTH);
                
                config_data.cmon.value = config_data.lmon.value +1;                                     /* CMON for Decryption and Authentication */
                counter_block_generation(config_data.cmon.value);                                       
                indication.decryption_status = DecryptData_Comm(&indParams->lsdu[1], decrypt_length, process_buff, CRYPTO_SYM_OPMODE_CTR, keys.Write_Key, keys.Counter_block);
                
                /* writing data after decryption to meter_AL */
                memcpy(indication.app_data, process_buff, decrypt_length-16);                           /* Data */
                indication.app_dataLen = indParams->lsduLen-ENCRYPTED_MESSAGE_HEADER_LENGTH;            /* received data length */
                memcpy(received_time.data, &process_buff[decrypt_length-16], 8);                        /* POSIX timestamp */
                memcpy(cmac.Received_cmac, &process_buff[decrypt_length-8], 8);                         /* CMAC */
                
                if(received_time.value > request_time.value )                            
                {    
                    if(CRYPTO_SYM_CIPHER_SUCCESS == indication.decryption_status)
                    {
                        /* Calculating 32-bit CRC for CMAC generation */
                        memset(crc.buffer, 0, sizeof(crc.buffer));
                        memcpy(crc.buffer, config_data.ACA, 6);                             
                        crc.dataLen += 6;
                        memcpy(&crc.buffer[6], indication.app_data, (decrypt_length-16));           
                        crc.dataLen += decrypt_length-16;
                        crc.result = SRV_PCRC_GetValue(crc.buffer, crc.dataLen, PCRC_HT_USI, PCRC_CRC32, 1); /* CRC Calculation */  

                        memset(cmac.inputBuf, 0, sizeof(cmac.inputBuf));
                        cmac.inputBuf[0] = indParams->lsdu[0];                                          /* CM */
                        cmac.input_dataLen = 1;
                        memcpy(&cmac.inputBuf[1], config_data.ACA, 3);                                  /* ACA 3bytes(LSB) */ 
                        cmac.input_dataLen += 3;
                        memcpy(&cmac.inputBuf[4], config_data.cmon.buff, 8); 
                        cmac.input_dataLen += 8;
                        memcpy(&cmac.inputBuf[12], &crc.result, 4);                                     /* CRC(ACA,DATA) */
                        cmac.input_dataLen += 4;
                        memcpy(cmac.key, keys.Write_Key, 16);                                           /* Write KEY */

                        Cmac_status = Crypto_Mac_AesCmac_Direct(CRYPTO_HANDLER_SW_WOLFCRYPT, cmac.inputBuf, cmac.input_dataLen, cmac.Computed_cmac, AES_CMAC_LENGTH, cmac.key, KEY_LENGTH, 1);

                        if (Cmac_status == CRYPTO_MAC_CIPHER_SUCCESS)
                        {
                            if (memcmp(cmac.Computed_cmac, cmac.Received_cmac, AES_CMAC_LENGTH) == 0)
                            {
                                indication.authentication_status = 1;                                   /* CMAC verification successful */  
                                config_data.lmon.value = config_data.lmon.value +1;                     /* TO_DO updating LMON to CMON */ 
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
                
                al_handlers.dataIndCallback( &indication );
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
                memset(process_buff, 0, MAX_DATA_LENGTH);
                
                config_data.cmon.value = config_data.lmon.value+1;                                     /* CMON for Decryption and Authentication */
                counter_block_generation(config_data.cmon.value);
                indication.decryption_status = DecryptData_Comm(&indParams->lsdu[1], decrypt_length, process_buff, CRYPTO_SYM_OPMODE_CTR, keys.Read_Key, keys.Counter_block);
                
                /* writing data after decryption to meter_AL */
                memcpy(indication.app_data, process_buff, decrypt_length-16);                           /* Data */
                indication.app_dataLen = indParams->lsduLen-ENCRYPTED_MESSAGE_HEADER_LENGTH;            /* received data length */
                memcpy(received_time.data, &process_buff[decrypt_length-16], 8);                        /* POSIX timestamp */
                memcpy(cmac.Received_cmac, &process_buff[decrypt_length-8], 8);                         /* CMAC */
                
                if(received_time.value > request_time.value )                            
                {    
                    if(CRYPTO_SYM_CIPHER_SUCCESS == indication.decryption_status)
                    {
                        /* Calculating 32-bit CRC for CMAC generation */
                        memset(crc.buffer, 0, sizeof(crc.buffer));
                        memcpy(crc.buffer, config_data.ACA, 6);                             
                        crc.dataLen += 6;
                        memcpy(&crc.buffer[6], indication.app_data, (decrypt_length-16));           
                        crc.dataLen += decrypt_length-16;
                        crc.result = SRV_PCRC_GetValue(crc.buffer, crc.dataLen, PCRC_HT_USI, PCRC_CRC32, 1); /* CRC Calculation */  
                    
                        memset(cmac.inputBuf, 0, sizeof(cmac.inputBuf));
                        cmac.inputBuf[0] = indParams->lsdu[0];                                    /* CM */
                        cmac.input_dataLen = 1;
                        memcpy(&cmac.inputBuf[1], config_data.ACA, 3);                            /* ACA 3bytes(LSB) */ 
                        cmac.input_dataLen += 3;
                        memcpy(&cmac.inputBuf[4], config_data.cmon.buff, 8);                      /* CMON */
                        cmac.input_dataLen += 8;
                        memcpy(&cmac.inputBuf[12], &crc.result, 4);                               /* CRC(ACA,DATA) */
                        cmac.input_dataLen += 4;
                        memcpy(cmac.key, keys.Read_Key, 16);                                      /* TO_DO KEY */
                        
                        Cmac_status = Crypto_Mac_AesCmac_Direct(CRYPTO_HANDLER_SW_WOLFCRYPT, cmac.inputBuf, cmac.input_dataLen, cmac.Computed_cmac, AES_CMAC_LENGTH, cmac.key, KEY_LENGTH, 1);

                        if (Cmac_status == CRYPTO_MAC_CIPHER_SUCCESS)
                        {
                            if (memcmp(cmac.Computed_cmac, cmac.Received_cmac, AES_CMAC_LENGTH) == 0)
                            {
                                indication.authentication_status = 1;                             /* CMAC verification successful */  
                                config_data.lmon.value = config_data.lmon.value +1;               /* TO_DO updating LMON to CMON */ 
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
                al_handlers.dataIndCallback( &indication );
                break;
        }
    }
}

void AL_data_confirm_process( DLL_DATA_CONFIRM_PARAMS *cfmParams )
{
    AL_DATA_IND_PARAMS indication;
    
    if( config_data.config_device == AL_METER )
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
                    if ((AL_NWStatus.flags.ACA_Req_Address_Req_rcvd == 1U) && (AL_NWStatus.flags.ACA_Address_Req_Sent == 0U))
                    {
                        AL_NWStatus.flags.ACA_Address_Req_Sent = 1U;
                    }    
                        
                    if (AL_NWStatus.flags.ACA_ACK_sent == 1)
                    {
                        AL_NWStatus.flags.ACA_ACK_sent = 0;
                    }
                    if (AL_NWStatus.status_byte == 7)                                   /* Check all NW flags are set */ 
                    {
                        AL_NWStatus.status_byte = 0;
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
                        
                        al_handlers.dataIndCallback( &indication );
                    }
                    else if (cfmParams->dsap == DLL_DSAP_NETWORK_MANAGEMENT)
                    {    
                        if ( AL_NWStatus.status_byte )                                      /* Check all NW flags are set */ 
                        {
                            AL_NWStatus.status_byte = 0;
                        }    
                    }
                    retry_count = 0;
                }
                break;
        }
    }
    else if( config_data.config_device == AL_CONCENTRATOR )
    {
        switch(cfmParams->txStatus)
        {
            case DLL_TX_STATUS_SUCCESS:

                if (AL_Status.flags.DL_Confirm_rcvd == 0)
                {
                    AL_Status.flags.DL_Confirm_rcvd = 1;
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
                    al_handlers.dataIndCallback( &indication );
                    
                    retry_count = 0;
                }
                break;
        }
    }
}

void AL_data_event_process( DLL_EVENT_IND_PARAMS *eveParams )
{
    AL_DATA_EVENT_PARAMS event;
    
    memcpy(event.eventValue, eveParams->eventValue.value, 6);
    al_handlers.dataEventCallback( &event );
}

AL_RESULT AL_data_ind_CallbackRegister( AL_DATA_IND_CALLBACK callback )
{
    al_handlers.dataIndCallback = callback;
    return AL_SUCCESS;
}

AL_RESULT AL_data_event_CallbackRegister( AL_DATA_EVENT_CALLBACK callback )
{
    al_handlers.dataEventCallback = callback;
    return AL_SUCCESS;
}

SYS_MODULE_OBJ AL_Initialize ( const SYS_MODULE_INDEX index, const SYS_MODULE_INIT * const init )
{
    if ((index >= AL_INSTANCES_NUMBER) || (init == NULL))
    {
        return SYS_MODULE_OBJ_INVALID;
    }

    App_Data.status = SYS_STATUS_UNINITIALIZED;
    App_Data.state = AL_STATE_IDLE;

    memset(&al_handlers, 0, sizeof(al_handlers));

    DLL_DataIndicationCallbackRegister( AL_data_indication_process );
    DLL_DataConfirmCallbackRegister( AL_data_confirm_process );
    
    return (SYS_MODULE_OBJ)0;
}

void AL_HandlingTasks ( void )
{
    AL_DATA_REQ_PARAMS request;
    AL_DATA_EVENT_PARAMS event;
    
    uint8_t Index;
    
    if( config_data.config_device == AL_METER )
    {
        /* REQ_ADDRESS_REQ received, ADDRESS_REQ sent to B nodes. REQ_ADDRESS_RESP will be sent when it receives 4 responses or after timeout */
        if (((AL_NWStatus.status_byte & 0x07) == 0x03) && (SYS_TIME_Counter64Get() > nextwaitCount ))
        {
            if(ACA_req_resp_count != 0U)
            {
                memset(process_buff, 0, MAX_DATA_LENGTH);
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

                AL_data_request_process( &request );

                AL_NWStatus.flags.ACA_Req_Address_Resp_sent = 1;
            } 
        }    
    }   
    else if( config_data.config_device == AL_CONCENTRATOR )
    {   
        /* Request & Confirm are set and Indication received, clear flags */
        if ((AL_Status.status_byte & 0x07) == 0x07)
        {
            AL_Status.status_byte = 0;
        } 
        
        /* Request & Confirm are set, Indication not received, Generating Event at CCU End after timeout */
        if ((SYS_TIME_Counter64Get() > nextwaitCount ) && ((AL_Status.status_byte & 0x07) == 0x03))
        {    
            memset(&event, 0, sizeof(AL_DATA_EVENT_PARAMS));
            memcpy(event.eventValue, config_data.ACA, 6);
            
            al_handlers.dataEventCallback( &event );
            AL_Status.flags.DL_Event_sent = 1;
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

    if ((SYS_TIME_Counter64Get() < nextTaskTimeCount))
    {
        return;
    }
    nextTaskTimeCount = SYS_TIME_Counter64Get() + SYS_TIME_MSToCount(taskRateCount);

    switch (App_Data.state)
    {
        case AL_STATE_IDLE:
            if (App_Data.status == SYS_STATUS_UNINITIALIZED)
            {
                if (configparams_rcvd == 1U)
                {
                   App_Data.status = SYS_STATUS_READY;
                   App_Data.state = AL_STATE_APP_PROCESS;
                }
            }
            break;

        case AL_STATE_APP_PROCESS: 
            
            if( App_Data.status == SYS_STATUS_READY )
            {
                AL_HandlingTasks();
                
            }    
            break;

        default:
            break;
    }
}
/* *****************************************************************************
 End of File
 */
