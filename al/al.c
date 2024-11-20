/* ************************************************************************** */

#include <string.h>
#include "stack/metersandmore/dll/dll.h"
#include "al_local.h"
#include "crypto/common_crypto/MCHP_Crypto_Mac_Cipher.h"
#include "crypto/common_crypto/MCHP_Crypto_Sym_Cipher.h"

// *****************************************************************************
// *****************************************************************************
// Section: File Scope Data
// *****************************************************************************
// *****************************************************************************

/* Table used to get CRC32 value */
static const uint32_t crcTable32[256] = {
    0x00000000, 0x77073096, 0xee0e612c, 0x990951ba, 0x076dc419, 0x706af48f,
    0xe963a535, 0x9e6495a3,	0x0edb8832, 0x79dcb8a4, 0xe0d5e91e, 0x97d2d988,
    0x09b64c2b, 0x7eb17cbd, 0xe7b82d07, 0x90bf1d91, 0x1db71064, 0x6ab020f2,
    0xf3b97148, 0x84be41de,	0x1adad47d, 0x6ddde4eb, 0xf4d4b551, 0x83d385c7,
    0x136c9856, 0x646ba8c0, 0xfd62f97a, 0x8a65c9ec,	0x14015c4f, 0x63066cd9,
    0xfa0f3d63, 0x8d080df5,	0x3b6e20c8, 0x4c69105e, 0xd56041e4, 0xa2677172,
    0x3c03e4d1, 0x4b04d447, 0xd20d85fd, 0xa50ab56b,	0x35b5a8fa, 0x42b2986c,
    0xdbbbc9d6, 0xacbcf940,	0x32d86ce3, 0x45df5c75, 0xdcd60dcf, 0xabd13d59,
    0x26d930ac, 0x51de003a, 0xc8d75180, 0xbfd06116, 0x21b4f4b5, 0x56b3c423,
    0xcfba9599, 0xb8bda50f, 0x2802b89e, 0x5f058808, 0xc60cd9b2, 0xb10be924,
    0x2f6f7c87, 0x58684c11, 0xc1611dab, 0xb6662d3d,	0x76dc4190, 0x01db7106,
    0x98d220bc, 0xefd5102a, 0x71b18589, 0x06b6b51f, 0x9fbfe4a5, 0xe8b8d433,
    0x7807c9a2, 0x0f00f934, 0x9609a88e, 0xe10e9818, 0x7f6a0dbb, 0x086d3d2d,
    0x91646c97, 0xe6635c01, 0x6b6b51f4, 0x1c6c6162, 0x856530d8, 0xf262004e,
    0x6c0695ed, 0x1b01a57b, 0x8208f4c1, 0xf50fc457, 0x65b0d9c6, 0x12b7e950,
    0x8bbeb8ea, 0xfcb9887c, 0x62dd1ddf, 0x15da2d49, 0x8cd37cf3, 0xfbd44c65,
    0x4db26158, 0x3ab551ce, 0xa3bc0074, 0xd4bb30e2, 0x4adfa541, 0x3dd895d7,
    0xa4d1c46d, 0xd3d6f4fb, 0x4369e96a, 0x346ed9fc, 0xad678846, 0xda60b8d0,
    0x44042d73, 0x33031de5, 0xaa0a4c5f, 0xdd0d7cc9, 0x5005713c, 0x270241aa,
    0xbe0b1010, 0xc90c2086, 0x5768b525, 0x206f85b3, 0xb966d409, 0xce61e49f,
    0x5edef90e, 0x29d9c998, 0xb0d09822, 0xc7d7a8b4, 0x59b33d17, 0x2eb40d81,
    0xb7bd5c3b, 0xc0ba6cad, 0xedb88320, 0x9abfb3b6, 0x03b6e20c, 0x74b1d29a,
    0xead54739, 0x9dd277af, 0x04db2615, 0x73dc1683, 0xe3630b12, 0x94643b84,
    0x0d6d6a3e, 0x7a6a5aa8, 0xe40ecf0b, 0x9309ff9d, 0x0a00ae27, 0x7d079eb1,
    0xf00f9344, 0x8708a3d2, 0x1e01f268, 0x6906c2fe, 0xf762575d, 0x806567cb,
    0x196c3671, 0x6e6b06e7, 0xfed41b76, 0x89d32be0, 0x10da7a5a, 0x67dd4acc,
    0xf9b9df6f, 0x8ebeeff9, 0x17b7be43, 0x60b08ed5, 0xd6d6a3e8, 0xa1d1937e,
    0x38d8c2c4, 0x4fdff252, 0xd1bb67f1, 0xa6bc5767, 0x3fb506dd, 0x48b2364b,
    0xd80d2bda, 0xaf0a1b4c, 0x36034af6, 0x41047a60, 0xdf60efc3, 0xa867df55,
    0x316e8eef, 0x4669be79, 0xcb61b38c, 0xbc66831a, 0x256fd2a0, 0x5268e236,
    0xcc0c7795, 0xbb0b4703, 0x220216b9, 0x5505262f, 0xc5ba3bbe, 0xb2bd0b28,
    0x2bb45a92, 0x5cb36a04, 0xc2d7ffa7, 0xb5d0cf31, 0x2cd99e8b, 0x5bdeae1d,
    0x9b64c2b0, 0xec63f226, 0x756aa39c, 0x026d930a, 0x9c0906a9, 0xeb0e363f,
    0x72076785, 0x05005713, 0x95bf4a82, 0xe2b87a14, 0x7bb12bae, 0x0cb61b38,
    0x92d28e9b, 0xe5d5be0d, 0x7cdcefb7, 0x0bdbdf21, 0x86d3d2d4, 0xf1d4e242,
    0x68ddb3f8, 0x1fda836e, 0x81be16cd, 0xf6b9265b, 0x6fb077e1, 0x18b74777,
    0x88085ae6, 0xff0f6a70, 0x66063bca, 0x11010b5c, 0x8f659eff, 0xf862ae69,
    0x616bffd3, 0x166ccf45, 0xa00ae278, 0xd70dd2ee, 0x4e048354, 0x3903b3c2,
    0xa7672661, 0xd06016f7, 0x4969474d, 0x3e6e77db, 0xaed16a4a, 0xd9d65adc,
    0x40df0b66, 0x37d83bf0, 0xa9bcae53, 0xdebb9ec5, 0x47b2cf7f, 0x30b5ffe9,
    0xbdbdf21c, 0xcabac28a, 0x53b39330, 0x24b4a3a6, 0xbad03605, 0xcdd70693,
    0x54de5729, 0x23d967bf, 0xb3667a2e, 0xc4614ab8, 0x5d681b02, 0x2a6f2b94,
    0xb40bbe37, 0xc30c8ea1, 0x5a05df1b, 0x2d02ef8d
};

static uint8_t alDllTxBuf[MAX_LENGTH_432_DATA];
static uint8_t alDllLastRxBuff[MAX_LENGTH_432_DATA]; /* Only for Meter */
static uint8_t alReqAddrRespBuf[AL_NM_REQADDR_RESP_MAX_LEN];
static AL_DATA alData;

// *****************************************************************************
// *****************************************************************************
// Section: File Scope Functions
// *****************************************************************************
// *****************************************************************************

static void lAL_TxTimeoutCallback(uintptr_t context)
{
    (void)context;
    alData.txTimeoutExpired = true;
}

static inline bool lAL_MsgAttrIsAuth(AL_MSG_ATTR attr)
{
    /* Check whether message is authenticated */
    return ((attr >= AL_MSG_READ_REQ_AUTH) && (attr <= AL_MSG_NACK_RESP) && (attr != AL_MSG_CHALLENGE_REQ));
}

static uint8_t * lAL_GetKeyFromEcc(DLL_ECC ecc)
{
    uint8_t *key = NULL;

    /* b2 indicates Read or Write Key */
    if ((((uint8_t) ecc) & 0x04U) == 0U)
    {
        /* Read Key */
        if (true == alData.keyReadValid)
        {
            key = alData.keyRead;
        }
    }
    else
    {
        /* Write Key */
        if (true == alData.keyWriteValid)
        {
            key = alData.keyWrite;
        }
    }

    return key;
}

static inline crypto_Sym_OpModes_E lAL_GetAesModeFromEcc(DLL_ECC ecc)
{
    uint8_t b1b0 = ((uint8_t) ecc) & 0x03U;
    DLL_ECC b1b0Ecc = (DLL_ECC) b1b0;

    if (DLL_ECC_AES_CTR_READ_KEY == b1b0Ecc)
    {
        return CRYPTO_SYM_OPMODE_CTR;
    }

    if (DLL_ECC_AES_ECB_READ_KEY == b1b0Ecc)
    {
        return CRYPTO_SYM_OPMODE_ECB;
    }

    return CRYPTO_SYM_OPMODE_INVALID;
}

static uint32_t getCRC32(uint8_t *inputBuf, uint8_t bufLen, uint32_t crcInitValue)
{
    uint32_t crc;
    uint8_t i;
    
    crc = crcInitValue;
    
    for (i = 0; i < bufLen; i++)
    {
        crc = crcTable32[(crc ^ inputBuf[i]) & 0xFF] ^ (crc >> 8);
    }
    
    return crc;
}

static inline uint32_t lAL_CmacCrc(AL_MSG_ATTR attr, uint8_t *aca, uint8_t *apdu, uint16_t apduLen)
{
    uint32_t crc = 0xFFFFFFFF;
    uint32_t crcRet;

    /* CRC(ACA) */
    crc = getCRC32(aca, MAC_ADDRESS_SIZE, crc);

    if ((AL_MSG_NACK_A_NODE_AUTH == attr) || (AL_MSG_NACK_B_NODE_AUTH == attr))
    {
        /* CRC(PAR1) */
        crc = getCRC32(apdu, 1, crc);
    }

    switch(attr)
    {
        case AL_MSG_CHALLENGE_RESP:
            /* CRC(ACA, N) */
            crc = getCRC32(alData.chlReqRandomN, AL_CHL_REQ_RANDOM_N_LEN, crc);
            break;

        case AL_MSG_NACK_A_NODE_AUTH:
        case AL_MSG_NACK_B_NODE_AUTH:
            /* CRC(ACA, PAR1, Etm*) */
            crc = getCRC32(alData.nackCrcEtmField, AL_NACK_AUTH_ETM_LEN, crc);
            break;

        default:
            /* CRC(ACA, DATA) */
            crc = getCRC32(apdu, apduLen, crc);
            break;
    }
    
    crc = crc ^ 0xFFFFFFFF;
    
    crcRet = ((crc & 0xFF000000) >> 24) + 
            ((crc & 0x00FF0000) >> 8) + 
            ((crc & 0x0000FF00) << 8) + 
            ((crc & 0x000000FF) << 24);

    return crcRet;
}

static crypto_Mac_Status_E lAL_CMacDigest(uint8_t *apdu, uint16_t apduLen, uint8_t *key, uint8_t *tmac, uint64_t mon, AL_MSG_ATTR attr)
{
    uint32_t crc;
    crypto_Mac_Status_E cmacStatus;
    uint8_t cmacOutput[AL_CMAC_OUTPUT_LEN];
    uint8_t cmacInput[AL_CMAC_INPUT_LEN];
    uint8_t *aca;
    uint8_t *cmacInputPtr = cmacInput;

    if (true == alData.isMaster)
    {
        aca = alData.acaDestination.address;
    }
    else
    {
        aca = alData.acaOwn.address;
    }

    /* AES-CMAC input: [ATTR, ACA(first 3 bytes), LMON/CMON, CRC] */
    *cmacInputPtr++ = (uint8_t) attr;
    (void) memcpy(cmacInputPtr, aca, 3);
    cmacInputPtr += 3;
    *cmacInputPtr++ = (uint8_t) (mon >> 56);
    *cmacInputPtr++ = (uint8_t) (mon >> 48);
    *cmacInputPtr++ = (uint8_t) (mon >> 40);
    *cmacInputPtr++ = (uint8_t) (mon >> 32);
    *cmacInputPtr++ = (uint8_t) (mon >> 24);
    *cmacInputPtr++ = (uint8_t) (mon >> 16);
    *cmacInputPtr++ = (uint8_t) (mon >> 8);
    *cmacInputPtr++ = (uint8_t) mon;
    crc = lAL_CmacCrc(attr, aca, apdu, apduLen);
    (void) memcpy(cmacInputPtr, (uint8_t*)&crc, 4);

    /* Compute AES-CMAC */
    cmacStatus = Crypto_Mac_AesCmac_Direct(CRYPTO_HANDLER_SW_WOLFCRYPT, cmacInput, AL_CMAC_INPUT_LEN, cmacOutput, AL_CMAC_OUTPUT_LEN, key, AL_KEY_LENGTH, 1);

    /* Truncate to first 8 bytes */
    (void) memcpy(tmac, cmacOutput, AL_TMAC_LENGTH);

    return cmacStatus;
}

static crypto_Sym_OpModes_E lAL_EncryptDecrypt(DLL_ECC ecc, uint64_t mon, uint8_t **iv)
{
    crypto_Sym_OpModes_E aesMode;

    /* Get AES Mode depending on ECC */
    aesMode = lAL_GetAesModeFromEcc(ecc);
    if (CRYPTO_SYM_OPMODE_CTR == aesMode)
    {
        uint8_t *aca;
        uint8_t *ivPtr = *iv;

        if (true == alData.isMaster)
        {
            aca = alData.acaDestination.address;
        }
        else
        {
            aca = alData.acaOwn.address;
        }

        /* Build Initialization Vector (IV): [ACA, LMON/CMON, 1] (Big Endian. To Do: Review ACA endianess) */
        (void) memcpy(ivPtr, aca, MAC_ADDRESS_SIZE);
        ivPtr += MAC_ADDRESS_SIZE;
        *ivPtr++ = (uint8_t) (mon >> 56);
        *ivPtr++ = (uint8_t) (mon >> 48);
        *ivPtr++ = (uint8_t) (mon >> 40);
        *ivPtr++ = (uint8_t) (mon >> 32);
        *ivPtr++ = (uint8_t) (mon >> 24);
        *ivPtr++ = (uint8_t) (mon >> 16);
        *ivPtr++ = (uint8_t) (mon >> 8);
        *ivPtr++ = (uint8_t) mon;
        *ivPtr++ = 0;
        *ivPtr = 1;
    }
    else
    {
        /* Initialization Vector (IV) not used */
        *iv = NULL;
    }

    return aesMode;
}

static inline AL_TX_STATUS lAL_Encrypt(uint8_t *inputOutput, uint16_t len, uint8_t *key, DLL_ECC ecc, uint64_t mon)
{
    uint8_t iv[AL_CMAC_OUTPUT_LEN];
    crypto_Sym_OpModes_E aesMode;
    crypto_Sym_Status_E aesResult;
    uint8_t *ivPtr = iv;

    /* Get AES Mode depending on ECC and fill Initialization Vector (IV) for AES-CTR */
    aesMode = lAL_EncryptDecrypt(ecc, mon, &ivPtr);
    if (CRYPTO_SYM_OPMODE_INVALID == aesMode)
    {
        /* Message not encrypted */
        return AL_TX_STATUS_SUCCESS;
    }

    if (NULL == key)
    {
        /* No Key configured to encrypt the message */
        return AL_TX_STATUS_ERROR_AES_NO_KEY;
    }

    aesResult = Crypto_Sym_Aes_EncryptDirect(CRYPTO_HANDLER_SW_WOLFCRYPT, aesMode, inputOutput, len, inputOutput, key, AL_KEY_LENGTH, ivPtr, 1);
    if (aesResult != CRYPTO_SYM_CIPHER_SUCCESS)
    {
        return AL_TX_STATUS_ERROR_AES_ENCRYPT;
    }

    return AL_TX_STATUS_SUCCESS;
}

static inline AL_RX_STATUS lAL_Decrypt(uint8_t *inputOutput, uint16_t len, uint8_t *key, DLL_ECC ecc, uint64_t mon)
{
    uint8_t iv[16];
    crypto_Sym_OpModes_E aesMode;
    crypto_Sym_Status_E aesResult;
    uint8_t *ivPtr = iv;

    /* Get AES Mode depending on ECC and fill Initialization Vector (IV) for AES-CTR */
    aesMode = lAL_EncryptDecrypt(ecc, mon, &ivPtr);
    if (CRYPTO_SYM_OPMODE_INVALID == aesMode)
    {
        /* Message not encrypted */
        return AL_RX_STATUS_SUCCESS;
    }

    if (NULL == key)
    {
        return AL_RX_STATUS_ERROR_AES_NO_KEY;
    }

    aesResult = Crypto_Sym_Aes_DecryptDirect(CRYPTO_HANDLER_SW_WOLFCRYPT, aesMode, inputOutput, len, inputOutput, key, AL_KEY_LENGTH, ivPtr, 1);
    if (aesResult != CRYPTO_SYM_CIPHER_SUCCESS)
    {
        return AL_RX_STATUS_ERROR_AES_DECRYPT;
    }

    return AL_RX_STATUS_SUCCESS;
}

static void lAL_NetworkManagementQualityParams(uint8_t *dest)
{
    DLL_IB_VALUE getValue;
    DLL_RESULT getResult;

    /* Av_SIG: Signal Level */
    getResult = DLL_GetRequest(MAC_LAST_RX_SIGNAL_LEVEL_IB, 0, &getValue);
    if (DLL_SUCCESS == getResult)
    {
        *dest++ = getValue.value[0];
    }
    else
    {
        *dest++ = 0xFF;
    }

    /* Av_SNR */
    getResult = DLL_GetRequest(MAC_LAST_RX_SNR_IB, 0, &getValue);
    if (DLL_SUCCESS == getResult)
    {
        *dest++ = getValue.value[0];
    }
    else
    {
        *dest++ = 0xFF;
    }

    /* Av_TX: Impedance */
    getResult = DLL_GetRequest(MAC_ESTIMATED_IMPDEDANCE_IB, 0, &getValue);
    if (DLL_SUCCESS == getResult)
    {
        *dest++ = getValue.value[0];
    }
    else
    {
        *dest++ = 0xFF;
    }
}

static void lAL_DllDataIndication(DLL_DATA_IND_PARAMS *indParams)
{
    uint64_t mon;
    uint8_t *key;
    bool authMsg;
    AL_DATA_IND_CALLBACK dataIndCallback;
    uint64_t datetime = 0;
    uint8_t *apdu = NULL;
    uint16_t apduLen = 0;
    AL_RX_STATUS rxStatus = AL_RX_STATUS_SUCCESS;
    AL_MSG_ATTR attr = (AL_MSG_ATTR) indParams->lsdu[0];

    if (false == alData.multiresponse)
    {
        /* Stop Tx Timeout */
        SYS_TIME_TimerDestroy(alData.txTimeoutHandle);
        alData.txTimeoutHandle = SYS_TIME_HANDLE_INVALID;
        alData.state = AL_STATE_IDLE;
    }

    /* Use CMON = LMON + 1 */
    mon = alData.lmon + 1ULL;

    /* Check whether message is authenticated */
    authMsg = lAL_MsgAttrIsAuth(attr);

    /* Get Read or Write key depending on ECC */
    key = lAL_GetKeyFromEcc(indParams->ecc);

    if (indParams->lsduLen > 0U)
    {
        uint8_t *decryptInputOutput;
        uint16_t decryptLen;

        if (false == alData.isMaster)
        {
            if (true == authMsg)
            {
                /* Compare with last received LSDU */
                if ((true == alData.responseProtectedValid) && (indParams->lsduLen == alData.lastlRxLsduLen) &&
                        (memcmp(indParams->lsdu, alDllLastRxBuff, indParams->lsduLen) == 0U))
                {
                    /* This is a repetition. Repeat response without indicating to upper layer */
                    /* Otherwise there would be LMON misalignment in between DCU and Meter */
                    alData.state = AL_STATE_WAITING_TX_CFM;
                    DLL_DataRequest(&alData.dllDataReqParams);
                    return;
                }

                if (indParams->lsduLen >= AL_NACK_AUTH_ETM_LEN)
                {
                    /* Update Etm* field for CRC calculation in authenticated NACK messages */
                    (void) memcpy(alData.nackCrcEtmField, &indParams->lsdu[indParams->lsduLen - AL_NACK_AUTH_ETM_LEN], AL_NACK_AUTH_ETM_LEN);
                }
            }

            /* Store LSDU to detect repetitions */
            (void) memcpy(alDllLastRxBuff, indParams->lsdu, indParams->lsduLen);
            alData.lastlRxLsduLen = indParams->lsduLen;
            alData.responseProtectedValid = false;

            /* Store address and ECC for Data Confirm (METER ONLY) */
            alData.lastRxAddress = indParams->srcAddress;
            alData.eccReceived = indParams->ecc;
        }

        apdu = &indParams->lsdu[1];
        apduLen = indParams->lsduLen - 1U;
        decryptInputOutput = apdu;
        decryptLen = apduLen;

        switch (attr)
        {
            case AL_MSG_CHALLENGE_RESP:
                /* T field (2 bytes) is not encrypted */
                decryptInputOutput += 2;
                if (decryptLen >= 2U)
                {
                    decryptLen -= 2U;
                }
                else
                {
                    decryptLen = 0U;
                }
                break;

            case AL_MSG_NACK_A_NODE_AUTH:
            case AL_MSG_NACK_B_NODE_AUTH:
                /* PAR1 Error Code field (1 byte) is not encrypted */
                decryptInputOutput += 1;
                if (decryptLen >= 1U)
                {
                    decryptLen -= 1U;
                }
                else
                {
                    decryptLen = 0U;
                }
                break;

            default:
                break;
        }

        /* Decrypt data if needed */
        if (decryptLen > 0U)
        {
            rxStatus = lAL_Decrypt(decryptInputOutput, decryptLen, key, indParams->ecc, mon);
        }
    }
    else
    {
        rxStatus = AL_RX_STATUS_ERROR_BAD_LEN;
    }

    if ((AL_RX_STATUS_SUCCESS == rxStatus) && (true == authMsg))
    {
        if (apduLen >= (AL_TMAC_LENGTH + AL_DATETIME_LENGTH))
        {
            crypto_Mac_Status_E cmacStatus;
            uint8_t tmac[AL_TMAC_LENGTH];
            uint64_t datetimeLmon;
            uint8_t *datetimeLmonBuff = &apdu[apduLen - AL_TMAC_LENGTH - AL_DATETIME_LENGTH];

            /* In Authenticated messages, 8 bytes are added for DATE-TIME or LMON */
            datetimeLmon = (uint64_t) *datetimeLmonBuff++;
            datetimeLmon += ((uint64_t) *datetimeLmonBuff++) << 8;
            datetimeLmon += ((uint64_t) *datetimeLmonBuff++) << 16;
            datetimeLmon += ((uint64_t) *datetimeLmonBuff++) << 24;
            datetimeLmon += ((uint64_t) *datetimeLmonBuff++) << 32;
            datetimeLmon += ((uint64_t) *datetimeLmonBuff++) << 40;
            datetimeLmon += ((uint64_t) *datetimeLmonBuff++) << 48;
            datetimeLmon += ((uint64_t) *datetimeLmonBuff++) << 56;

            if ((AL_MSG_CHALLENGE_RESP == attr) ||
                (((AL_MSG_NACK_A_NODE_AUTH == attr) || (AL_MSG_NACK_B_NODE_AUTH == attr)) && (AL_NACK_AUTH_PAYLOAD == apdu[0])))
            {
                /* CHL.REQ and NACK Authenticated (Error Code 10) use LMON instead of DATE-TIME */
                mon = datetimeLmon;
            }
            else
            {
                datetime = datetimeLmon;
            }

            /* Compute truncated AES-CMAC (TMAC) */
            apduLen -= AL_TMAC_LENGTH;
            cmacStatus = lAL_CMacDigest(apdu, apduLen, key, tmac, mon, attr);

            if (CRYPTO_MAC_CIPHER_SUCCESS == cmacStatus)
            {
                if (memcmp(tmac, &apdu[apduLen], AL_TMAC_LENGTH) != 0U)
                {
                    rxStatus = AL_RX_STATUS_ERROR_BAD_TMAC;
                }
                else
                {
                    /* Correct authentication */
                    if (false == alData.isMaster)
                    {
                        /* Meter: Update LMON with CMON (LMON + 1) */
                        alData.lmon += 1U;
                    }
                }
            }
            else
            {
                rxStatus = AL_RX_STATUS_ERROR_AES_CMAC;
            }

            /* Remove datetime from apdu after CMAC computation */
            apduLen -= AL_DATETIME_LENGTH;
        }
        else
        {
            rxStatus = AL_RX_STATUS_ERROR_BAD_LEN;
        }
    }

    dataIndCallback = alData.dataIndCallback;
    if (false == alData.isMaster)
    {
        AL_DATA_REQUEST_PARAMS request;
        uint8_t apduResp[AL_NM_ADDRESS_RESP_LEN];
        request.apduLen = 0;

        /* Check if we need to respond or process the message */
        if ((AL_RX_STATUS_ERROR_BAD_TMAC == rxStatus) || (AL_RX_STATUS_ERROR_BAD_LEN == rxStatus))
        {
            /* Send Authenticated NACK with error code 10, containing LMON */
            /* Data Indication is still sent to upper layer */
            apduResp[0] = AL_NACK_AUTH_PAYLOAD;
            request.apduLen = 1;
            request.attr = AL_MSG_NACK_A_NODE_AUTH;
        }
        else if ((AL_MSG_CHALLENGE_REQ == attr) && (AL_CHL_REQ_LEN == apduLen))
        {
            /* Update Random Number N for CHL.RESP authentication */
            (void) memcpy(alData.chlReqRandomN, &apdu[2], AL_CHL_REQ_RANDOM_N_LEN);

            /* Send CHL.RESP message, containing LMON */
            apduResp[0] = 0;
            apduResp[1] = 0;
            request.apduLen = 2;
            request.attr = AL_MSG_CHALLENGE_RESP;
            dataIndCallback = NULL; /* Data Indication not sent to upper layer */
        }
        else
        {
            if (DLL_DSAP_NETWORK_MANAGEMENT == indParams->dsap)
            {
                /* Process Network Management message */
                switch (attr)
                {
                    case AL_MSG_ADDRESS_REQ:
                        
                        if (AL_NM_ADDRESS_REQ_LEN == apduLen)
                        {
                            DLL_IB_VALUE getValue;
                            bool sendResp = true;
                            dataIndCallback = NULL; /* Data Indication not sent to upper layer */

                            /* Check Phase/any */
                            if (1U == apdu[0])
                            {
                                /* In Phase: Send response only if we are in phase with the transmitter */
                                (void) DLL_GetRequest(MAC_LAST_RX_IN_PHASE_IB, 0, &getValue);
                                if (0U == getValue.value[0])
                                {
                                    sendResp = false;
                                }
                            }

                            if (true == sendResp)
                            {
                                /* Check TCR (respond only if TCT >= TCR) */
                                if (alData.tct < apdu[1])
                                {
                                    sendResp = false;
                                }
                            }

                            if (true == sendResp)
                            {
                                uint8_t acaLSB;
                                uint8_t rightShiftAdd;
                                uint8_t mask;

                                /* Check address filtering */
                                /* Respond if the remainder of ((ACA[LSB] + AddToAddress) >> RightShiftAdd) is 0 */
                                acaLSB = alData.acaOwn.address[0];
                                acaLSB += apdu[2];
                                rightShiftAdd = apdu[3];
                                mask = (1U << rightShiftAdd) - 1U;
                                if ((acaLSB & mask) == 0U)
                                {
                                    /* All filters passed. Send ADDRESS.RESP */
                                    request.apduLen = AL_NM_ADDRESS_RESP_LEN;
                                    request.attr = AL_MSG_ADDRESS_RESP;
                                    (void) memcpy(apduResp, alData.acaOwn.address, MAC_ADDRESS_SIZE);
                                    lAL_NetworkManagementQualityParams(&apduResp[6]);
                                    apduResp[9] = 0xFF;
                                    apduResp[10] = 0xFF;
                                    apduResp[11] = 0xFF;
                                }
                            }
                        }
                        break;

                    case AL_MSG_ADDRESS_RESP:
                        if ((AL_STATE_WAITING_RX == alData.state) && (AL_NM_ADDRESS_RESP_LEN == apduLen))
                        {
                            uint8_t numNodes = alReqAddrRespBuf[0];
                            dataIndCallback = NULL; /* Data Indication not sent to upper layer */
                            if (numNodes < AL_NM_REQADDR_RESP_MAX_NODES)
                            {
                                /* Update number of found nodes and insert data in REQADDR.RESP */
                                alReqAddrRespBuf[0] += 1U;
                                (void) memcpy(&alReqAddrRespBuf[1U + (numNodes * AL_NM_ADDRESS_RESP_LEN)], apdu, AL_NM_ADDRESS_RESP_LEN);
                            }
                        }
                        break;

                    case AL_MSG_TCT_SET_REQ:
                        /* NACK.RESP has to be sent always */
                        request.apduLen = AL_NM_NACK_REQ_LEN;
                        request.attr = AL_MSG_NACK_RESP;
                        lAL_NetworkManagementQualityParams(&apdu[1]);
                        dataIndCallback = NULL; /* Data Indication not sent to upper layer */
                        if ((AL_NM_TCT_SET_REQ_LEN == apduLen) && (apdu[0] > 0U))
                        {
                            /* Update TCT and send ACK (NACK with Error Code 0) */
                            alData.tct = apdu[0];
                            apduResp[0] = 0;
                        }
                        else
                        {
                            /* Send NACK */
                            apduResp[0] = 1;
                        }
                        break;

                    case AL_MSG_REQADDR_REQ:
                        dataIndCallback = NULL; /* Data Indication not sent to upper layer */
                        if (AL_NM_ADDRESS_REQ_LEN == apduLen)
                        {
                            /* Send ADDRESS.REQ with parameters from REQADDR.REQ and wait for responses */
                            (void) memcpy(apduResp, apdu, AL_NM_ADDRESS_REQ_LEN);
                            request.apduLen = AL_NM_ADDRESS_REQ_LEN;
                            request.attr = AL_MSG_ADDRESS_REQ;
                            alReqAddrRespBuf[0] = 0; /* Initialize number of found nodes */
                        }
                        break;

                    default:
                        break;
                }
            }
        }

        if (request.apduLen > 0U)
        {
            /* Send response */
            request.apdu = apduResp;
            request.dsap = indParams->dsap;
            if (request.attr == AL_MSG_NACK_A_NODE_AUTH)
            {
                /* Set AES mode to ECB */
                request.ecc = DLL_ECC_AES_ECB_READ_KEY;
            }
            else
            {
                /* Use AES mode from Indication */
                request.ecc = indParams->ecc;
            }
            alData.alDataReqInternal = true;
            AL_DataRequest(&request);
        }
    }
    else {
        /* Master Node */
        /* If waiting multiresponse, any response cancels the Event Indication to upper layer */
        if (alData.multiresponse == true)
        {
            /* Swith to Waiting Timeout instead of Waiting RX */
            alData.state = AL_STATE_WAITING_TIMEOUT;
        }
    }

    if (dataIndCallback != NULL)
    {
        AL_DATA_IND_PARAMS indication;
        indication.datetime = datetime;
        indication.lmon = mon;
        indication.apdu = apdu;
        indication.apduLen = apduLen;
        indication.srcAddress = indParams->srcAddress;
        indication.attr = attr;
        indication.dsap = indParams->dsap;
        indication.ecc = indParams->ecc;
        indication.rxStatus = rxStatus;
        dataIndCallback(&indication);
    }
}

static void lAL_DllDataConfirm(DLL_DATA_CONFIRM_PARAMS *cfmParams)
{
    AL_DATA_CONFIRM_PARAMS confirm;

    if (alData.state != AL_STATE_WAITING_TX_CFM)
    {
        /* Confirm not expected */
        return;
    }

    if (cfmParams->txStatus != DLL_TX_STATUS_SUCCESS)
    {
        /* Tx Error */
        SYS_TIME_TimerDestroy(alData.txTimeoutHandle);
        alData.txTimeoutHandle = SYS_TIME_HANDLE_INVALID;
        if (alData.txRetryCount < alData.txRetryLimit)
        {
            /* Try again */
            alData.txRetryCount++;
            DLL_DataRequest(&alData.dllDataReqParams);

            /* DCU always sets a Tx Timeout. Meter only sets Tx Timeout for ADDRESS.REQ message */
            if ((true == alData.isMaster) || (true == alData.multiresponse))
            {

                alData.txTimeoutExpired = false;
                alData.txTimeoutHandle = SYS_TIME_CallbackRegisterUS(lAL_TxTimeoutCallback, 0, DLL_GetTxTimeout(), SYS_TIME_SINGLE);
            }
            return;
        }
        else
        {
            confirm.txStatus = AL_TX_STATUS_ERROR_RETRY_LIMIT;
            alData.state = AL_STATE_IDLE;
        }
    }
    else
    {
        confirm.txStatus = AL_TX_STATUS_SUCCESS;
        if (alData.txTimeoutHandle != SYS_TIME_HANDLE_INVALID)
        {
            /* If frame expects response, go to wait RX. Otherwise, wait timeout ends */
            if (alData.dllDataReqParams.serviceClass != SERVICE_CLASS_S)
            {
                alData.state = AL_STATE_WAITING_RX;
            }
            else
            {
                alData.state = AL_STATE_WAITING_TIMEOUT;
            }
        }
        else
        {
            alData.state = AL_STATE_IDLE;
        }

        if (true == alData.isMaster)
        {
            AL_MSG_ATTR attr = (AL_MSG_ATTR) alDllTxBuf[0];
            if ((lAL_MsgAttrIsAuth(attr) == true) && (alData.dllDataReqParams.lsduLen >= AL_NACK_AUTH_ETM_LEN))
            {
                /* Update Etm* field for CRC calculation in authenticated NACK messages */
                (void) memcpy(alData.nackCrcEtmField, &alDllTxBuf[alData.dllDataReqParams.lsduLen - AL_NACK_AUTH_ETM_LEN], AL_NACK_AUTH_ETM_LEN);
            }

            if (AL_MSG_CHALLENGE_REQ == attr)
            {
                /* Update Random Number N for CHL.RESP authentication */
                (void) memcpy(alData.chlReqRandomN, &alDllTxBuf[3], AL_CHL_REQ_RANDOM_N_LEN);
            }
        }
    }

    if (true == alData.sendDataCfm)
    {
        /* Send Confirm */
        alData.sendDataCfm = false;
        if (alData.dataCfmCallback != NULL)
        {
            confirm.dsap = cfmParams->dsap;
            confirm.ecc = cfmParams->ecc;
            confirm.dstAddress = cfmParams->dstAddress;
            alData.dataCfmCallback(&confirm);
        }
    }
}

void lAL_DllEventIndication(DLL_EVENT_IND_PARAMS *evParams)
{
    if (MAC_EVENT_ID_ACA == evParams->eventId)
    {
        SYS_TIME_TimerDestroy(alData.txTimeoutHandle);
        alData.txTimeoutHandle = SYS_TIME_HANDLE_INVALID;
        alData.state = AL_STATE_IDLE;
    }

    if (alData.eventIndCallback != NULL)
    {
        AL_EVENT_IND_PARAMS event;

        event.eventId = (AL_EVENT_ID)evParams->eventId;
        event.eventValue.length = evParams->eventValue.length;
        (void) memcpy(event.eventValue.value, evParams->eventValue.value, evParams->eventValue.length);
        alData.eventIndCallback(&event);
    }
}

// *****************************************************************************
// *****************************************************************************
// Section: AL Interface Implementation
// *****************************************************************************
// *****************************************************************************

void AL_DataRequest( AL_DATA_REQUEST_PARAMS *reqParams )
{
    uint64_t mon;
    bool sendDataCfm;
    uint8_t *key = NULL;
    AL_TX_STATUS txStatus = AL_TX_STATUS_SUCCESS;
    AL_MSG_ATTR attr = reqParams->attr;
    bool authMsg = lAL_MsgAttrIsAuth(attr);
    uint16_t apduLen = reqParams->apduLen;
    uint16_t lsduLen = apduLen + 1U;

    if (alData.state != AL_STATE_IDLE)
    {
        txStatus = AL_TX_STATUS_ERROR_BUSY;
    }
    else if ((apduLen > 0U) && (NULL == reqParams->apdu))
    {
        txStatus = AL_TX_STATUS_ERROR_BAD_LEN;
    }
    else
    {
        if (true == authMsg)
        {
            if (apduLen > AL_MAX_DATA_AUTH_LENGTH)
            {
                txStatus = AL_TX_STATUS_ERROR_BAD_LEN;
            }
        }
        else
        {
            if (apduLen > AL_MAX_DATA_LENGTH)
            {
                txStatus = AL_TX_STATUS_ERROR_BAD_LEN;
            }
        }
    }

    if (AL_TX_STATUS_SUCCESS == txStatus)
    {
        if (true == alData.isMaster)
        {
            /* Use CMON = LMON + 1. Store LMON for response */
            alData.lmon = reqParams->lmon;
            mon = reqParams->lmon + 1U;
        }
        else
        {
            /* Use LMON (updated in Data Indication if authenticated correctly) */
            mon = alData.lmon;
        }

        /* Copy data to DLL Tx Buffer */
        (void) memcpy(&alDllTxBuf[1], reqParams->apdu, apduLen);

        /* Get Read or Write key depending on ECC */
        key = lAL_GetKeyFromEcc(reqParams->ecc);

        if (true == authMsg)
        {
            if (NULL == key)
            {
                txStatus = AL_TX_STATUS_ERROR_AES_NO_KEY;
            }
            else
            {
                crypto_Mac_Status_E cmacStatus;
                uint8_t *datetimeLmonBuff;
                uint64_t datetimeLmon = reqParams->datetime;

                /* In Authenticated messages, 8 bytes are added for DATE-TIME or LMON */
                if ((false == alData.isMaster) && ((AL_MSG_CHALLENGE_RESP == attr) ||
                        (((AL_MSG_NACK_A_NODE_AUTH == attr) || (AL_MSG_NACK_B_NODE_AUTH == attr)) && (AL_NACK_AUTH_PAYLOAD == reqParams->apdu[0]))))
                {
                    /* CHL.REQ and NACK Authenticated (Error Code 10) use LMON instead of DATE-TIME */
                    datetimeLmon = mon;
                }

                /* Append DATE-TIME or LMON */
                datetimeLmonBuff = &alDllTxBuf[lsduLen];
                *datetimeLmonBuff++ = (uint8_t) (datetimeLmon >> 56);
                *datetimeLmonBuff++ = (uint8_t) (datetimeLmon >> 48);
                *datetimeLmonBuff++ = (uint8_t) (datetimeLmon >> 40);
                *datetimeLmonBuff++ = (uint8_t) (datetimeLmon >> 32);
                *datetimeLmonBuff++ = (uint8_t) (datetimeLmon >> 24);
                *datetimeLmonBuff++ = (uint8_t) (datetimeLmon >> 16);
                *datetimeLmonBuff++ = (uint8_t) (datetimeLmon >> 8);
                *datetimeLmonBuff = (uint8_t) datetimeLmon;
                lsduLen += AL_DATETIME_LENGTH;
                apduLen += AL_DATETIME_LENGTH;

                /* Compute truncated AES-CMAC (TMAC) */
                cmacStatus = lAL_CMacDigest(&alDllTxBuf[1], apduLen, key, &alDllTxBuf[lsduLen], mon, attr);
                if (CRYPTO_MAC_CIPHER_SUCCESS == cmacStatus)
                {
                    lsduLen += AL_TMAC_LENGTH;
                    apduLen += AL_TMAC_LENGTH;
                }
                else
                {
                    txStatus = AL_TX_STATUS_ERROR_AES_CMAC;
                }
            }
        }
    }

    if (AL_TX_STATUS_SUCCESS == txStatus)
    {
        uint8_t *encryptInputOutput = &alDllTxBuf[1];
        uint16_t encryptLen = apduLen;

        switch (attr)
        {
            case AL_MSG_CHALLENGE_RESP:
                /* T field (2 bytes) is not encrypted */
                encryptInputOutput += 2;
                if (encryptLen >= 2U)
                {
                    encryptLen -= 2U;
                }
                else
                {
                    encryptLen = 0U;
                }
                break;

            case AL_MSG_NACK_A_NODE_AUTH:
            case AL_MSG_NACK_B_NODE_AUTH:
                /* PAR1 Error Code field (1 byte) is not encrypted */
                encryptInputOutput += 1;
                if (encryptLen >= 1U)
                {
                    encryptLen -= 1U;
                }
                else
                {
                    encryptLen = 0U;
                }
                break;

            default:
                break;
        }

        /* Encrypt data if needed */
        if (encryptLen > 0U)
        {
            txStatus = lAL_Encrypt(encryptInputOutput, encryptLen, key, reqParams->ecc, mon);
        }
    }

    sendDataCfm = (false == alData.alDataReqInternal);
    alData.alDataReqInternal = false;
    if (AL_TX_STATUS_SUCCESS == txStatus)
    {
        /* Put message attribute in first byte */
        alDllTxBuf[0] = (uint8_t) attr;

        /* All Ok. Send Request to DLL */
        alData.dllDataReqParams.lsduLen = lsduLen;
        alData.dllDataReqParams.dsap = reqParams->dsap;
        alData.dllDataReqParams.ecc = reqParams->ecc;
        alData.state = AL_STATE_WAITING_TX_CFM;
        alData.txRetryCount = 0;
        alData.sendDataCfm = sendDataCfm;
        if (true == alData.isMaster)
        {
            /* DCU specific parameters */
            alData.dllDataReqParams.dstAddress = reqParams->dstAddress;
            alData.dllDataReqParams.serviceClass = reqParams->serviceClass;
            alData.dllDataReqParams.maxResponseLen = reqParams->maxResponseLen;
            alData.dllDataReqParams.timeSlotNum = reqParams->timeSlotNum;
            alData.multiresponse = (SERVICE_CLASS_RC == reqParams->serviceClass);
        }
        else
        {
            alData.multiresponse = (AL_MSG_ADDRESS_REQ == attr);
            if (lAL_MsgAttrIsAuth((AL_MSG_ATTR) alDllLastRxBuff[0]) == true)
            {
                /* If a repetition is detected, this response will be repeated without changing anything */
                alData.responseProtectedValid = true;
            }
        }

        DLL_DataRequest(&alData.dllDataReqParams);

        /* DCU always sets a Tx Timeout. Meter only sets Tx Timeout for ADDRESS.REQ message */
        if ((true == alData.isMaster) || (true == alData.multiresponse))
        {
            
            alData.txTimeoutExpired = false;
            alData.txTimeoutHandle = SYS_TIME_CallbackRegisterUS(lAL_TxTimeoutCallback, 0, DLL_GetTxTimeout(), SYS_TIME_SINGLE);
        }
    }
    else
    {
        if (true == sendDataCfm)
        {
            /* Notify Error with Confirm (from Tasks) */
            alData.dataCfmPending = true;
            alData.dataCfmParamsTasks.dsap = reqParams->dsap;
            alData.dataCfmParamsTasks.ecc = reqParams->ecc;
            alData.dataCfmParamsTasks.txStatus = txStatus;
            if (true == alData.isMaster)
            {
                uint8_t routeSize = reqParams->dstAddress.routeSize;
                if (0U == routeSize)
                {
                    /* Invalid route size: Set all 0's in reported address */
                    (void) memset(alData.dataCfmParamsTasks.dstAddress.address, 0, MAC_ADDRESS_SIZE);
                }
                else
                {
                    if (routeSize  > MAX_ROUTE_SIZE)
                    {
                        routeSize = MAX_ROUTE_SIZE;
                    }

                    /* DCU: Report final destination address */
                    alData.dataCfmParamsTasks.dstAddress = reqParams->dstAddress.macAddress[routeSize - 1];
                }
            }
            else
            {
                /* Meter: Report the destination address of the last received frame
                 * (our own ACA or SCA address or multicast address) */
                alData.dataCfmParamsTasks.dstAddress = alData.lastRxAddress;
            }
        }
    }
}

AL_RESULT AL_DataIndicationCallbackRegister( AL_DATA_IND_CALLBACK callback )
{
    alData.dataIndCallback = callback;
    return AL_SUCCESS;
}

AL_RESULT AL_DataConfirmCallbackRegister(AL_DATA_CONFIRM_CALLBACK callback)
{
    alData.dataCfmCallback = callback;
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

    /* Initialize variables */
    (void) memset(alDllLastRxBuff, 0, sizeof(alDllLastRxBuff));
    (void) memset(&alData, 0, sizeof(alData));
    alData.dllDataReqParams.lsdu = alDllTxBuf;
    alData.txTimeoutHandle = SYS_TIME_HANDLE_INVALID;
    alData.tct = 0xFF;

    /* Get initialization parameters */
    alData.taskRateCount = SYS_TIME_MSToCount(alInit->taskRateMs);
    alData.nextTaskTimeCount = SYS_TIME_Counter64Get();
    alData.isMaster = alInit->isMaster;
    alData.txRetryLimit = alInit->txRetryLimit;

    /* Initialize status */
    alData.status = SYS_STATUS_BUSY;
    alData.state = AL_STATE_WAIT_DLL_READY;

    DLL_DataIndicationCallbackRegister( lAL_DllDataIndication );
    DLL_DataConfirmCallbackRegister( lAL_DllDataConfirm );
    DLL_EventIndicationCallbackRegister( lAL_DllEventIndication );

    return (SYS_MODULE_OBJ)0;
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

    if (true == alData.dataCfmPending)
    {
        /* Clear flag */
        alData.dataCfmPending = false;

        /* Send Confirm */
        if (alData.dataCfmCallback != NULL)
        {
            alData.dataCfmCallback(&alData.dataCfmParamsTasks);
        }
    }

    switch (alData.state)
    {
        case AL_STATE_WAIT_DLL_READY:
            /* Wait for DLL to be ready */
            if (DLL_GetStatus() == SYS_STATUS_READY)
            {
                /* Set Status */
                alData.status = SYS_STATUS_READY;
                alData.state = AL_STATE_IDLE;
            }
            break;

        case AL_STATE_IDLE:
            /* Nothing to do, wait for Requests or Indications */
            break;

        case AL_STATE_WAITING_TX_CFM:
            /* Nothing to do, wait for DL_DATA.CONFIRM */
            break;
            
        case AL_STATE_WAITING_TIMEOUT:
            /* Wait until Timeout expires */
            if (true == alData.txTimeoutExpired)
            {
                alData.state = AL_STATE_IDLE;
                alData.txTimeoutHandle = SYS_TIME_HANDLE_INVALID;
            }
            break;

        case AL_STATE_WAITING_RX:
            if (true == alData.txTimeoutExpired)
            {
                alData.state = AL_STATE_IDLE;
                alData.txTimeoutHandle = SYS_TIME_HANDLE_INVALID;

                if (true == alData.isMaster)
                {
                    /* Generate Event */
                    if (alData.eventIndCallback != NULL)
                    {
                        AL_EVENT_IND_PARAMS event;

                        event.eventId = AL_EVENT_ID_MASTER_TX_TIMEOUT;
                        event.eventValue.length = 0;
                        alData.eventIndCallback(&event);
                    }
                }
                else
                {
                    /* Send REQADDR.RESP */
                    AL_DATA_REQUEST_PARAMS request;
                    request.apdu = alReqAddrRespBuf;
                    request.apduLen = 1U + (alReqAddrRespBuf[0] * AL_NM_ADDRESS_RESP_LEN);
                    request.attr = AL_MSG_REQADDR_RESP;
                    request.dsap = DLL_DSAP_NETWORK_MANAGEMENT;
                    request.ecc = DLL_ECC_DISABLED;
                    alData.alDataReqInternal = true;
                    AL_DataRequest(&request);
                }
            }
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
        case AL_AUTH_LMON_IB:
            /* Ignore index */
            ibValue->length = AL_LMON_LENGTH;
            (void) memcpy(ibValue->value, (uint8_t *)&alData.lmon, AL_LMON_LENGTH);
            break;

        case AL_AUTH_WRITE_KEY_K1_IB:
            /* Ignore index */
            ibValue->length = AL_KEY_LENGTH;
            (void) memcpy(ibValue->value, &alData.keyWrite[12], 4);
            (void) memcpy(&ibValue->value[4], alData.keyWrite, 12);
            break;

        case AL_AUTH_READ_KEY_K2_IB:
            /* Ignore index */
            ibValue->length = AL_KEY_LENGTH;
            (void) memcpy(ibValue->value, &alData.keyRead[12], 4);
            (void) memcpy(&ibValue->value[4], alData.keyRead, 12);
            break;

        case AL_AUTH_DESTINATION_NODE_ACA_IB:
            /* Ignore index */
            ibValue->length = MAC_ADDRESS_SIZE;
            (void) memcpy(ibValue->value, alData.acaDestination.address, MAC_ADDRESS_SIZE);
            break;

        case AL_NM_TCT_IB:
            /* Ignore index */
            ibValue->length = 1;
            ibValue->value[0] = alData.tct;
            break;

        case AL_TX_RETRY_LIMIT:
            /* Ignore index */
            ibValue->length = 1;
            ibValue->value[0] = alData.txRetryLimit;
            break;

        default:
            /* No AL IB, try with DLL */
            result = (AL_RESULT) DLL_GetRequest((DLL_IB_ATTRIBUTE) attribute, index, (DLL_IB_VALUE *) ibValue);
    }

    return result;
}

AL_RESULT AL_SetRequest(AL_IB_ATTRIBUTE attribute, uint16_t index, const AL_IB_VALUE *ibValue)
{
    AL_RESULT result = AL_ERROR;

    switch (attribute)
    {
        case AL_AUTH_LMON_IB:
            /* Ignore index */
            if (AL_LMON_LENGTH == ibValue->length)
            {
                (void) memcpy((uint8_t *)&alData.lmon, ibValue->value, AL_LMON_LENGTH);
                result = AL_SUCCESS;
            }
            break;

        case AL_AUTH_WRITE_KEY_K1_IB:
            /* Ignore index */
            if (AL_KEY_LENGTH == ibValue->length)
            {
                (void) memcpy(alData.keyWrite, &ibValue->value[4], 12);
                (void) memcpy(&alData.keyWrite[12], ibValue->value, 4);
                alData.keyReadValid = true;
                result = AL_SUCCESS;
            }
            break;

        case AL_AUTH_READ_KEY_K2_IB:
            /* Ignore index */
            if (AL_KEY_LENGTH == ibValue->length)
            {
                (void) memcpy(alData.keyRead, &ibValue->value[4], 12);
                (void) memcpy(&alData.keyRead[12], ibValue->value, 4);
                alData.keyWriteValid = true;
                result = AL_SUCCESS;
            }
            break;

        case AL_AUTH_DESTINATION_NODE_ACA_IB:
            /* Ignore index */
            if (MAC_ADDRESS_SIZE == ibValue->length)
            {
                (void) memcpy(alData.acaDestination.address, ibValue->value, MAC_ADDRESS_SIZE);
                result = AL_SUCCESS;
            }
            break;

        case AL_NM_TCT_IB:
            /* Ignore index */
            if ((1U == ibValue->length) && (ibValue->value[0] > 0U))
            {
                alData.tct = ibValue->value[0];
                result = AL_SUCCESS;
            }
            break;

        case AL_TX_RETRY_LIMIT:
            /* Ignore index */
            if (1U == ibValue->length)
            {
                alData.txRetryLimit = ibValue->value[0];
                result = AL_SUCCESS;
            }
            break;

        case AL_MAC_ACA_ADDRESS_IB:
            /* Store own ACA (reversed) on AL and send Set to DLL */
            if (MAC_ADDRESS_SIZE == ibValue->length)
            {
                alData.acaOwn.address[0] = ibValue->value[5];
                alData.acaOwn.address[1] = ibValue->value[4];
                alData.acaOwn.address[2] = ibValue->value[3];
                alData.acaOwn.address[3] = ibValue->value[2];
                alData.acaOwn.address[4] = ibValue->value[1];
                alData.acaOwn.address[5] = ibValue->value[0];
                result = (AL_RESULT) DLL_SetRequest((DLL_IB_ATTRIBUTE) attribute, index, (DLL_IB_VALUE *) ibValue);
            }
            break;

        default:
            /* No AL IB, try with DLL */
            result = (AL_RESULT) DLL_SetRequest((DLL_IB_ATTRIBUTE) attribute, index, (DLL_IB_VALUE *) ibValue);
    }

    return result;
}

void AL_DataRequestHI(AL_DATA_REQUEST_PARAMS_HI *reqParams)
{
    AL_DATA_REQUEST_PARAMS drParams;
    uint8_t hdrSize;
    uint8_t ctl;
    uint8_t discipline;
    uint8_t rpSize;
    uint8_t rpAddrSize;
    uint8_t i, j;
    uint8_t infLsap;
    uint8_t *pPayload;

    /* Set a pointer to start of payload to walk through it */
    pPayload = reqParams->payload;

    /* DSAP comes from upper layer */
    drParams.dsap = (DLL_DSAP) reqParams->dsap;
    /* Set DATE-TIME to 0 */
    drParams.datetime = 0;
    /* ToDo store Request ID if needed */
    /* = reqParams->reqID; */

    if (alData.isMaster)
    {
        /* ToDo fill lmon field */

        /* LT field not used */
        pPayload++;
        /* Address field */
        for (i = 0; i < MAC_ADDRESS_SIZE; i++)
        {
            drParams.dstAddress.macAddress[0].address[i] = *pPayload++;
        }
        /* Check addressing */
        if (drParams.dstAddress.macAddress[0].address[AL_HI_CSL_INDEX] == AL_HI_CSL_VALUE)
        {
            rpAddrSize = AL_HI_SCA_SIZE;
        }
        else
        {
            rpAddrSize = MAC_ADDRESS_SIZE;
        }
        /* CTL field */
        ctl = *pPayload++;
        /* RP field (if any) */
        if ((ctl & AL_HI_NOR_MASK) == AL_HI_NOR_MASK)
        {
            /* NOR1 frame */
            rpSize = 0;
            drParams.dstAddress.routeSize = 1;
        }
        else
        {
            /* RIP frame */
            rpSize = ((ctl & AL_HI_RP_MASK) >> 1) + 1;
            drParams.dstAddress.routeSize = rpSize + 1;
            for (j = 0; j < (rpSize); j++)
            {
                for (i = 0; i < rpAddrSize; i++)
                {
                    drParams.dstAddress.macAddress[j + 1].address[i] = *pPayload++;
                }
            }
        }
        /* Reserved field and infControl not used, will be set by lower layers */
        pPayload += 2;
        /* INF LSAP field */
        infLsap = *pPayload++;
        drParams.ecc = (DLL_ECC) (infLsap & 0x0FU);
        /* Extract Discipline from CTL field */
        discipline = ctl & 0xF0U;
        /* And from discipline, set pending tx parameters */
        if (discipline < 0x20U)
        {
            drParams.serviceClass = SERVICE_CLASS_S;
            drParams.maxResponseLen = 0;
            drParams.timeSlotNum = 0;
        }
        else if (discipline < 0x90)
        {
            drParams.serviceClass = SERVICE_CLASS_RA;
            drParams.timeSlotNum = 0;
            if (discipline < 0x30) /* RA1 */
            {
                drParams.maxResponseLen = 20;
            }
            else if (discipline < 0x40) /* RA2 */
            {
                drParams.maxResponseLen = 40;
            }
            else if (discipline < 0x50) /* RA3 */
            {
                drParams.maxResponseLen = 60;
            }
            else if (discipline < 0x60) /* RA4 */
            {
                drParams.maxResponseLen = 80;
            }
            else if (discipline < 0x70) /* RA5 */
            {
                drParams.maxResponseLen = 100;
            }
            else if (discipline < 0x80) /* RA6 */
            {
                drParams.maxResponseLen = 120;
            }
            else /* RA7 */
            {
                drParams.maxResponseLen = 140;
            }
        }
        else if (discipline < 0xC0)
        {
            drParams.serviceClass = SERVICE_CLASS_RB;
            drParams.timeSlotNum = 0;
            if (discipline < 0xA0) /* RB1 */
            {
                drParams.maxResponseLen = 20;
            }
            else if (discipline < 0xB0) /* RB2 */
            {
                drParams.maxResponseLen = 30;
            }
            else /* RB3 */
            {
                drParams.maxResponseLen = 50;
            }
        }
        else
        {
            drParams.serviceClass = SERVICE_CLASS_RC;
            drParams.maxResponseLen = 90;
            if (discipline < 0xD0) /* RC1 */
            {
                drParams.timeSlotNum = 8;
            }
            else if (discipline < 0xE0) /* RC2 */
            {
                drParams.timeSlotNum = 16;
            }
            else if (discipline < 0xF0) /* RC3 */
            {
                drParams.timeSlotNum = 32;
            }
            else /* RC4 */
            {
                drParams.timeSlotNum = 64;
            }
        }

        /* Set message ATTR */
        drParams.attr = (AL_MSG_ATTR) *pPayload++;

        /* Set APDU pointer and length according to pending payload buffer */
        drParams.apdu = pPayload;
        if ((pPayload - &reqParams->payload[0]) > 0)
        {
            hdrSize = pPayload - &reqParams->payload[0];
        }
        else
        {
            hdrSize = 0;
        }
        drParams.apduLen = reqParams->payloadLen - hdrSize;
    }
    else
    {
        /* Slave node */
        /* Data comes from upper layer. Extract attribute and adapt Payload. */
        drParams.attr = (AL_MSG_ATTR) reqParams->payload[0];
        drParams.apdu = &reqParams->payload[1];
        drParams.apduLen = reqParams->payloadLen - 1U;
        /* ECC from received message */
        drParams.ecc = alData.eccReceived;
    }

    /* Call standard Data request with extracted parameters */
    AL_DataRequest(&drParams);
}

AL_RESULT AL_PerformECB(uint8_t *dataIn, uint8_t dataLen, uint8_t *dataOut, uint8_t *key, uint8_t keyLen)
{
    crypto_Sym_Status_E aesResult = Crypto_Sym_Aes_EncryptDirect(CRYPTO_HANDLER_SW_WOLFCRYPT,
            CRYPTO_SYM_OPMODE_ECB, dataIn, dataLen, dataOut, key, keyLen, NULL, 1);

    if (CRYPTO_SYM_CIPHER_SUCCESS == aesResult)
    {
        return AL_SUCCESS;
    }

    return AL_ERROR;
}

/* *****************************************************************************
 End of File
 */
