#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
ifeq "${IGNORE_LOCAL}" "TRUE"
# do not include local makefile. User is passing all local related variables already
else
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-default.mk)" "nbproject/Makefile-local-default.mk"
include nbproject/Makefile-local-default.mk
endif
endif

# Environment
MKDIR=gnumkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=default
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=a
DEBUGGABLE_SUFFIX=
FINAL_IMAGE=${DISTDIR}/MOM_Application_al.X.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=a
DEBUGGABLE_SUFFIX=
FINAL_IMAGE=${DISTDIR}/MOM_Application_al.X.${OUTPUT_SUFFIX}
endif

ifeq ($(COMPARE_BUILD), true)
COMPARISON_BUILD=-mafrlcsj
else
COMPARISON_BUILD=
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Source Files Quoted if spaced
SOURCEFILES_QUOTED_IF_SPACED=../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Aead_WolfCryptWrapper.c ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Hash.c ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_DigSign_WolfcryptWrapper.c ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Hash_WolfcryptWrapper.c ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_RNG.c ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Sym_WolfcryptWrapper.c ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Aead_Cipher.c ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Mac_WolfCryptWrapper.c ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_RNG_WolfcryptWrapper.c ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_DigSign.c ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Sym_Cipher.c ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Kas_WolfcryptWrapper.c ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Mac_Cipher.c ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Kas.c ../src/config/default/peripheral/clk/plib_clk.c ../src/config/default/peripheral/cmcc/plib_cmcc.c ../src/config/default/peripheral/dwdt/plib_dwdt.c ../src/config/default/peripheral/nvic/plib_nvic.c ../src/config/default/peripheral/pio/plib_pio.c ../src/config/default/peripheral/rstc/plib_rstc.c ../src/config/default/peripheral/sefc/plib_sefc0.c ../src/config/default/peripheral/sefc/plib_sefc1.c ../src/config/default/peripheral/supc/plib_supc.c ../src/config/default/peripheral/tc/plib_tc0.c ../src/config/default/stdio/xc32_monitor.c ../src/config/default/system/cache/sys_cache.c ../src/config/default/system/int/src/sys_int.c ../src/config/default/system/time/src/sys_time.c ../src/config/default/libc_syscalls.c ../src/config/default/interrupts.c ../src/config/default/exceptions.c ../src/config/default/initialization.c ../src/config/default/startup_xc32.c ../src/config/default/tasks.c ../src/third_party/wolfssl/wolfcrypt/src/port/pic32/pic32mz-crypt.c ../src/third_party/wolfssl/wolfcrypt/src/pkcs7.c ../src/third_party/wolfssl/wolfcrypt/src/random.c ../src/third_party/wolfssl/wolfcrypt/src/tfm.c ../src/third_party/wolfssl/wolfcrypt/src/wc_encrypt.c ../src/third_party/wolfssl/wolfcrypt/src/ed448.c ../src/third_party/wolfssl/wolfcrypt/src/chacha20_poly1305.c ../src/third_party/wolfssl/wolfcrypt/src/sp_cortexm.c ../src/third_party/wolfssl/wolfcrypt/src/srp.c ../src/third_party/wolfssl/wolfcrypt/src/blake2b.c ../src/third_party/wolfssl/wolfcrypt/src/idea.c ../src/third_party/wolfssl/wolfcrypt/src/curve448.c ../src/third_party/wolfssl/wolfcrypt/src/sp_int.c ../src/third_party/wolfssl/wolfcrypt/src/integer.c ../src/third_party/wolfssl/wolfcrypt/src/compress.c ../src/third_party/wolfssl/wolfcrypt/src/memory.c ../src/third_party/wolfssl/wolfcrypt/src/cmac.c ../src/third_party/wolfssl/wolfcrypt/src/error.c ../src/third_party/wolfssl/wolfcrypt/src/poly1305.c ../src/third_party/wolfssl/wolfcrypt/src/blake2s.c ../src/third_party/wolfssl/wolfcrypt/src/ripemd.c ../src/third_party/wolfssl/wolfcrypt/src/rabbit.c ../src/third_party/wolfssl/wolfcrypt/src/sp_c32.c ../src/third_party/wolfssl/wolfcrypt/src/ed25519.c ../src/third_party/wolfssl/wolfcrypt/src/fe_448.c ../src/third_party/wolfssl/wolfcrypt/src/rc2.c ../src/third_party/wolfssl/wolfcrypt/src/hash.c ../src/third_party/wolfssl/wolfcrypt/src/dh.c ../src/third_party/wolfssl/wolfcrypt/src/logging.c ../src/third_party/wolfssl/wolfcrypt/src/sp_arm64.c ../src/third_party/wolfssl/wolfcrypt/src/des3.c ../src/third_party/wolfssl/wolfcrypt/src/camellia.c ../src/third_party/wolfssl/wolfcrypt/src/sha.c ../src/third_party/wolfssl/wolfcrypt/src/wc_pkcs11.c ../src/third_party/wolfssl/wolfcrypt/src/hc128.c ../src/third_party/wolfssl/wolfcrypt/src/chacha.c ../src/third_party/wolfssl/wolfcrypt/src/pwdbased.c ../src/third_party/wolfssl/wolfcrypt/src/coding.c ../src/third_party/wolfssl/wolfcrypt/src/wc_port.c ../src/third_party/wolfssl/wolfcrypt/src/fe_low_mem.c ../src/third_party/wolfssl/wolfcrypt/src/ecc.c ../src/third_party/wolfssl/wolfcrypt/src/ge_low_mem.c ../src/third_party/wolfssl/wolfcrypt/src/asn.c ../src/third_party/wolfssl/wolfcrypt/src/ge_operations.c ../src/third_party/wolfssl/wolfcrypt/src/curve25519.c ../src/third_party/wolfssl/wolfcrypt/src/sp_arm32.c ../src/third_party/wolfssl/wolfcrypt/src/wolfmath.c ../src/third_party/wolfssl/wolfcrypt/src/sha3.c ../src/third_party/wolfssl/wolfcrypt/src/cryptocb.c ../src/third_party/wolfssl/wolfcrypt/src/pkcs12.c ../src/third_party/wolfssl/wolfcrypt/src/sha512.c ../src/third_party/wolfssl/wolfcrypt/src/md5.c ../src/third_party/wolfssl/wolfcrypt/src/rsa.c ../src/third_party/wolfssl/wolfcrypt/src/wolfevent.c ../src/third_party/wolfssl/wolfcrypt/src/asm.c ../src/third_party/wolfssl/wolfcrypt/src/cpuid.c ../src/third_party/wolfssl/wolfcrypt/src/md4.c ../src/third_party/wolfssl/wolfcrypt/src/aes.c ../src/third_party/wolfssl/wolfcrypt/src/wc_dsp.c ../src/third_party/wolfssl/wolfcrypt/src/ge_448.c ../src/third_party/wolfssl/wolfcrypt/src/dsa.c ../src/third_party/wolfssl/wolfcrypt/src/arc4.c ../src/third_party/wolfssl/wolfcrypt/src/ecc_fp.c ../src/third_party/wolfssl/wolfcrypt/src/sp_dsp32.c ../src/third_party/wolfssl/wolfcrypt/src/fe_operations.c ../src/third_party/wolfssl/wolfcrypt/src/sp_x86_64.c ../src/third_party/wolfssl/wolfcrypt/src/sp_armthumb.c ../src/third_party/wolfssl/wolfcrypt/src/signature.c ../src/third_party/wolfssl/wolfcrypt/src/sha256.c ../src/third_party/wolfssl/wolfcrypt/src/sp_c64.c ../src/third_party/wolfssl/wolfcrypt/src/md2.c ../src/third_party/wolfssl/wolfcrypt/src/hmac.c ../src/third_party/wolfssl/wolfssl/wolfcrypt/src/misc.c ../src/third_party/wolfssl/wolfssl/wolfcrypt/src/evp.c ../src/main.c ../src/app.c ../src/app_layer.c "C:/microchip/harmony/Apps/Docs/Devices/Smart Energy/Lib development/src/crc.c"

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Aead_WolfCryptWrapper.o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Hash.o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_DigSign_WolfcryptWrapper.o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Hash_WolfcryptWrapper.o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_RNG.o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Sym_WolfcryptWrapper.o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Aead_Cipher.o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Mac_WolfCryptWrapper.o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_RNG_WolfcryptWrapper.o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_DigSign.o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Sym_Cipher.o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Kas_WolfcryptWrapper.o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Mac_Cipher.o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Kas.o ${OBJECTDIR}/_ext/60165520/plib_clk.o ${OBJECTDIR}/_ext/1865131932/plib_cmcc.o ${OBJECTDIR}/_ext/1865171381/plib_dwdt.o ${OBJECTDIR}/_ext/1865468468/plib_nvic.o ${OBJECTDIR}/_ext/60177924/plib_pio.o ${OBJECTDIR}/_ext/1865585090/plib_rstc.o ${OBJECTDIR}/_ext/1865600993/plib_sefc0.o ${OBJECTDIR}/_ext/1865600993/plib_sefc1.o ${OBJECTDIR}/_ext/1865616679/plib_supc.o ${OBJECTDIR}/_ext/829342655/plib_tc0.o ${OBJECTDIR}/_ext/163028504/xc32_monitor.o ${OBJECTDIR}/_ext/1014039709/sys_cache.o ${OBJECTDIR}/_ext/1881668453/sys_int.o ${OBJECTDIR}/_ext/101884895/sys_time.o ${OBJECTDIR}/_ext/1171490990/libc_syscalls.o ${OBJECTDIR}/_ext/1171490990/interrupts.o ${OBJECTDIR}/_ext/1171490990/exceptions.o ${OBJECTDIR}/_ext/1171490990/initialization.o ${OBJECTDIR}/_ext/1171490990/startup_xc32.o ${OBJECTDIR}/_ext/1171490990/tasks.o ${OBJECTDIR}/_ext/193597431/pic32mz-crypt.o ${OBJECTDIR}/_ext/1716827871/pkcs7.o ${OBJECTDIR}/_ext/1716827871/random.o ${OBJECTDIR}/_ext/1716827871/tfm.o ${OBJECTDIR}/_ext/1716827871/wc_encrypt.o ${OBJECTDIR}/_ext/1716827871/ed448.o ${OBJECTDIR}/_ext/1716827871/chacha20_poly1305.o ${OBJECTDIR}/_ext/1716827871/sp_cortexm.o ${OBJECTDIR}/_ext/1716827871/srp.o ${OBJECTDIR}/_ext/1716827871/blake2b.o ${OBJECTDIR}/_ext/1716827871/idea.o ${OBJECTDIR}/_ext/1716827871/curve448.o ${OBJECTDIR}/_ext/1716827871/sp_int.o ${OBJECTDIR}/_ext/1716827871/integer.o ${OBJECTDIR}/_ext/1716827871/compress.o ${OBJECTDIR}/_ext/1716827871/memory.o ${OBJECTDIR}/_ext/1716827871/cmac.o ${OBJECTDIR}/_ext/1716827871/error.o ${OBJECTDIR}/_ext/1716827871/poly1305.o ${OBJECTDIR}/_ext/1716827871/blake2s.o ${OBJECTDIR}/_ext/1716827871/ripemd.o ${OBJECTDIR}/_ext/1716827871/rabbit.o ${OBJECTDIR}/_ext/1716827871/sp_c32.o ${OBJECTDIR}/_ext/1716827871/ed25519.o ${OBJECTDIR}/_ext/1716827871/fe_448.o ${OBJECTDIR}/_ext/1716827871/rc2.o ${OBJECTDIR}/_ext/1716827871/hash.o ${OBJECTDIR}/_ext/1716827871/dh.o ${OBJECTDIR}/_ext/1716827871/logging.o ${OBJECTDIR}/_ext/1716827871/sp_arm64.o ${OBJECTDIR}/_ext/1716827871/des3.o ${OBJECTDIR}/_ext/1716827871/camellia.o ${OBJECTDIR}/_ext/1716827871/sha.o ${OBJECTDIR}/_ext/1716827871/wc_pkcs11.o ${OBJECTDIR}/_ext/1716827871/hc128.o ${OBJECTDIR}/_ext/1716827871/chacha.o ${OBJECTDIR}/_ext/1716827871/pwdbased.o ${OBJECTDIR}/_ext/1716827871/coding.o ${OBJECTDIR}/_ext/1716827871/wc_port.o ${OBJECTDIR}/_ext/1716827871/fe_low_mem.o ${OBJECTDIR}/_ext/1716827871/ecc.o ${OBJECTDIR}/_ext/1716827871/ge_low_mem.o ${OBJECTDIR}/_ext/1716827871/asn.o ${OBJECTDIR}/_ext/1716827871/ge_operations.o ${OBJECTDIR}/_ext/1716827871/curve25519.o ${OBJECTDIR}/_ext/1716827871/sp_arm32.o ${OBJECTDIR}/_ext/1716827871/wolfmath.o ${OBJECTDIR}/_ext/1716827871/sha3.o ${OBJECTDIR}/_ext/1716827871/cryptocb.o ${OBJECTDIR}/_ext/1716827871/pkcs12.o ${OBJECTDIR}/_ext/1716827871/sha512.o ${OBJECTDIR}/_ext/1716827871/md5.o ${OBJECTDIR}/_ext/1716827871/rsa.o ${OBJECTDIR}/_ext/1716827871/wolfevent.o ${OBJECTDIR}/_ext/1716827871/asm.o ${OBJECTDIR}/_ext/1716827871/cpuid.o ${OBJECTDIR}/_ext/1716827871/md4.o ${OBJECTDIR}/_ext/1716827871/aes.o ${OBJECTDIR}/_ext/1716827871/wc_dsp.o ${OBJECTDIR}/_ext/1716827871/ge_448.o ${OBJECTDIR}/_ext/1716827871/dsa.o ${OBJECTDIR}/_ext/1716827871/arc4.o ${OBJECTDIR}/_ext/1716827871/ecc_fp.o ${OBJECTDIR}/_ext/1716827871/sp_dsp32.o ${OBJECTDIR}/_ext/1716827871/fe_operations.o ${OBJECTDIR}/_ext/1716827871/sp_x86_64.o ${OBJECTDIR}/_ext/1716827871/sp_armthumb.o ${OBJECTDIR}/_ext/1716827871/signature.o ${OBJECTDIR}/_ext/1716827871/sha256.o ${OBJECTDIR}/_ext/1716827871/sp_c64.o ${OBJECTDIR}/_ext/1716827871/md2.o ${OBJECTDIR}/_ext/1716827871/hmac.o ${OBJECTDIR}/_ext/1664057780/misc.o ${OBJECTDIR}/_ext/1664057780/evp.o ${OBJECTDIR}/_ext/1360937237/main.o ${OBJECTDIR}/_ext/1360937237/app.o ${OBJECTDIR}/_ext/1360937237/app_layer.o ${OBJECTDIR}/_ext/1803285470/crc.o
POSSIBLE_DEPFILES=${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Aead_WolfCryptWrapper.o.d ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Hash.o.d ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_DigSign_WolfcryptWrapper.o.d ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Hash_WolfcryptWrapper.o.d ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_RNG.o.d ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Sym_WolfcryptWrapper.o.d ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Aead_Cipher.o.d ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Mac_WolfCryptWrapper.o.d ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_RNG_WolfcryptWrapper.o.d ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_DigSign.o.d ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Sym_Cipher.o.d ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Kas_WolfcryptWrapper.o.d ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Mac_Cipher.o.d ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Kas.o.d ${OBJECTDIR}/_ext/60165520/plib_clk.o.d ${OBJECTDIR}/_ext/1865131932/plib_cmcc.o.d ${OBJECTDIR}/_ext/1865171381/plib_dwdt.o.d ${OBJECTDIR}/_ext/1865468468/plib_nvic.o.d ${OBJECTDIR}/_ext/60177924/plib_pio.o.d ${OBJECTDIR}/_ext/1865585090/plib_rstc.o.d ${OBJECTDIR}/_ext/1865600993/plib_sefc0.o.d ${OBJECTDIR}/_ext/1865600993/plib_sefc1.o.d ${OBJECTDIR}/_ext/1865616679/plib_supc.o.d ${OBJECTDIR}/_ext/829342655/plib_tc0.o.d ${OBJECTDIR}/_ext/163028504/xc32_monitor.o.d ${OBJECTDIR}/_ext/1014039709/sys_cache.o.d ${OBJECTDIR}/_ext/1881668453/sys_int.o.d ${OBJECTDIR}/_ext/101884895/sys_time.o.d ${OBJECTDIR}/_ext/1171490990/libc_syscalls.o.d ${OBJECTDIR}/_ext/1171490990/interrupts.o.d ${OBJECTDIR}/_ext/1171490990/exceptions.o.d ${OBJECTDIR}/_ext/1171490990/initialization.o.d ${OBJECTDIR}/_ext/1171490990/startup_xc32.o.d ${OBJECTDIR}/_ext/1171490990/tasks.o.d ${OBJECTDIR}/_ext/193597431/pic32mz-crypt.o.d ${OBJECTDIR}/_ext/1716827871/pkcs7.o.d ${OBJECTDIR}/_ext/1716827871/random.o.d ${OBJECTDIR}/_ext/1716827871/tfm.o.d ${OBJECTDIR}/_ext/1716827871/wc_encrypt.o.d ${OBJECTDIR}/_ext/1716827871/ed448.o.d ${OBJECTDIR}/_ext/1716827871/chacha20_poly1305.o.d ${OBJECTDIR}/_ext/1716827871/sp_cortexm.o.d ${OBJECTDIR}/_ext/1716827871/srp.o.d ${OBJECTDIR}/_ext/1716827871/blake2b.o.d ${OBJECTDIR}/_ext/1716827871/idea.o.d ${OBJECTDIR}/_ext/1716827871/curve448.o.d ${OBJECTDIR}/_ext/1716827871/sp_int.o.d ${OBJECTDIR}/_ext/1716827871/integer.o.d ${OBJECTDIR}/_ext/1716827871/compress.o.d ${OBJECTDIR}/_ext/1716827871/memory.o.d ${OBJECTDIR}/_ext/1716827871/cmac.o.d ${OBJECTDIR}/_ext/1716827871/error.o.d ${OBJECTDIR}/_ext/1716827871/poly1305.o.d ${OBJECTDIR}/_ext/1716827871/blake2s.o.d ${OBJECTDIR}/_ext/1716827871/ripemd.o.d ${OBJECTDIR}/_ext/1716827871/rabbit.o.d ${OBJECTDIR}/_ext/1716827871/sp_c32.o.d ${OBJECTDIR}/_ext/1716827871/ed25519.o.d ${OBJECTDIR}/_ext/1716827871/fe_448.o.d ${OBJECTDIR}/_ext/1716827871/rc2.o.d ${OBJECTDIR}/_ext/1716827871/hash.o.d ${OBJECTDIR}/_ext/1716827871/dh.o.d ${OBJECTDIR}/_ext/1716827871/logging.o.d ${OBJECTDIR}/_ext/1716827871/sp_arm64.o.d ${OBJECTDIR}/_ext/1716827871/des3.o.d ${OBJECTDIR}/_ext/1716827871/camellia.o.d ${OBJECTDIR}/_ext/1716827871/sha.o.d ${OBJECTDIR}/_ext/1716827871/wc_pkcs11.o.d ${OBJECTDIR}/_ext/1716827871/hc128.o.d ${OBJECTDIR}/_ext/1716827871/chacha.o.d ${OBJECTDIR}/_ext/1716827871/pwdbased.o.d ${OBJECTDIR}/_ext/1716827871/coding.o.d ${OBJECTDIR}/_ext/1716827871/wc_port.o.d ${OBJECTDIR}/_ext/1716827871/fe_low_mem.o.d ${OBJECTDIR}/_ext/1716827871/ecc.o.d ${OBJECTDIR}/_ext/1716827871/ge_low_mem.o.d ${OBJECTDIR}/_ext/1716827871/asn.o.d ${OBJECTDIR}/_ext/1716827871/ge_operations.o.d ${OBJECTDIR}/_ext/1716827871/curve25519.o.d ${OBJECTDIR}/_ext/1716827871/sp_arm32.o.d ${OBJECTDIR}/_ext/1716827871/wolfmath.o.d ${OBJECTDIR}/_ext/1716827871/sha3.o.d ${OBJECTDIR}/_ext/1716827871/cryptocb.o.d ${OBJECTDIR}/_ext/1716827871/pkcs12.o.d ${OBJECTDIR}/_ext/1716827871/sha512.o.d ${OBJECTDIR}/_ext/1716827871/md5.o.d ${OBJECTDIR}/_ext/1716827871/rsa.o.d ${OBJECTDIR}/_ext/1716827871/wolfevent.o.d ${OBJECTDIR}/_ext/1716827871/asm.o.d ${OBJECTDIR}/_ext/1716827871/cpuid.o.d ${OBJECTDIR}/_ext/1716827871/md4.o.d ${OBJECTDIR}/_ext/1716827871/aes.o.d ${OBJECTDIR}/_ext/1716827871/wc_dsp.o.d ${OBJECTDIR}/_ext/1716827871/ge_448.o.d ${OBJECTDIR}/_ext/1716827871/dsa.o.d ${OBJECTDIR}/_ext/1716827871/arc4.o.d ${OBJECTDIR}/_ext/1716827871/ecc_fp.o.d ${OBJECTDIR}/_ext/1716827871/sp_dsp32.o.d ${OBJECTDIR}/_ext/1716827871/fe_operations.o.d ${OBJECTDIR}/_ext/1716827871/sp_x86_64.o.d ${OBJECTDIR}/_ext/1716827871/sp_armthumb.o.d ${OBJECTDIR}/_ext/1716827871/signature.o.d ${OBJECTDIR}/_ext/1716827871/sha256.o.d ${OBJECTDIR}/_ext/1716827871/sp_c64.o.d ${OBJECTDIR}/_ext/1716827871/md2.o.d ${OBJECTDIR}/_ext/1716827871/hmac.o.d ${OBJECTDIR}/_ext/1664057780/misc.o.d ${OBJECTDIR}/_ext/1664057780/evp.o.d ${OBJECTDIR}/_ext/1360937237/main.o.d ${OBJECTDIR}/_ext/1360937237/app.o.d ${OBJECTDIR}/_ext/1360937237/app_layer.o.d ${OBJECTDIR}/_ext/1803285470/crc.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Aead_WolfCryptWrapper.o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Hash.o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_DigSign_WolfcryptWrapper.o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Hash_WolfcryptWrapper.o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_RNG.o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Sym_WolfcryptWrapper.o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Aead_Cipher.o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Mac_WolfCryptWrapper.o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_RNG_WolfcryptWrapper.o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_DigSign.o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Sym_Cipher.o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Kas_WolfcryptWrapper.o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Mac_Cipher.o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Kas.o ${OBJECTDIR}/_ext/60165520/plib_clk.o ${OBJECTDIR}/_ext/1865131932/plib_cmcc.o ${OBJECTDIR}/_ext/1865171381/plib_dwdt.o ${OBJECTDIR}/_ext/1865468468/plib_nvic.o ${OBJECTDIR}/_ext/60177924/plib_pio.o ${OBJECTDIR}/_ext/1865585090/plib_rstc.o ${OBJECTDIR}/_ext/1865600993/plib_sefc0.o ${OBJECTDIR}/_ext/1865600993/plib_sefc1.o ${OBJECTDIR}/_ext/1865616679/plib_supc.o ${OBJECTDIR}/_ext/829342655/plib_tc0.o ${OBJECTDIR}/_ext/163028504/xc32_monitor.o ${OBJECTDIR}/_ext/1014039709/sys_cache.o ${OBJECTDIR}/_ext/1881668453/sys_int.o ${OBJECTDIR}/_ext/101884895/sys_time.o ${OBJECTDIR}/_ext/1171490990/libc_syscalls.o ${OBJECTDIR}/_ext/1171490990/interrupts.o ${OBJECTDIR}/_ext/1171490990/exceptions.o ${OBJECTDIR}/_ext/1171490990/initialization.o ${OBJECTDIR}/_ext/1171490990/startup_xc32.o ${OBJECTDIR}/_ext/1171490990/tasks.o ${OBJECTDIR}/_ext/193597431/pic32mz-crypt.o ${OBJECTDIR}/_ext/1716827871/pkcs7.o ${OBJECTDIR}/_ext/1716827871/random.o ${OBJECTDIR}/_ext/1716827871/tfm.o ${OBJECTDIR}/_ext/1716827871/wc_encrypt.o ${OBJECTDIR}/_ext/1716827871/ed448.o ${OBJECTDIR}/_ext/1716827871/chacha20_poly1305.o ${OBJECTDIR}/_ext/1716827871/sp_cortexm.o ${OBJECTDIR}/_ext/1716827871/srp.o ${OBJECTDIR}/_ext/1716827871/blake2b.o ${OBJECTDIR}/_ext/1716827871/idea.o ${OBJECTDIR}/_ext/1716827871/curve448.o ${OBJECTDIR}/_ext/1716827871/sp_int.o ${OBJECTDIR}/_ext/1716827871/integer.o ${OBJECTDIR}/_ext/1716827871/compress.o ${OBJECTDIR}/_ext/1716827871/memory.o ${OBJECTDIR}/_ext/1716827871/cmac.o ${OBJECTDIR}/_ext/1716827871/error.o ${OBJECTDIR}/_ext/1716827871/poly1305.o ${OBJECTDIR}/_ext/1716827871/blake2s.o ${OBJECTDIR}/_ext/1716827871/ripemd.o ${OBJECTDIR}/_ext/1716827871/rabbit.o ${OBJECTDIR}/_ext/1716827871/sp_c32.o ${OBJECTDIR}/_ext/1716827871/ed25519.o ${OBJECTDIR}/_ext/1716827871/fe_448.o ${OBJECTDIR}/_ext/1716827871/rc2.o ${OBJECTDIR}/_ext/1716827871/hash.o ${OBJECTDIR}/_ext/1716827871/dh.o ${OBJECTDIR}/_ext/1716827871/logging.o ${OBJECTDIR}/_ext/1716827871/sp_arm64.o ${OBJECTDIR}/_ext/1716827871/des3.o ${OBJECTDIR}/_ext/1716827871/camellia.o ${OBJECTDIR}/_ext/1716827871/sha.o ${OBJECTDIR}/_ext/1716827871/wc_pkcs11.o ${OBJECTDIR}/_ext/1716827871/hc128.o ${OBJECTDIR}/_ext/1716827871/chacha.o ${OBJECTDIR}/_ext/1716827871/pwdbased.o ${OBJECTDIR}/_ext/1716827871/coding.o ${OBJECTDIR}/_ext/1716827871/wc_port.o ${OBJECTDIR}/_ext/1716827871/fe_low_mem.o ${OBJECTDIR}/_ext/1716827871/ecc.o ${OBJECTDIR}/_ext/1716827871/ge_low_mem.o ${OBJECTDIR}/_ext/1716827871/asn.o ${OBJECTDIR}/_ext/1716827871/ge_operations.o ${OBJECTDIR}/_ext/1716827871/curve25519.o ${OBJECTDIR}/_ext/1716827871/sp_arm32.o ${OBJECTDIR}/_ext/1716827871/wolfmath.o ${OBJECTDIR}/_ext/1716827871/sha3.o ${OBJECTDIR}/_ext/1716827871/cryptocb.o ${OBJECTDIR}/_ext/1716827871/pkcs12.o ${OBJECTDIR}/_ext/1716827871/sha512.o ${OBJECTDIR}/_ext/1716827871/md5.o ${OBJECTDIR}/_ext/1716827871/rsa.o ${OBJECTDIR}/_ext/1716827871/wolfevent.o ${OBJECTDIR}/_ext/1716827871/asm.o ${OBJECTDIR}/_ext/1716827871/cpuid.o ${OBJECTDIR}/_ext/1716827871/md4.o ${OBJECTDIR}/_ext/1716827871/aes.o ${OBJECTDIR}/_ext/1716827871/wc_dsp.o ${OBJECTDIR}/_ext/1716827871/ge_448.o ${OBJECTDIR}/_ext/1716827871/dsa.o ${OBJECTDIR}/_ext/1716827871/arc4.o ${OBJECTDIR}/_ext/1716827871/ecc_fp.o ${OBJECTDIR}/_ext/1716827871/sp_dsp32.o ${OBJECTDIR}/_ext/1716827871/fe_operations.o ${OBJECTDIR}/_ext/1716827871/sp_x86_64.o ${OBJECTDIR}/_ext/1716827871/sp_armthumb.o ${OBJECTDIR}/_ext/1716827871/signature.o ${OBJECTDIR}/_ext/1716827871/sha256.o ${OBJECTDIR}/_ext/1716827871/sp_c64.o ${OBJECTDIR}/_ext/1716827871/md2.o ${OBJECTDIR}/_ext/1716827871/hmac.o ${OBJECTDIR}/_ext/1664057780/misc.o ${OBJECTDIR}/_ext/1664057780/evp.o ${OBJECTDIR}/_ext/1360937237/main.o ${OBJECTDIR}/_ext/1360937237/app.o ${OBJECTDIR}/_ext/1360937237/app_layer.o ${OBJECTDIR}/_ext/1803285470/crc.o

# Source Files
SOURCEFILES=../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Aead_WolfCryptWrapper.c ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Hash.c ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_DigSign_WolfcryptWrapper.c ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Hash_WolfcryptWrapper.c ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_RNG.c ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Sym_WolfcryptWrapper.c ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Aead_Cipher.c ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Mac_WolfCryptWrapper.c ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_RNG_WolfcryptWrapper.c ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_DigSign.c ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Sym_Cipher.c ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Kas_WolfcryptWrapper.c ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Mac_Cipher.c ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Kas.c ../src/config/default/peripheral/clk/plib_clk.c ../src/config/default/peripheral/cmcc/plib_cmcc.c ../src/config/default/peripheral/dwdt/plib_dwdt.c ../src/config/default/peripheral/nvic/plib_nvic.c ../src/config/default/peripheral/pio/plib_pio.c ../src/config/default/peripheral/rstc/plib_rstc.c ../src/config/default/peripheral/sefc/plib_sefc0.c ../src/config/default/peripheral/sefc/plib_sefc1.c ../src/config/default/peripheral/supc/plib_supc.c ../src/config/default/peripheral/tc/plib_tc0.c ../src/config/default/stdio/xc32_monitor.c ../src/config/default/system/cache/sys_cache.c ../src/config/default/system/int/src/sys_int.c ../src/config/default/system/time/src/sys_time.c ../src/config/default/libc_syscalls.c ../src/config/default/interrupts.c ../src/config/default/exceptions.c ../src/config/default/initialization.c ../src/config/default/startup_xc32.c ../src/config/default/tasks.c ../src/third_party/wolfssl/wolfcrypt/src/port/pic32/pic32mz-crypt.c ../src/third_party/wolfssl/wolfcrypt/src/pkcs7.c ../src/third_party/wolfssl/wolfcrypt/src/random.c ../src/third_party/wolfssl/wolfcrypt/src/tfm.c ../src/third_party/wolfssl/wolfcrypt/src/wc_encrypt.c ../src/third_party/wolfssl/wolfcrypt/src/ed448.c ../src/third_party/wolfssl/wolfcrypt/src/chacha20_poly1305.c ../src/third_party/wolfssl/wolfcrypt/src/sp_cortexm.c ../src/third_party/wolfssl/wolfcrypt/src/srp.c ../src/third_party/wolfssl/wolfcrypt/src/blake2b.c ../src/third_party/wolfssl/wolfcrypt/src/idea.c ../src/third_party/wolfssl/wolfcrypt/src/curve448.c ../src/third_party/wolfssl/wolfcrypt/src/sp_int.c ../src/third_party/wolfssl/wolfcrypt/src/integer.c ../src/third_party/wolfssl/wolfcrypt/src/compress.c ../src/third_party/wolfssl/wolfcrypt/src/memory.c ../src/third_party/wolfssl/wolfcrypt/src/cmac.c ../src/third_party/wolfssl/wolfcrypt/src/error.c ../src/third_party/wolfssl/wolfcrypt/src/poly1305.c ../src/third_party/wolfssl/wolfcrypt/src/blake2s.c ../src/third_party/wolfssl/wolfcrypt/src/ripemd.c ../src/third_party/wolfssl/wolfcrypt/src/rabbit.c ../src/third_party/wolfssl/wolfcrypt/src/sp_c32.c ../src/third_party/wolfssl/wolfcrypt/src/ed25519.c ../src/third_party/wolfssl/wolfcrypt/src/fe_448.c ../src/third_party/wolfssl/wolfcrypt/src/rc2.c ../src/third_party/wolfssl/wolfcrypt/src/hash.c ../src/third_party/wolfssl/wolfcrypt/src/dh.c ../src/third_party/wolfssl/wolfcrypt/src/logging.c ../src/third_party/wolfssl/wolfcrypt/src/sp_arm64.c ../src/third_party/wolfssl/wolfcrypt/src/des3.c ../src/third_party/wolfssl/wolfcrypt/src/camellia.c ../src/third_party/wolfssl/wolfcrypt/src/sha.c ../src/third_party/wolfssl/wolfcrypt/src/wc_pkcs11.c ../src/third_party/wolfssl/wolfcrypt/src/hc128.c ../src/third_party/wolfssl/wolfcrypt/src/chacha.c ../src/third_party/wolfssl/wolfcrypt/src/pwdbased.c ../src/third_party/wolfssl/wolfcrypt/src/coding.c ../src/third_party/wolfssl/wolfcrypt/src/wc_port.c ../src/third_party/wolfssl/wolfcrypt/src/fe_low_mem.c ../src/third_party/wolfssl/wolfcrypt/src/ecc.c ../src/third_party/wolfssl/wolfcrypt/src/ge_low_mem.c ../src/third_party/wolfssl/wolfcrypt/src/asn.c ../src/third_party/wolfssl/wolfcrypt/src/ge_operations.c ../src/third_party/wolfssl/wolfcrypt/src/curve25519.c ../src/third_party/wolfssl/wolfcrypt/src/sp_arm32.c ../src/third_party/wolfssl/wolfcrypt/src/wolfmath.c ../src/third_party/wolfssl/wolfcrypt/src/sha3.c ../src/third_party/wolfssl/wolfcrypt/src/cryptocb.c ../src/third_party/wolfssl/wolfcrypt/src/pkcs12.c ../src/third_party/wolfssl/wolfcrypt/src/sha512.c ../src/third_party/wolfssl/wolfcrypt/src/md5.c ../src/third_party/wolfssl/wolfcrypt/src/rsa.c ../src/third_party/wolfssl/wolfcrypt/src/wolfevent.c ../src/third_party/wolfssl/wolfcrypt/src/asm.c ../src/third_party/wolfssl/wolfcrypt/src/cpuid.c ../src/third_party/wolfssl/wolfcrypt/src/md4.c ../src/third_party/wolfssl/wolfcrypt/src/aes.c ../src/third_party/wolfssl/wolfcrypt/src/wc_dsp.c ../src/third_party/wolfssl/wolfcrypt/src/ge_448.c ../src/third_party/wolfssl/wolfcrypt/src/dsa.c ../src/third_party/wolfssl/wolfcrypt/src/arc4.c ../src/third_party/wolfssl/wolfcrypt/src/ecc_fp.c ../src/third_party/wolfssl/wolfcrypt/src/sp_dsp32.c ../src/third_party/wolfssl/wolfcrypt/src/fe_operations.c ../src/third_party/wolfssl/wolfcrypt/src/sp_x86_64.c ../src/third_party/wolfssl/wolfcrypt/src/sp_armthumb.c ../src/third_party/wolfssl/wolfcrypt/src/signature.c ../src/third_party/wolfssl/wolfcrypt/src/sha256.c ../src/third_party/wolfssl/wolfcrypt/src/sp_c64.c ../src/third_party/wolfssl/wolfcrypt/src/md2.c ../src/third_party/wolfssl/wolfcrypt/src/hmac.c ../src/third_party/wolfssl/wolfssl/wolfcrypt/src/misc.c ../src/third_party/wolfssl/wolfssl/wolfcrypt/src/evp.c ../src/main.c ../src/app.c ../src/app_layer.c C:/microchip/harmony/Apps/Docs/Devices/Smart Energy/Lib development/src/crc.c

# Pack Options 
PACK_COMMON_OPTIONS=-I "${CMSIS_DIR}/CMSIS/Core/Include"



CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps

.build-conf:  ${BUILD_SUBPROJECTS}
ifneq ($(INFORMATION_MESSAGE), )
	@echo $(INFORMATION_MESSAGE)
endif
	${MAKE}  -f nbproject/Makefile-default.mk ${DISTDIR}/MOM_Application_al.X.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=32CX2051MTG128
MP_LINKER_FILE_OPTION=,--script="..\src\config\default\PIC32CX2051MTG128.ld"
# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assembleWithPreprocess
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Aead_WolfCryptWrapper.o: ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Aead_WolfCryptWrapper.c  .generated_files/flags/default/d0b40f8b2e9ff033a359bf230c5303ef4586f416 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1726652707" 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Aead_WolfCryptWrapper.o.d 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Aead_WolfCryptWrapper.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Aead_WolfCryptWrapper.o.d" -o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Aead_WolfCryptWrapper.o ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Aead_WolfCryptWrapper.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Hash.o: ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Hash.c  .generated_files/flags/default/dba84d3243b742b64040b187d6155a2bfed5cffc .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1726652707" 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Hash.o.d 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Hash.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Hash.o.d" -o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Hash.o ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Hash.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_DigSign_WolfcryptWrapper.o: ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_DigSign_WolfcryptWrapper.c  .generated_files/flags/default/212789ec8978c34f382abcfacc19cf40c5cb39c3 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1726652707" 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_DigSign_WolfcryptWrapper.o.d 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_DigSign_WolfcryptWrapper.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_DigSign_WolfcryptWrapper.o.d" -o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_DigSign_WolfcryptWrapper.o ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_DigSign_WolfcryptWrapper.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Hash_WolfcryptWrapper.o: ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Hash_WolfcryptWrapper.c  .generated_files/flags/default/7845d43b93a265248e53e3e0700d6eaac03487fd .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1726652707" 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Hash_WolfcryptWrapper.o.d 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Hash_WolfcryptWrapper.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Hash_WolfcryptWrapper.o.d" -o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Hash_WolfcryptWrapper.o ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Hash_WolfcryptWrapper.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_RNG.o: ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_RNG.c  .generated_files/flags/default/dba3edb64e4363e07939415bc6ac8b9ab2ce066b .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1726652707" 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_RNG.o.d 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_RNG.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_RNG.o.d" -o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_RNG.o ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_RNG.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Sym_WolfcryptWrapper.o: ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Sym_WolfcryptWrapper.c  .generated_files/flags/default/35f4ecb87b5d3b5d03bf1954f978dbbb620b6bb7 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1726652707" 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Sym_WolfcryptWrapper.o.d 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Sym_WolfcryptWrapper.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Sym_WolfcryptWrapper.o.d" -o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Sym_WolfcryptWrapper.o ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Sym_WolfcryptWrapper.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Aead_Cipher.o: ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Aead_Cipher.c  .generated_files/flags/default/19af749c0f11e42626a6ea7d7d641dd1bf81c284 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1726652707" 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Aead_Cipher.o.d 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Aead_Cipher.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Aead_Cipher.o.d" -o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Aead_Cipher.o ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Aead_Cipher.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Mac_WolfCryptWrapper.o: ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Mac_WolfCryptWrapper.c  .generated_files/flags/default/315a508bf609585b44d609064571dfe2f7883706 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1726652707" 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Mac_WolfCryptWrapper.o.d 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Mac_WolfCryptWrapper.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Mac_WolfCryptWrapper.o.d" -o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Mac_WolfCryptWrapper.o ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Mac_WolfCryptWrapper.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_RNG_WolfcryptWrapper.o: ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_RNG_WolfcryptWrapper.c  .generated_files/flags/default/b36d6a6cfe3877783e09779091dbdd187262e21e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1726652707" 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_RNG_WolfcryptWrapper.o.d 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_RNG_WolfcryptWrapper.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_RNG_WolfcryptWrapper.o.d" -o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_RNG_WolfcryptWrapper.o ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_RNG_WolfcryptWrapper.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_DigSign.o: ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_DigSign.c  .generated_files/flags/default/db157e30686633623c8e9980b781ce215f8812d0 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1726652707" 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_DigSign.o.d 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_DigSign.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_DigSign.o.d" -o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_DigSign.o ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_DigSign.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Sym_Cipher.o: ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Sym_Cipher.c  .generated_files/flags/default/8e8aef9d17d65f8d4767b5fcf1acf0a841a3c8d6 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1726652707" 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Sym_Cipher.o.d 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Sym_Cipher.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Sym_Cipher.o.d" -o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Sym_Cipher.o ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Sym_Cipher.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Kas_WolfcryptWrapper.o: ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Kas_WolfcryptWrapper.c  .generated_files/flags/default/d97e6908cfaaab6cdecbcf2de16d2aa96bd948cc .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1726652707" 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Kas_WolfcryptWrapper.o.d 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Kas_WolfcryptWrapper.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Kas_WolfcryptWrapper.o.d" -o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Kas_WolfcryptWrapper.o ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Kas_WolfcryptWrapper.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Mac_Cipher.o: ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Mac_Cipher.c  .generated_files/flags/default/4b1fbb6eb52196fca2113aa6d9f145f01396c70e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1726652707" 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Mac_Cipher.o.d 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Mac_Cipher.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Mac_Cipher.o.d" -o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Mac_Cipher.o ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Mac_Cipher.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Kas.o: ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Kas.c  .generated_files/flags/default/866cf7dec46784ddd35a48a1b869ccd4ff24da36 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1726652707" 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Kas.o.d 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Kas.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Kas.o.d" -o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Kas.o ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Kas.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/60165520/plib_clk.o: ../src/config/default/peripheral/clk/plib_clk.c  .generated_files/flags/default/38e25633f03370d1c9b7297e47ec3ce29b0ebe92 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/60165520" 
	@${RM} ${OBJECTDIR}/_ext/60165520/plib_clk.o.d 
	@${RM} ${OBJECTDIR}/_ext/60165520/plib_clk.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/60165520/plib_clk.o.d" -o ${OBJECTDIR}/_ext/60165520/plib_clk.o ../src/config/default/peripheral/clk/plib_clk.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1865131932/plib_cmcc.o: ../src/config/default/peripheral/cmcc/plib_cmcc.c  .generated_files/flags/default/6febdf0009832b4ea58b8da5d664ec098b358248 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1865131932" 
	@${RM} ${OBJECTDIR}/_ext/1865131932/plib_cmcc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1865131932/plib_cmcc.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1865131932/plib_cmcc.o.d" -o ${OBJECTDIR}/_ext/1865131932/plib_cmcc.o ../src/config/default/peripheral/cmcc/plib_cmcc.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1865171381/plib_dwdt.o: ../src/config/default/peripheral/dwdt/plib_dwdt.c  .generated_files/flags/default/a4032a7b56c37e3a49d39e9b977831e39476ab1b .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1865171381" 
	@${RM} ${OBJECTDIR}/_ext/1865171381/plib_dwdt.o.d 
	@${RM} ${OBJECTDIR}/_ext/1865171381/plib_dwdt.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1865171381/plib_dwdt.o.d" -o ${OBJECTDIR}/_ext/1865171381/plib_dwdt.o ../src/config/default/peripheral/dwdt/plib_dwdt.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1865468468/plib_nvic.o: ../src/config/default/peripheral/nvic/plib_nvic.c  .generated_files/flags/default/ea6df5d55d35d036af608a7d30bcca7bea7456c2 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1865468468" 
	@${RM} ${OBJECTDIR}/_ext/1865468468/plib_nvic.o.d 
	@${RM} ${OBJECTDIR}/_ext/1865468468/plib_nvic.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1865468468/plib_nvic.o.d" -o ${OBJECTDIR}/_ext/1865468468/plib_nvic.o ../src/config/default/peripheral/nvic/plib_nvic.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/60177924/plib_pio.o: ../src/config/default/peripheral/pio/plib_pio.c  .generated_files/flags/default/f14a70d0b9b6543127dac1c57f93b552929d12e8 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/60177924" 
	@${RM} ${OBJECTDIR}/_ext/60177924/plib_pio.o.d 
	@${RM} ${OBJECTDIR}/_ext/60177924/plib_pio.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/60177924/plib_pio.o.d" -o ${OBJECTDIR}/_ext/60177924/plib_pio.o ../src/config/default/peripheral/pio/plib_pio.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1865585090/plib_rstc.o: ../src/config/default/peripheral/rstc/plib_rstc.c  .generated_files/flags/default/17884f83d9472bb9ed3e612a0f2c4824f481f769 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1865585090" 
	@${RM} ${OBJECTDIR}/_ext/1865585090/plib_rstc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1865585090/plib_rstc.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1865585090/plib_rstc.o.d" -o ${OBJECTDIR}/_ext/1865585090/plib_rstc.o ../src/config/default/peripheral/rstc/plib_rstc.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1865600993/plib_sefc0.o: ../src/config/default/peripheral/sefc/plib_sefc0.c  .generated_files/flags/default/db9a3c115150b03590c07134b3d9021834edf09e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1865600993" 
	@${RM} ${OBJECTDIR}/_ext/1865600993/plib_sefc0.o.d 
	@${RM} ${OBJECTDIR}/_ext/1865600993/plib_sefc0.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1865600993/plib_sefc0.o.d" -o ${OBJECTDIR}/_ext/1865600993/plib_sefc0.o ../src/config/default/peripheral/sefc/plib_sefc0.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1865600993/plib_sefc1.o: ../src/config/default/peripheral/sefc/plib_sefc1.c  .generated_files/flags/default/8406a7c0472a2e1954f9fd2cfaf3d5d561be54b6 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1865600993" 
	@${RM} ${OBJECTDIR}/_ext/1865600993/plib_sefc1.o.d 
	@${RM} ${OBJECTDIR}/_ext/1865600993/plib_sefc1.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1865600993/plib_sefc1.o.d" -o ${OBJECTDIR}/_ext/1865600993/plib_sefc1.o ../src/config/default/peripheral/sefc/plib_sefc1.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1865616679/plib_supc.o: ../src/config/default/peripheral/supc/plib_supc.c  .generated_files/flags/default/ab078aa37d0bf4710450b05761afb86ce9eeaacb .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1865616679" 
	@${RM} ${OBJECTDIR}/_ext/1865616679/plib_supc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1865616679/plib_supc.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1865616679/plib_supc.o.d" -o ${OBJECTDIR}/_ext/1865616679/plib_supc.o ../src/config/default/peripheral/supc/plib_supc.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/829342655/plib_tc0.o: ../src/config/default/peripheral/tc/plib_tc0.c  .generated_files/flags/default/73352cf1689b4d659ea10c418958747add953a5b .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/829342655" 
	@${RM} ${OBJECTDIR}/_ext/829342655/plib_tc0.o.d 
	@${RM} ${OBJECTDIR}/_ext/829342655/plib_tc0.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/829342655/plib_tc0.o.d" -o ${OBJECTDIR}/_ext/829342655/plib_tc0.o ../src/config/default/peripheral/tc/plib_tc0.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/163028504/xc32_monitor.o: ../src/config/default/stdio/xc32_monitor.c  .generated_files/flags/default/e223b4c22f491835f8d250013c0983580667a78b .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/163028504" 
	@${RM} ${OBJECTDIR}/_ext/163028504/xc32_monitor.o.d 
	@${RM} ${OBJECTDIR}/_ext/163028504/xc32_monitor.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/163028504/xc32_monitor.o.d" -o ${OBJECTDIR}/_ext/163028504/xc32_monitor.o ../src/config/default/stdio/xc32_monitor.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1014039709/sys_cache.o: ../src/config/default/system/cache/sys_cache.c  .generated_files/flags/default/f19d5ca44373dc47e0adbf662e71fc89a943b64f .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1014039709" 
	@${RM} ${OBJECTDIR}/_ext/1014039709/sys_cache.o.d 
	@${RM} ${OBJECTDIR}/_ext/1014039709/sys_cache.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1014039709/sys_cache.o.d" -o ${OBJECTDIR}/_ext/1014039709/sys_cache.o ../src/config/default/system/cache/sys_cache.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1881668453/sys_int.o: ../src/config/default/system/int/src/sys_int.c  .generated_files/flags/default/cdf0d7637315b628f0e3a4628f095d38b36aafdf .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1881668453" 
	@${RM} ${OBJECTDIR}/_ext/1881668453/sys_int.o.d 
	@${RM} ${OBJECTDIR}/_ext/1881668453/sys_int.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1881668453/sys_int.o.d" -o ${OBJECTDIR}/_ext/1881668453/sys_int.o ../src/config/default/system/int/src/sys_int.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/101884895/sys_time.o: ../src/config/default/system/time/src/sys_time.c  .generated_files/flags/default/af11861696ea0997101b409e3377f83cc6b912a8 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/101884895" 
	@${RM} ${OBJECTDIR}/_ext/101884895/sys_time.o.d 
	@${RM} ${OBJECTDIR}/_ext/101884895/sys_time.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/101884895/sys_time.o.d" -o ${OBJECTDIR}/_ext/101884895/sys_time.o ../src/config/default/system/time/src/sys_time.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1171490990/libc_syscalls.o: ../src/config/default/libc_syscalls.c  .generated_files/flags/default/1dab1b177c48ccd285cab0571dc5136b2980f5ce .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1171490990" 
	@${RM} ${OBJECTDIR}/_ext/1171490990/libc_syscalls.o.d 
	@${RM} ${OBJECTDIR}/_ext/1171490990/libc_syscalls.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1171490990/libc_syscalls.o.d" -o ${OBJECTDIR}/_ext/1171490990/libc_syscalls.o ../src/config/default/libc_syscalls.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1171490990/interrupts.o: ../src/config/default/interrupts.c  .generated_files/flags/default/adfbef91645cd516484ea7df966e352c5588a570 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1171490990" 
	@${RM} ${OBJECTDIR}/_ext/1171490990/interrupts.o.d 
	@${RM} ${OBJECTDIR}/_ext/1171490990/interrupts.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1171490990/interrupts.o.d" -o ${OBJECTDIR}/_ext/1171490990/interrupts.o ../src/config/default/interrupts.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1171490990/exceptions.o: ../src/config/default/exceptions.c  .generated_files/flags/default/f34b22704a1ed531c46af7269747624622ed5e11 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1171490990" 
	@${RM} ${OBJECTDIR}/_ext/1171490990/exceptions.o.d 
	@${RM} ${OBJECTDIR}/_ext/1171490990/exceptions.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1171490990/exceptions.o.d" -o ${OBJECTDIR}/_ext/1171490990/exceptions.o ../src/config/default/exceptions.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1171490990/initialization.o: ../src/config/default/initialization.c  .generated_files/flags/default/a9e8d48914f6a8feb9795f9db89d08df96294b07 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1171490990" 
	@${RM} ${OBJECTDIR}/_ext/1171490990/initialization.o.d 
	@${RM} ${OBJECTDIR}/_ext/1171490990/initialization.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1171490990/initialization.o.d" -o ${OBJECTDIR}/_ext/1171490990/initialization.o ../src/config/default/initialization.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1171490990/startup_xc32.o: ../src/config/default/startup_xc32.c  .generated_files/flags/default/5a7e1a1988aa247b157c09a8ab291dc4ebe6440b .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1171490990" 
	@${RM} ${OBJECTDIR}/_ext/1171490990/startup_xc32.o.d 
	@${RM} ${OBJECTDIR}/_ext/1171490990/startup_xc32.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1171490990/startup_xc32.o.d" -o ${OBJECTDIR}/_ext/1171490990/startup_xc32.o ../src/config/default/startup_xc32.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1171490990/tasks.o: ../src/config/default/tasks.c  .generated_files/flags/default/253ea2f6b28dfe692a350cc7eb11a49ffde6c38 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1171490990" 
	@${RM} ${OBJECTDIR}/_ext/1171490990/tasks.o.d 
	@${RM} ${OBJECTDIR}/_ext/1171490990/tasks.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1171490990/tasks.o.d" -o ${OBJECTDIR}/_ext/1171490990/tasks.o ../src/config/default/tasks.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/193597431/pic32mz-crypt.o: ../src/third_party/wolfssl/wolfcrypt/src/port/pic32/pic32mz-crypt.c  .generated_files/flags/default/4c0af491d622434298eebac7f6611fbe581923e0 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/193597431" 
	@${RM} ${OBJECTDIR}/_ext/193597431/pic32mz-crypt.o.d 
	@${RM} ${OBJECTDIR}/_ext/193597431/pic32mz-crypt.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/193597431/pic32mz-crypt.o.d" -o ${OBJECTDIR}/_ext/193597431/pic32mz-crypt.o ../src/third_party/wolfssl/wolfcrypt/src/port/pic32/pic32mz-crypt.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/pkcs7.o: ../src/third_party/wolfssl/wolfcrypt/src/pkcs7.c  .generated_files/flags/default/dcfbacea58f0c83970cb3cf9c9a6d11c5826b89a .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/pkcs7.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/pkcs7.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/pkcs7.o.d" -o ${OBJECTDIR}/_ext/1716827871/pkcs7.o ../src/third_party/wolfssl/wolfcrypt/src/pkcs7.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/random.o: ../src/third_party/wolfssl/wolfcrypt/src/random.c  .generated_files/flags/default/4319a182b79302645cc5c3a84ad04d51cffcecb7 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/random.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/random.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/random.o.d" -o ${OBJECTDIR}/_ext/1716827871/random.o ../src/third_party/wolfssl/wolfcrypt/src/random.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/tfm.o: ../src/third_party/wolfssl/wolfcrypt/src/tfm.c  .generated_files/flags/default/2ebd89a9c0c5824996d74026d6ca1f2724c2acd .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/tfm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/tfm.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/tfm.o.d" -o ${OBJECTDIR}/_ext/1716827871/tfm.o ../src/third_party/wolfssl/wolfcrypt/src/tfm.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/wc_encrypt.o: ../src/third_party/wolfssl/wolfcrypt/src/wc_encrypt.c  .generated_files/flags/default/e7b7bd35d796e2363c5aa78265b52ed646e062c6 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/wc_encrypt.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/wc_encrypt.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/wc_encrypt.o.d" -o ${OBJECTDIR}/_ext/1716827871/wc_encrypt.o ../src/third_party/wolfssl/wolfcrypt/src/wc_encrypt.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/ed448.o: ../src/third_party/wolfssl/wolfcrypt/src/ed448.c  .generated_files/flags/default/5b3c510ec47e51616b46ee599a5400291c55c4da .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/ed448.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/ed448.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/ed448.o.d" -o ${OBJECTDIR}/_ext/1716827871/ed448.o ../src/third_party/wolfssl/wolfcrypt/src/ed448.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/chacha20_poly1305.o: ../src/third_party/wolfssl/wolfcrypt/src/chacha20_poly1305.c  .generated_files/flags/default/48b3d431b968793297ebec8a712a78cfdde14850 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/chacha20_poly1305.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/chacha20_poly1305.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/chacha20_poly1305.o.d" -o ${OBJECTDIR}/_ext/1716827871/chacha20_poly1305.o ../src/third_party/wolfssl/wolfcrypt/src/chacha20_poly1305.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/sp_cortexm.o: ../src/third_party/wolfssl/wolfcrypt/src/sp_cortexm.c  .generated_files/flags/default/3753b991f20a9c41ede729cb9f33b758e0a5f3d8 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sp_cortexm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sp_cortexm.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/sp_cortexm.o.d" -o ${OBJECTDIR}/_ext/1716827871/sp_cortexm.o ../src/third_party/wolfssl/wolfcrypt/src/sp_cortexm.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/srp.o: ../src/third_party/wolfssl/wolfcrypt/src/srp.c  .generated_files/flags/default/f52ee50c0830d62cff9f9ba5176e6cf376d58dee .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/srp.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/srp.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/srp.o.d" -o ${OBJECTDIR}/_ext/1716827871/srp.o ../src/third_party/wolfssl/wolfcrypt/src/srp.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/blake2b.o: ../src/third_party/wolfssl/wolfcrypt/src/blake2b.c  .generated_files/flags/default/9174109362974e56def3777af0044af9f0c855b9 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/blake2b.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/blake2b.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/blake2b.o.d" -o ${OBJECTDIR}/_ext/1716827871/blake2b.o ../src/third_party/wolfssl/wolfcrypt/src/blake2b.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/idea.o: ../src/third_party/wolfssl/wolfcrypt/src/idea.c  .generated_files/flags/default/4e0c04aa6114e509aa07ec1bd006f4228e16e966 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/idea.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/idea.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/idea.o.d" -o ${OBJECTDIR}/_ext/1716827871/idea.o ../src/third_party/wolfssl/wolfcrypt/src/idea.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/curve448.o: ../src/third_party/wolfssl/wolfcrypt/src/curve448.c  .generated_files/flags/default/e1d49d631a7e3c0f95d0123d138d8ffdd0ba7a1d .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/curve448.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/curve448.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/curve448.o.d" -o ${OBJECTDIR}/_ext/1716827871/curve448.o ../src/third_party/wolfssl/wolfcrypt/src/curve448.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/sp_int.o: ../src/third_party/wolfssl/wolfcrypt/src/sp_int.c  .generated_files/flags/default/d6c7da8b449ea5b2d40b30e05822349ab9f03268 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sp_int.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sp_int.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/sp_int.o.d" -o ${OBJECTDIR}/_ext/1716827871/sp_int.o ../src/third_party/wolfssl/wolfcrypt/src/sp_int.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/integer.o: ../src/third_party/wolfssl/wolfcrypt/src/integer.c  .generated_files/flags/default/7275c98a7c921afa550c2e116ddda411d3b9f2a9 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/integer.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/integer.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/integer.o.d" -o ${OBJECTDIR}/_ext/1716827871/integer.o ../src/third_party/wolfssl/wolfcrypt/src/integer.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/compress.o: ../src/third_party/wolfssl/wolfcrypt/src/compress.c  .generated_files/flags/default/4bf165627ae6bde6785f740df6fbbaa57a34c1ff .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/compress.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/compress.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/compress.o.d" -o ${OBJECTDIR}/_ext/1716827871/compress.o ../src/third_party/wolfssl/wolfcrypt/src/compress.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/memory.o: ../src/third_party/wolfssl/wolfcrypt/src/memory.c  .generated_files/flags/default/af668c2f064d5d59932d255b070dea36be5cd2ef .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/memory.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/memory.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/memory.o.d" -o ${OBJECTDIR}/_ext/1716827871/memory.o ../src/third_party/wolfssl/wolfcrypt/src/memory.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/cmac.o: ../src/third_party/wolfssl/wolfcrypt/src/cmac.c  .generated_files/flags/default/7c12ffeadcab5f0af614c2a3935e347a938ee72c .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/cmac.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/cmac.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/cmac.o.d" -o ${OBJECTDIR}/_ext/1716827871/cmac.o ../src/third_party/wolfssl/wolfcrypt/src/cmac.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/error.o: ../src/third_party/wolfssl/wolfcrypt/src/error.c  .generated_files/flags/default/38b936afc9c8bffed28da05a7d0f825c109fc722 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/error.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/error.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/error.o.d" -o ${OBJECTDIR}/_ext/1716827871/error.o ../src/third_party/wolfssl/wolfcrypt/src/error.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/poly1305.o: ../src/third_party/wolfssl/wolfcrypt/src/poly1305.c  .generated_files/flags/default/63faa63ecde6dd9aa92d2d97a9ef0cdbc405df5d .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/poly1305.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/poly1305.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/poly1305.o.d" -o ${OBJECTDIR}/_ext/1716827871/poly1305.o ../src/third_party/wolfssl/wolfcrypt/src/poly1305.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/blake2s.o: ../src/third_party/wolfssl/wolfcrypt/src/blake2s.c  .generated_files/flags/default/925bbb92a04a77c44be22c8e38a856675ad77675 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/blake2s.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/blake2s.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/blake2s.o.d" -o ${OBJECTDIR}/_ext/1716827871/blake2s.o ../src/third_party/wolfssl/wolfcrypt/src/blake2s.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/ripemd.o: ../src/third_party/wolfssl/wolfcrypt/src/ripemd.c  .generated_files/flags/default/504c0ddb4f064a0f36ed26c3f4f860a9b6323001 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/ripemd.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/ripemd.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/ripemd.o.d" -o ${OBJECTDIR}/_ext/1716827871/ripemd.o ../src/third_party/wolfssl/wolfcrypt/src/ripemd.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/rabbit.o: ../src/third_party/wolfssl/wolfcrypt/src/rabbit.c  .generated_files/flags/default/6b423ede4e55e3a5b3af4db0b0f96084d1a8f8eb .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/rabbit.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/rabbit.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/rabbit.o.d" -o ${OBJECTDIR}/_ext/1716827871/rabbit.o ../src/third_party/wolfssl/wolfcrypt/src/rabbit.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/sp_c32.o: ../src/third_party/wolfssl/wolfcrypt/src/sp_c32.c  .generated_files/flags/default/d8444e18dcbe9b257a4bb6ce68f60217cd111356 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sp_c32.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sp_c32.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/sp_c32.o.d" -o ${OBJECTDIR}/_ext/1716827871/sp_c32.o ../src/third_party/wolfssl/wolfcrypt/src/sp_c32.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/ed25519.o: ../src/third_party/wolfssl/wolfcrypt/src/ed25519.c  .generated_files/flags/default/b953539933da8d0b273ffd9d5f1c87702f85325c .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/ed25519.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/ed25519.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/ed25519.o.d" -o ${OBJECTDIR}/_ext/1716827871/ed25519.o ../src/third_party/wolfssl/wolfcrypt/src/ed25519.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/fe_448.o: ../src/third_party/wolfssl/wolfcrypt/src/fe_448.c  .generated_files/flags/default/75c5be2bc28faa7b67959d38576547f24e973a17 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/fe_448.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/fe_448.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/fe_448.o.d" -o ${OBJECTDIR}/_ext/1716827871/fe_448.o ../src/third_party/wolfssl/wolfcrypt/src/fe_448.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/rc2.o: ../src/third_party/wolfssl/wolfcrypt/src/rc2.c  .generated_files/flags/default/b89d98b36e95e104642c921bc71b5361d4ca1b52 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/rc2.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/rc2.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/rc2.o.d" -o ${OBJECTDIR}/_ext/1716827871/rc2.o ../src/third_party/wolfssl/wolfcrypt/src/rc2.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/hash.o: ../src/third_party/wolfssl/wolfcrypt/src/hash.c  .generated_files/flags/default/658d4d7831fbecfd0b339e4f647d71ea7d0dba1b .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/hash.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/hash.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/hash.o.d" -o ${OBJECTDIR}/_ext/1716827871/hash.o ../src/third_party/wolfssl/wolfcrypt/src/hash.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/dh.o: ../src/third_party/wolfssl/wolfcrypt/src/dh.c  .generated_files/flags/default/70aea35be2de033ed873b37ff36355b9f7625d96 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/dh.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/dh.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/dh.o.d" -o ${OBJECTDIR}/_ext/1716827871/dh.o ../src/third_party/wolfssl/wolfcrypt/src/dh.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/logging.o: ../src/third_party/wolfssl/wolfcrypt/src/logging.c  .generated_files/flags/default/cd9a8e0a9726ac20670bdaacfc0897bb65876a6c .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/logging.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/logging.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/logging.o.d" -o ${OBJECTDIR}/_ext/1716827871/logging.o ../src/third_party/wolfssl/wolfcrypt/src/logging.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/sp_arm64.o: ../src/third_party/wolfssl/wolfcrypt/src/sp_arm64.c  .generated_files/flags/default/1562c5a5bc7aba7c8904b4466e0f74f022d68a5 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sp_arm64.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sp_arm64.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/sp_arm64.o.d" -o ${OBJECTDIR}/_ext/1716827871/sp_arm64.o ../src/third_party/wolfssl/wolfcrypt/src/sp_arm64.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/des3.o: ../src/third_party/wolfssl/wolfcrypt/src/des3.c  .generated_files/flags/default/4ed50599da2d9f3131afbee5c32f681519c69106 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/des3.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/des3.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/des3.o.d" -o ${OBJECTDIR}/_ext/1716827871/des3.o ../src/third_party/wolfssl/wolfcrypt/src/des3.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/camellia.o: ../src/third_party/wolfssl/wolfcrypt/src/camellia.c  .generated_files/flags/default/87ee63b7dfde7e5eecd79b3d17b251f3ded57a51 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/camellia.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/camellia.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/camellia.o.d" -o ${OBJECTDIR}/_ext/1716827871/camellia.o ../src/third_party/wolfssl/wolfcrypt/src/camellia.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/sha.o: ../src/third_party/wolfssl/wolfcrypt/src/sha.c  .generated_files/flags/default/8205e60d7536fa483b0b6dff2e041f54a6fd1be6 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sha.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sha.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/sha.o.d" -o ${OBJECTDIR}/_ext/1716827871/sha.o ../src/third_party/wolfssl/wolfcrypt/src/sha.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/wc_pkcs11.o: ../src/third_party/wolfssl/wolfcrypt/src/wc_pkcs11.c  .generated_files/flags/default/8852ce46d07cf8278343169304c908f922fc392b .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/wc_pkcs11.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/wc_pkcs11.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/wc_pkcs11.o.d" -o ${OBJECTDIR}/_ext/1716827871/wc_pkcs11.o ../src/third_party/wolfssl/wolfcrypt/src/wc_pkcs11.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/hc128.o: ../src/third_party/wolfssl/wolfcrypt/src/hc128.c  .generated_files/flags/default/b6deedcab2f4676f6b516064d101daf0ea01be2b .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/hc128.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/hc128.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/hc128.o.d" -o ${OBJECTDIR}/_ext/1716827871/hc128.o ../src/third_party/wolfssl/wolfcrypt/src/hc128.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/chacha.o: ../src/third_party/wolfssl/wolfcrypt/src/chacha.c  .generated_files/flags/default/f2bb6cc9b6072c94ee498c8810d15f5d43745760 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/chacha.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/chacha.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/chacha.o.d" -o ${OBJECTDIR}/_ext/1716827871/chacha.o ../src/third_party/wolfssl/wolfcrypt/src/chacha.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/pwdbased.o: ../src/third_party/wolfssl/wolfcrypt/src/pwdbased.c  .generated_files/flags/default/493a46932c34fe70dbbe61ad4faede515b283269 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/pwdbased.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/pwdbased.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/pwdbased.o.d" -o ${OBJECTDIR}/_ext/1716827871/pwdbased.o ../src/third_party/wolfssl/wolfcrypt/src/pwdbased.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/coding.o: ../src/third_party/wolfssl/wolfcrypt/src/coding.c  .generated_files/flags/default/931526d7abcf645b1e92b70ded1c2a1099429798 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/coding.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/coding.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/coding.o.d" -o ${OBJECTDIR}/_ext/1716827871/coding.o ../src/third_party/wolfssl/wolfcrypt/src/coding.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/wc_port.o: ../src/third_party/wolfssl/wolfcrypt/src/wc_port.c  .generated_files/flags/default/7b1e7d265402ca77879eb18785dc067086fe88a .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/wc_port.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/wc_port.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/wc_port.o.d" -o ${OBJECTDIR}/_ext/1716827871/wc_port.o ../src/third_party/wolfssl/wolfcrypt/src/wc_port.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/fe_low_mem.o: ../src/third_party/wolfssl/wolfcrypt/src/fe_low_mem.c  .generated_files/flags/default/1886e3510866bc1d0fec0c329baa57a65a1b11d4 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/fe_low_mem.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/fe_low_mem.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/fe_low_mem.o.d" -o ${OBJECTDIR}/_ext/1716827871/fe_low_mem.o ../src/third_party/wolfssl/wolfcrypt/src/fe_low_mem.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/ecc.o: ../src/third_party/wolfssl/wolfcrypt/src/ecc.c  .generated_files/flags/default/bd56e4312cf2d0fcd7fa2b9c7eea5b505f0798eb .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/ecc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/ecc.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/ecc.o.d" -o ${OBJECTDIR}/_ext/1716827871/ecc.o ../src/third_party/wolfssl/wolfcrypt/src/ecc.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/ge_low_mem.o: ../src/third_party/wolfssl/wolfcrypt/src/ge_low_mem.c  .generated_files/flags/default/1a8185cdc6969498472e3e350ed48575f5a021d3 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/ge_low_mem.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/ge_low_mem.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/ge_low_mem.o.d" -o ${OBJECTDIR}/_ext/1716827871/ge_low_mem.o ../src/third_party/wolfssl/wolfcrypt/src/ge_low_mem.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/asn.o: ../src/third_party/wolfssl/wolfcrypt/src/asn.c  .generated_files/flags/default/2d49113060936f4ab6c00730d76f167b0ce29564 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/asn.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/asn.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/asn.o.d" -o ${OBJECTDIR}/_ext/1716827871/asn.o ../src/third_party/wolfssl/wolfcrypt/src/asn.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/ge_operations.o: ../src/third_party/wolfssl/wolfcrypt/src/ge_operations.c  .generated_files/flags/default/ff852ae4323ce117b8edb83b8f0055d24fbc190d .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/ge_operations.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/ge_operations.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/ge_operations.o.d" -o ${OBJECTDIR}/_ext/1716827871/ge_operations.o ../src/third_party/wolfssl/wolfcrypt/src/ge_operations.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/curve25519.o: ../src/third_party/wolfssl/wolfcrypt/src/curve25519.c  .generated_files/flags/default/4ddb0833562c4f586a606ed78f3563c8449433ad .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/curve25519.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/curve25519.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/curve25519.o.d" -o ${OBJECTDIR}/_ext/1716827871/curve25519.o ../src/third_party/wolfssl/wolfcrypt/src/curve25519.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/sp_arm32.o: ../src/third_party/wolfssl/wolfcrypt/src/sp_arm32.c  .generated_files/flags/default/538fc379fbb14367fec679fec970a85df04fdd04 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sp_arm32.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sp_arm32.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/sp_arm32.o.d" -o ${OBJECTDIR}/_ext/1716827871/sp_arm32.o ../src/third_party/wolfssl/wolfcrypt/src/sp_arm32.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/wolfmath.o: ../src/third_party/wolfssl/wolfcrypt/src/wolfmath.c  .generated_files/flags/default/fccb3bae4dcdfd63ba315b12d28990a6445eccf9 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/wolfmath.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/wolfmath.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/wolfmath.o.d" -o ${OBJECTDIR}/_ext/1716827871/wolfmath.o ../src/third_party/wolfssl/wolfcrypt/src/wolfmath.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/sha3.o: ../src/third_party/wolfssl/wolfcrypt/src/sha3.c  .generated_files/flags/default/7458a6f001aa24498130155a692cadcdbd0cc1a2 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sha3.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sha3.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/sha3.o.d" -o ${OBJECTDIR}/_ext/1716827871/sha3.o ../src/third_party/wolfssl/wolfcrypt/src/sha3.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/cryptocb.o: ../src/third_party/wolfssl/wolfcrypt/src/cryptocb.c  .generated_files/flags/default/f6a6d04f91a229c59e1c05388a1c4c52efe11e6d .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/cryptocb.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/cryptocb.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/cryptocb.o.d" -o ${OBJECTDIR}/_ext/1716827871/cryptocb.o ../src/third_party/wolfssl/wolfcrypt/src/cryptocb.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/pkcs12.o: ../src/third_party/wolfssl/wolfcrypt/src/pkcs12.c  .generated_files/flags/default/13f723f3758eddf4e9f066358c3744bf5274258d .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/pkcs12.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/pkcs12.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/pkcs12.o.d" -o ${OBJECTDIR}/_ext/1716827871/pkcs12.o ../src/third_party/wolfssl/wolfcrypt/src/pkcs12.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/sha512.o: ../src/third_party/wolfssl/wolfcrypt/src/sha512.c  .generated_files/flags/default/9abefb3cf37b6d2d30da81ce3a6d5871b9aa750d .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sha512.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sha512.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/sha512.o.d" -o ${OBJECTDIR}/_ext/1716827871/sha512.o ../src/third_party/wolfssl/wolfcrypt/src/sha512.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/md5.o: ../src/third_party/wolfssl/wolfcrypt/src/md5.c  .generated_files/flags/default/8c6a933aa918d02575b9eb15029f18e98471fa69 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/md5.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/md5.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/md5.o.d" -o ${OBJECTDIR}/_ext/1716827871/md5.o ../src/third_party/wolfssl/wolfcrypt/src/md5.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/rsa.o: ../src/third_party/wolfssl/wolfcrypt/src/rsa.c  .generated_files/flags/default/c99490b7bde159a940230d812a1be0f776fb7092 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/rsa.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/rsa.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/rsa.o.d" -o ${OBJECTDIR}/_ext/1716827871/rsa.o ../src/third_party/wolfssl/wolfcrypt/src/rsa.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/wolfevent.o: ../src/third_party/wolfssl/wolfcrypt/src/wolfevent.c  .generated_files/flags/default/4b608d4247faef735e76204918f5e55a6efe8b74 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/wolfevent.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/wolfevent.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/wolfevent.o.d" -o ${OBJECTDIR}/_ext/1716827871/wolfevent.o ../src/third_party/wolfssl/wolfcrypt/src/wolfevent.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/asm.o: ../src/third_party/wolfssl/wolfcrypt/src/asm.c  .generated_files/flags/default/68cacc49c41f72a1c3d00f403a351abe0a74baa6 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/asm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/asm.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/asm.o.d" -o ${OBJECTDIR}/_ext/1716827871/asm.o ../src/third_party/wolfssl/wolfcrypt/src/asm.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/cpuid.o: ../src/third_party/wolfssl/wolfcrypt/src/cpuid.c  .generated_files/flags/default/ff55d3b1075bf6c93c0ea285ec6d9c19be763375 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/cpuid.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/cpuid.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/cpuid.o.d" -o ${OBJECTDIR}/_ext/1716827871/cpuid.o ../src/third_party/wolfssl/wolfcrypt/src/cpuid.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/md4.o: ../src/third_party/wolfssl/wolfcrypt/src/md4.c  .generated_files/flags/default/d375b1faae0ed943b8ea03b018ba530ff9faa941 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/md4.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/md4.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/md4.o.d" -o ${OBJECTDIR}/_ext/1716827871/md4.o ../src/third_party/wolfssl/wolfcrypt/src/md4.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/aes.o: ../src/third_party/wolfssl/wolfcrypt/src/aes.c  .generated_files/flags/default/3c06a51c8bb13cf412f89e3ea621a74037f397ac .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/aes.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/aes.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/aes.o.d" -o ${OBJECTDIR}/_ext/1716827871/aes.o ../src/third_party/wolfssl/wolfcrypt/src/aes.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/wc_dsp.o: ../src/third_party/wolfssl/wolfcrypt/src/wc_dsp.c  .generated_files/flags/default/f3a6fb30d4d5fe1a616d6b995448e9b4707df214 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/wc_dsp.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/wc_dsp.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/wc_dsp.o.d" -o ${OBJECTDIR}/_ext/1716827871/wc_dsp.o ../src/third_party/wolfssl/wolfcrypt/src/wc_dsp.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/ge_448.o: ../src/third_party/wolfssl/wolfcrypt/src/ge_448.c  .generated_files/flags/default/c49dfc6f94dc35e6b178101963df49b0c7931919 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/ge_448.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/ge_448.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/ge_448.o.d" -o ${OBJECTDIR}/_ext/1716827871/ge_448.o ../src/third_party/wolfssl/wolfcrypt/src/ge_448.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/dsa.o: ../src/third_party/wolfssl/wolfcrypt/src/dsa.c  .generated_files/flags/default/a543208de7f45753b943bcb0fd3a28d11629c49f .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/dsa.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/dsa.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/dsa.o.d" -o ${OBJECTDIR}/_ext/1716827871/dsa.o ../src/third_party/wolfssl/wolfcrypt/src/dsa.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/arc4.o: ../src/third_party/wolfssl/wolfcrypt/src/arc4.c  .generated_files/flags/default/9861d807044f6522046676ddee23bc332e7907f7 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/arc4.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/arc4.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/arc4.o.d" -o ${OBJECTDIR}/_ext/1716827871/arc4.o ../src/third_party/wolfssl/wolfcrypt/src/arc4.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/ecc_fp.o: ../src/third_party/wolfssl/wolfcrypt/src/ecc_fp.c  .generated_files/flags/default/3f662176556dbe776bd7562bc876a70048dc53d6 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/ecc_fp.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/ecc_fp.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/ecc_fp.o.d" -o ${OBJECTDIR}/_ext/1716827871/ecc_fp.o ../src/third_party/wolfssl/wolfcrypt/src/ecc_fp.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/sp_dsp32.o: ../src/third_party/wolfssl/wolfcrypt/src/sp_dsp32.c  .generated_files/flags/default/7124383dcd2447643e89aaa9d91e864282fda8e5 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sp_dsp32.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sp_dsp32.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/sp_dsp32.o.d" -o ${OBJECTDIR}/_ext/1716827871/sp_dsp32.o ../src/third_party/wolfssl/wolfcrypt/src/sp_dsp32.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/fe_operations.o: ../src/third_party/wolfssl/wolfcrypt/src/fe_operations.c  .generated_files/flags/default/e0590a8c400703f92fe354e22d43fdf05f5950ec .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/fe_operations.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/fe_operations.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/fe_operations.o.d" -o ${OBJECTDIR}/_ext/1716827871/fe_operations.o ../src/third_party/wolfssl/wolfcrypt/src/fe_operations.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/sp_x86_64.o: ../src/third_party/wolfssl/wolfcrypt/src/sp_x86_64.c  .generated_files/flags/default/77844031b8f73a7d1035c3bfad9ac9decfea1655 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sp_x86_64.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sp_x86_64.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/sp_x86_64.o.d" -o ${OBJECTDIR}/_ext/1716827871/sp_x86_64.o ../src/third_party/wolfssl/wolfcrypt/src/sp_x86_64.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/sp_armthumb.o: ../src/third_party/wolfssl/wolfcrypt/src/sp_armthumb.c  .generated_files/flags/default/937c65d36669c0eab816df4c6b7f78168d0e00b5 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sp_armthumb.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sp_armthumb.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/sp_armthumb.o.d" -o ${OBJECTDIR}/_ext/1716827871/sp_armthumb.o ../src/third_party/wolfssl/wolfcrypt/src/sp_armthumb.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/signature.o: ../src/third_party/wolfssl/wolfcrypt/src/signature.c  .generated_files/flags/default/a88834e2e25ba8126cd5cbb5745d778d1f8297b5 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/signature.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/signature.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/signature.o.d" -o ${OBJECTDIR}/_ext/1716827871/signature.o ../src/third_party/wolfssl/wolfcrypt/src/signature.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/sha256.o: ../src/third_party/wolfssl/wolfcrypt/src/sha256.c  .generated_files/flags/default/39e2aa9d66ef1cf1d03401e112e657a21afa7413 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sha256.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sha256.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/sha256.o.d" -o ${OBJECTDIR}/_ext/1716827871/sha256.o ../src/third_party/wolfssl/wolfcrypt/src/sha256.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/sp_c64.o: ../src/third_party/wolfssl/wolfcrypt/src/sp_c64.c  .generated_files/flags/default/9c8a020ea1dd3c5c769225396c2e8d827593159b .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sp_c64.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sp_c64.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/sp_c64.o.d" -o ${OBJECTDIR}/_ext/1716827871/sp_c64.o ../src/third_party/wolfssl/wolfcrypt/src/sp_c64.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/md2.o: ../src/third_party/wolfssl/wolfcrypt/src/md2.c  .generated_files/flags/default/afb477b87b92c0bc8a1102e69547dc7a51afe233 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/md2.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/md2.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/md2.o.d" -o ${OBJECTDIR}/_ext/1716827871/md2.o ../src/third_party/wolfssl/wolfcrypt/src/md2.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/hmac.o: ../src/third_party/wolfssl/wolfcrypt/src/hmac.c  .generated_files/flags/default/4eb6ff57f02ec2b5d5b963658aefbedfa4452699 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/hmac.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/hmac.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/hmac.o.d" -o ${OBJECTDIR}/_ext/1716827871/hmac.o ../src/third_party/wolfssl/wolfcrypt/src/hmac.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1664057780/misc.o: ../src/third_party/wolfssl/wolfssl/wolfcrypt/src/misc.c  .generated_files/flags/default/f13aba71461ed6d1da71ea4eaf34bde89cfaae3e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1664057780" 
	@${RM} ${OBJECTDIR}/_ext/1664057780/misc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1664057780/misc.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1664057780/misc.o.d" -o ${OBJECTDIR}/_ext/1664057780/misc.o ../src/third_party/wolfssl/wolfssl/wolfcrypt/src/misc.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1664057780/evp.o: ../src/third_party/wolfssl/wolfssl/wolfcrypt/src/evp.c  .generated_files/flags/default/a5b3c3a17c10aa4fff0e4de0f45cb53c99dbc603 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1664057780" 
	@${RM} ${OBJECTDIR}/_ext/1664057780/evp.o.d 
	@${RM} ${OBJECTDIR}/_ext/1664057780/evp.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1664057780/evp.o.d" -o ${OBJECTDIR}/_ext/1664057780/evp.o ../src/third_party/wolfssl/wolfssl/wolfcrypt/src/evp.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/main.o: ../src/main.c  .generated_files/flags/default/f2bcac965c4ad8621b240c0a2e6c920d2c9f86f4 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/main.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/main.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/main.o.d" -o ${OBJECTDIR}/_ext/1360937237/main.o ../src/main.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/app.o: ../src/app.c  .generated_files/flags/default/9568e307b512666263b765cf9baa9a91380108c2 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/app.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/app.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/app.o.d" -o ${OBJECTDIR}/_ext/1360937237/app.o ../src/app.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/app_layer.o: ../src/app_layer.c  .generated_files/flags/default/6e19e30f69b61184b5917c0b6f62a651cf14beb2 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/app_layer.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/app_layer.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/app_layer.o.d" -o ${OBJECTDIR}/_ext/1360937237/app_layer.o ../src/app_layer.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1803285470/crc.o: C:/microchip/harmony/Apps/Docs/Devices/Smart\ Energy/Lib\ development/src/crc.c  .generated_files/flags/default/35ff71dfe6b935aa7fe65d1b794a7878b757f966 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1803285470" 
	@${RM} ${OBJECTDIR}/_ext/1803285470/crc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1803285470/crc.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1803285470/crc.o.d" -o ${OBJECTDIR}/_ext/1803285470/crc.o "C:/microchip/harmony/Apps/Docs/Devices/Smart Energy/Lib development/src/crc.c"    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
else
${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Aead_WolfCryptWrapper.o: ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Aead_WolfCryptWrapper.c  .generated_files/flags/default/eca704fd8e1cf9daf314d8ab34a1d211ce53878c .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1726652707" 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Aead_WolfCryptWrapper.o.d 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Aead_WolfCryptWrapper.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Aead_WolfCryptWrapper.o.d" -o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Aead_WolfCryptWrapper.o ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Aead_WolfCryptWrapper.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Hash.o: ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Hash.c  .generated_files/flags/default/676b56fd0cf6048db32c46d4ba0efecd26775de4 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1726652707" 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Hash.o.d 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Hash.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Hash.o.d" -o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Hash.o ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Hash.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_DigSign_WolfcryptWrapper.o: ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_DigSign_WolfcryptWrapper.c  .generated_files/flags/default/d1d94fc2745c787d678a9287c211b6bd016a9542 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1726652707" 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_DigSign_WolfcryptWrapper.o.d 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_DigSign_WolfcryptWrapper.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_DigSign_WolfcryptWrapper.o.d" -o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_DigSign_WolfcryptWrapper.o ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_DigSign_WolfcryptWrapper.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Hash_WolfcryptWrapper.o: ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Hash_WolfcryptWrapper.c  .generated_files/flags/default/6647f4ffeffba67848010dc88ab92994b3b176e0 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1726652707" 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Hash_WolfcryptWrapper.o.d 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Hash_WolfcryptWrapper.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Hash_WolfcryptWrapper.o.d" -o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Hash_WolfcryptWrapper.o ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Hash_WolfcryptWrapper.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_RNG.o: ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_RNG.c  .generated_files/flags/default/7fdd8fa2f150a41fa2f2f878472ec96d22defb4e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1726652707" 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_RNG.o.d 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_RNG.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_RNG.o.d" -o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_RNG.o ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_RNG.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Sym_WolfcryptWrapper.o: ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Sym_WolfcryptWrapper.c  .generated_files/flags/default/8d209088a94c66d7822f424752fdc13be25bc84e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1726652707" 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Sym_WolfcryptWrapper.o.d 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Sym_WolfcryptWrapper.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Sym_WolfcryptWrapper.o.d" -o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Sym_WolfcryptWrapper.o ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Sym_WolfcryptWrapper.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Aead_Cipher.o: ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Aead_Cipher.c  .generated_files/flags/default/e39bc74d13b0a502bb6b18b415c57cae2fd6d45d .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1726652707" 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Aead_Cipher.o.d 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Aead_Cipher.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Aead_Cipher.o.d" -o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Aead_Cipher.o ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Aead_Cipher.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Mac_WolfCryptWrapper.o: ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Mac_WolfCryptWrapper.c  .generated_files/flags/default/206831332bf7411cc37e8e1d685b10a66ce517d7 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1726652707" 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Mac_WolfCryptWrapper.o.d 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Mac_WolfCryptWrapper.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Mac_WolfCryptWrapper.o.d" -o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Mac_WolfCryptWrapper.o ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Mac_WolfCryptWrapper.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_RNG_WolfcryptWrapper.o: ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_RNG_WolfcryptWrapper.c  .generated_files/flags/default/e48b8ea8581e30685fef33fbef2276c280f1e5c3 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1726652707" 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_RNG_WolfcryptWrapper.o.d 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_RNG_WolfcryptWrapper.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_RNG_WolfcryptWrapper.o.d" -o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_RNG_WolfcryptWrapper.o ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_RNG_WolfcryptWrapper.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_DigSign.o: ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_DigSign.c  .generated_files/flags/default/ba1fb6701cc7e5b8dc1e9bd62daba0db4aa7ac32 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1726652707" 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_DigSign.o.d 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_DigSign.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_DigSign.o.d" -o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_DigSign.o ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_DigSign.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Sym_Cipher.o: ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Sym_Cipher.c  .generated_files/flags/default/a3f67391a96b6e0a6376f21b2cee7feb4382a896 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1726652707" 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Sym_Cipher.o.d 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Sym_Cipher.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Sym_Cipher.o.d" -o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Sym_Cipher.o ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Sym_Cipher.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Kas_WolfcryptWrapper.o: ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Kas_WolfcryptWrapper.c  .generated_files/flags/default/9e8898d71ff84b6e5cfeabd571a5d162d03d9bc5 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1726652707" 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Kas_WolfcryptWrapper.o.d 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Kas_WolfcryptWrapper.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Kas_WolfcryptWrapper.o.d" -o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Kas_WolfcryptWrapper.o ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Kas_WolfcryptWrapper.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Mac_Cipher.o: ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Mac_Cipher.c  .generated_files/flags/default/2ab8f6658e59006a9efa3570e2d80a22cd7b3c02 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1726652707" 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Mac_Cipher.o.d 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Mac_Cipher.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Mac_Cipher.o.d" -o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Mac_Cipher.o ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Mac_Cipher.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Kas.o: ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Kas.c  .generated_files/flags/default/21b931bbda1022febe3abc139e4567d1d9c53439 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1726652707" 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Kas.o.d 
	@${RM} ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Kas.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Kas.o.d" -o ${OBJECTDIR}/_ext/1726652707/MCHP_Crypto_Kas.o ../src/config/default/crypto/common_crypto/src/MCHP_Crypto_Kas.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/60165520/plib_clk.o: ../src/config/default/peripheral/clk/plib_clk.c  .generated_files/flags/default/20d22bd74d331fef7c7f48377458348a2c4e72bb .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/60165520" 
	@${RM} ${OBJECTDIR}/_ext/60165520/plib_clk.o.d 
	@${RM} ${OBJECTDIR}/_ext/60165520/plib_clk.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/60165520/plib_clk.o.d" -o ${OBJECTDIR}/_ext/60165520/plib_clk.o ../src/config/default/peripheral/clk/plib_clk.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1865131932/plib_cmcc.o: ../src/config/default/peripheral/cmcc/plib_cmcc.c  .generated_files/flags/default/89cf8dedb56821626150e77fbf3ff715e30e48f3 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1865131932" 
	@${RM} ${OBJECTDIR}/_ext/1865131932/plib_cmcc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1865131932/plib_cmcc.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1865131932/plib_cmcc.o.d" -o ${OBJECTDIR}/_ext/1865131932/plib_cmcc.o ../src/config/default/peripheral/cmcc/plib_cmcc.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1865171381/plib_dwdt.o: ../src/config/default/peripheral/dwdt/plib_dwdt.c  .generated_files/flags/default/f40f374ee0118db6ca9efbc0770a231b8ea21988 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1865171381" 
	@${RM} ${OBJECTDIR}/_ext/1865171381/plib_dwdt.o.d 
	@${RM} ${OBJECTDIR}/_ext/1865171381/plib_dwdt.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1865171381/plib_dwdt.o.d" -o ${OBJECTDIR}/_ext/1865171381/plib_dwdt.o ../src/config/default/peripheral/dwdt/plib_dwdt.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1865468468/plib_nvic.o: ../src/config/default/peripheral/nvic/plib_nvic.c  .generated_files/flags/default/53758fb9f1f5971f712be0ab59df33038e05b2cb .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1865468468" 
	@${RM} ${OBJECTDIR}/_ext/1865468468/plib_nvic.o.d 
	@${RM} ${OBJECTDIR}/_ext/1865468468/plib_nvic.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1865468468/plib_nvic.o.d" -o ${OBJECTDIR}/_ext/1865468468/plib_nvic.o ../src/config/default/peripheral/nvic/plib_nvic.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/60177924/plib_pio.o: ../src/config/default/peripheral/pio/plib_pio.c  .generated_files/flags/default/e30e68b31957458de8c4b5d11c774b432794a481 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/60177924" 
	@${RM} ${OBJECTDIR}/_ext/60177924/plib_pio.o.d 
	@${RM} ${OBJECTDIR}/_ext/60177924/plib_pio.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/60177924/plib_pio.o.d" -o ${OBJECTDIR}/_ext/60177924/plib_pio.o ../src/config/default/peripheral/pio/plib_pio.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1865585090/plib_rstc.o: ../src/config/default/peripheral/rstc/plib_rstc.c  .generated_files/flags/default/187201258d9d3406f2823bb1c8493119adaad1de .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1865585090" 
	@${RM} ${OBJECTDIR}/_ext/1865585090/plib_rstc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1865585090/plib_rstc.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1865585090/plib_rstc.o.d" -o ${OBJECTDIR}/_ext/1865585090/plib_rstc.o ../src/config/default/peripheral/rstc/plib_rstc.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1865600993/plib_sefc0.o: ../src/config/default/peripheral/sefc/plib_sefc0.c  .generated_files/flags/default/f8d10cdf32fc53d72b1fe1c9c08ea77a16388ff9 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1865600993" 
	@${RM} ${OBJECTDIR}/_ext/1865600993/plib_sefc0.o.d 
	@${RM} ${OBJECTDIR}/_ext/1865600993/plib_sefc0.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1865600993/plib_sefc0.o.d" -o ${OBJECTDIR}/_ext/1865600993/plib_sefc0.o ../src/config/default/peripheral/sefc/plib_sefc0.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1865600993/plib_sefc1.o: ../src/config/default/peripheral/sefc/plib_sefc1.c  .generated_files/flags/default/8f5ec910efaa5b0d2a8064f0f4f504d01393fb1b .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1865600993" 
	@${RM} ${OBJECTDIR}/_ext/1865600993/plib_sefc1.o.d 
	@${RM} ${OBJECTDIR}/_ext/1865600993/plib_sefc1.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1865600993/plib_sefc1.o.d" -o ${OBJECTDIR}/_ext/1865600993/plib_sefc1.o ../src/config/default/peripheral/sefc/plib_sefc1.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1865616679/plib_supc.o: ../src/config/default/peripheral/supc/plib_supc.c  .generated_files/flags/default/e4963b8bbcd8b33100ada8133ad413e2374d9eb .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1865616679" 
	@${RM} ${OBJECTDIR}/_ext/1865616679/plib_supc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1865616679/plib_supc.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1865616679/plib_supc.o.d" -o ${OBJECTDIR}/_ext/1865616679/plib_supc.o ../src/config/default/peripheral/supc/plib_supc.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/829342655/plib_tc0.o: ../src/config/default/peripheral/tc/plib_tc0.c  .generated_files/flags/default/ceb2e4d465e00f879af32dca91eaca0b42b87c30 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/829342655" 
	@${RM} ${OBJECTDIR}/_ext/829342655/plib_tc0.o.d 
	@${RM} ${OBJECTDIR}/_ext/829342655/plib_tc0.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/829342655/plib_tc0.o.d" -o ${OBJECTDIR}/_ext/829342655/plib_tc0.o ../src/config/default/peripheral/tc/plib_tc0.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/163028504/xc32_monitor.o: ../src/config/default/stdio/xc32_monitor.c  .generated_files/flags/default/9e9f5933fc7cd9332013df155ce2c93ed9a8ef48 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/163028504" 
	@${RM} ${OBJECTDIR}/_ext/163028504/xc32_monitor.o.d 
	@${RM} ${OBJECTDIR}/_ext/163028504/xc32_monitor.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/163028504/xc32_monitor.o.d" -o ${OBJECTDIR}/_ext/163028504/xc32_monitor.o ../src/config/default/stdio/xc32_monitor.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1014039709/sys_cache.o: ../src/config/default/system/cache/sys_cache.c  .generated_files/flags/default/ea8faad9dbb59099d71e13e5762780dab64018d4 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1014039709" 
	@${RM} ${OBJECTDIR}/_ext/1014039709/sys_cache.o.d 
	@${RM} ${OBJECTDIR}/_ext/1014039709/sys_cache.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1014039709/sys_cache.o.d" -o ${OBJECTDIR}/_ext/1014039709/sys_cache.o ../src/config/default/system/cache/sys_cache.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1881668453/sys_int.o: ../src/config/default/system/int/src/sys_int.c  .generated_files/flags/default/6cf511679dbb036eb28f25e016145de98139b2fe .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1881668453" 
	@${RM} ${OBJECTDIR}/_ext/1881668453/sys_int.o.d 
	@${RM} ${OBJECTDIR}/_ext/1881668453/sys_int.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1881668453/sys_int.o.d" -o ${OBJECTDIR}/_ext/1881668453/sys_int.o ../src/config/default/system/int/src/sys_int.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/101884895/sys_time.o: ../src/config/default/system/time/src/sys_time.c  .generated_files/flags/default/6433e559342f2541900a097aaee57bf748e29ae9 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/101884895" 
	@${RM} ${OBJECTDIR}/_ext/101884895/sys_time.o.d 
	@${RM} ${OBJECTDIR}/_ext/101884895/sys_time.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/101884895/sys_time.o.d" -o ${OBJECTDIR}/_ext/101884895/sys_time.o ../src/config/default/system/time/src/sys_time.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1171490990/libc_syscalls.o: ../src/config/default/libc_syscalls.c  .generated_files/flags/default/f643f5a6f6d5655b660b51cbc056ccbc7c2b14ce .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1171490990" 
	@${RM} ${OBJECTDIR}/_ext/1171490990/libc_syscalls.o.d 
	@${RM} ${OBJECTDIR}/_ext/1171490990/libc_syscalls.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1171490990/libc_syscalls.o.d" -o ${OBJECTDIR}/_ext/1171490990/libc_syscalls.o ../src/config/default/libc_syscalls.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1171490990/interrupts.o: ../src/config/default/interrupts.c  .generated_files/flags/default/261fa5eb009d16d1428b5acee69a0ddb296bbbb8 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1171490990" 
	@${RM} ${OBJECTDIR}/_ext/1171490990/interrupts.o.d 
	@${RM} ${OBJECTDIR}/_ext/1171490990/interrupts.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1171490990/interrupts.o.d" -o ${OBJECTDIR}/_ext/1171490990/interrupts.o ../src/config/default/interrupts.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1171490990/exceptions.o: ../src/config/default/exceptions.c  .generated_files/flags/default/184083745070eeb2f5a934c8b74b2bd93cc66828 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1171490990" 
	@${RM} ${OBJECTDIR}/_ext/1171490990/exceptions.o.d 
	@${RM} ${OBJECTDIR}/_ext/1171490990/exceptions.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1171490990/exceptions.o.d" -o ${OBJECTDIR}/_ext/1171490990/exceptions.o ../src/config/default/exceptions.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1171490990/initialization.o: ../src/config/default/initialization.c  .generated_files/flags/default/334597272adbd08237d559a4aa1e802e25e0e9c6 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1171490990" 
	@${RM} ${OBJECTDIR}/_ext/1171490990/initialization.o.d 
	@${RM} ${OBJECTDIR}/_ext/1171490990/initialization.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1171490990/initialization.o.d" -o ${OBJECTDIR}/_ext/1171490990/initialization.o ../src/config/default/initialization.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1171490990/startup_xc32.o: ../src/config/default/startup_xc32.c  .generated_files/flags/default/cc1922095939c7f446e919d34f5fce86cb0e6128 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1171490990" 
	@${RM} ${OBJECTDIR}/_ext/1171490990/startup_xc32.o.d 
	@${RM} ${OBJECTDIR}/_ext/1171490990/startup_xc32.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1171490990/startup_xc32.o.d" -o ${OBJECTDIR}/_ext/1171490990/startup_xc32.o ../src/config/default/startup_xc32.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1171490990/tasks.o: ../src/config/default/tasks.c  .generated_files/flags/default/40aa0d98849ab5aab1d4624ff92ccef41ab04fa5 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1171490990" 
	@${RM} ${OBJECTDIR}/_ext/1171490990/tasks.o.d 
	@${RM} ${OBJECTDIR}/_ext/1171490990/tasks.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1171490990/tasks.o.d" -o ${OBJECTDIR}/_ext/1171490990/tasks.o ../src/config/default/tasks.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/193597431/pic32mz-crypt.o: ../src/third_party/wolfssl/wolfcrypt/src/port/pic32/pic32mz-crypt.c  .generated_files/flags/default/dce13fa7310e2c7002c8525b5b0d9d909238be9f .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/193597431" 
	@${RM} ${OBJECTDIR}/_ext/193597431/pic32mz-crypt.o.d 
	@${RM} ${OBJECTDIR}/_ext/193597431/pic32mz-crypt.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/193597431/pic32mz-crypt.o.d" -o ${OBJECTDIR}/_ext/193597431/pic32mz-crypt.o ../src/third_party/wolfssl/wolfcrypt/src/port/pic32/pic32mz-crypt.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/pkcs7.o: ../src/third_party/wolfssl/wolfcrypt/src/pkcs7.c  .generated_files/flags/default/c10e10711fccc3ab9d982e339b31a86195b4440 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/pkcs7.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/pkcs7.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/pkcs7.o.d" -o ${OBJECTDIR}/_ext/1716827871/pkcs7.o ../src/third_party/wolfssl/wolfcrypt/src/pkcs7.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/random.o: ../src/third_party/wolfssl/wolfcrypt/src/random.c  .generated_files/flags/default/d6d05f48c9388a26a75c0bedcc5cfe3ab43ba950 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/random.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/random.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/random.o.d" -o ${OBJECTDIR}/_ext/1716827871/random.o ../src/third_party/wolfssl/wolfcrypt/src/random.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/tfm.o: ../src/third_party/wolfssl/wolfcrypt/src/tfm.c  .generated_files/flags/default/307ce76a56b0959cc77855a11b5b528952fe0066 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/tfm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/tfm.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/tfm.o.d" -o ${OBJECTDIR}/_ext/1716827871/tfm.o ../src/third_party/wolfssl/wolfcrypt/src/tfm.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/wc_encrypt.o: ../src/third_party/wolfssl/wolfcrypt/src/wc_encrypt.c  .generated_files/flags/default/7c96f529a4f7969f252b23f511c461a8fc0cd90c .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/wc_encrypt.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/wc_encrypt.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/wc_encrypt.o.d" -o ${OBJECTDIR}/_ext/1716827871/wc_encrypt.o ../src/third_party/wolfssl/wolfcrypt/src/wc_encrypt.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/ed448.o: ../src/third_party/wolfssl/wolfcrypt/src/ed448.c  .generated_files/flags/default/62924de83fb0e44059f22e68f21e9169b0e3636c .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/ed448.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/ed448.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/ed448.o.d" -o ${OBJECTDIR}/_ext/1716827871/ed448.o ../src/third_party/wolfssl/wolfcrypt/src/ed448.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/chacha20_poly1305.o: ../src/third_party/wolfssl/wolfcrypt/src/chacha20_poly1305.c  .generated_files/flags/default/23ecd6b30eb6396d3a5f5545fa1de3e291c01f18 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/chacha20_poly1305.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/chacha20_poly1305.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/chacha20_poly1305.o.d" -o ${OBJECTDIR}/_ext/1716827871/chacha20_poly1305.o ../src/third_party/wolfssl/wolfcrypt/src/chacha20_poly1305.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/sp_cortexm.o: ../src/third_party/wolfssl/wolfcrypt/src/sp_cortexm.c  .generated_files/flags/default/a3f01ebda62326a39f20be45e272941629f0f5d5 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sp_cortexm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sp_cortexm.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/sp_cortexm.o.d" -o ${OBJECTDIR}/_ext/1716827871/sp_cortexm.o ../src/third_party/wolfssl/wolfcrypt/src/sp_cortexm.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/srp.o: ../src/third_party/wolfssl/wolfcrypt/src/srp.c  .generated_files/flags/default/2c4321d9af312f37d43865784b2db03be879eb42 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/srp.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/srp.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/srp.o.d" -o ${OBJECTDIR}/_ext/1716827871/srp.o ../src/third_party/wolfssl/wolfcrypt/src/srp.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/blake2b.o: ../src/third_party/wolfssl/wolfcrypt/src/blake2b.c  .generated_files/flags/default/3a58b6777a5ab4387a560244862c3d12e119131c .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/blake2b.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/blake2b.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/blake2b.o.d" -o ${OBJECTDIR}/_ext/1716827871/blake2b.o ../src/third_party/wolfssl/wolfcrypt/src/blake2b.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/idea.o: ../src/third_party/wolfssl/wolfcrypt/src/idea.c  .generated_files/flags/default/71be40354c38a20195078e01c203bd09fbc5043c .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/idea.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/idea.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/idea.o.d" -o ${OBJECTDIR}/_ext/1716827871/idea.o ../src/third_party/wolfssl/wolfcrypt/src/idea.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/curve448.o: ../src/third_party/wolfssl/wolfcrypt/src/curve448.c  .generated_files/flags/default/6a8d66b182fb3c578bcf34bba2af0c5801878ca0 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/curve448.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/curve448.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/curve448.o.d" -o ${OBJECTDIR}/_ext/1716827871/curve448.o ../src/third_party/wolfssl/wolfcrypt/src/curve448.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/sp_int.o: ../src/third_party/wolfssl/wolfcrypt/src/sp_int.c  .generated_files/flags/default/423caf038d2592491febde8cef1359af260ef53a .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sp_int.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sp_int.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/sp_int.o.d" -o ${OBJECTDIR}/_ext/1716827871/sp_int.o ../src/third_party/wolfssl/wolfcrypt/src/sp_int.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/integer.o: ../src/third_party/wolfssl/wolfcrypt/src/integer.c  .generated_files/flags/default/4ea8026fe8d9f113637256be65f894c81ec1cad .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/integer.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/integer.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/integer.o.d" -o ${OBJECTDIR}/_ext/1716827871/integer.o ../src/third_party/wolfssl/wolfcrypt/src/integer.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/compress.o: ../src/third_party/wolfssl/wolfcrypt/src/compress.c  .generated_files/flags/default/bcb027e8170d00c2129f1f13106a03d322f5e08c .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/compress.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/compress.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/compress.o.d" -o ${OBJECTDIR}/_ext/1716827871/compress.o ../src/third_party/wolfssl/wolfcrypt/src/compress.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/memory.o: ../src/third_party/wolfssl/wolfcrypt/src/memory.c  .generated_files/flags/default/1c218b943518d1eb4aa8898ee1da68eec56677af .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/memory.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/memory.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/memory.o.d" -o ${OBJECTDIR}/_ext/1716827871/memory.o ../src/third_party/wolfssl/wolfcrypt/src/memory.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/cmac.o: ../src/third_party/wolfssl/wolfcrypt/src/cmac.c  .generated_files/flags/default/d9af89656d28a3e9fc762aeea11ac2cf935bc688 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/cmac.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/cmac.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/cmac.o.d" -o ${OBJECTDIR}/_ext/1716827871/cmac.o ../src/third_party/wolfssl/wolfcrypt/src/cmac.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/error.o: ../src/third_party/wolfssl/wolfcrypt/src/error.c  .generated_files/flags/default/8f2abd6fab67dd105f03b5a5684da9134878a86e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/error.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/error.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/error.o.d" -o ${OBJECTDIR}/_ext/1716827871/error.o ../src/third_party/wolfssl/wolfcrypt/src/error.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/poly1305.o: ../src/third_party/wolfssl/wolfcrypt/src/poly1305.c  .generated_files/flags/default/3be4494d89d4714f3ebf7775e8ea2003dbb8a223 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/poly1305.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/poly1305.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/poly1305.o.d" -o ${OBJECTDIR}/_ext/1716827871/poly1305.o ../src/third_party/wolfssl/wolfcrypt/src/poly1305.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/blake2s.o: ../src/third_party/wolfssl/wolfcrypt/src/blake2s.c  .generated_files/flags/default/929ee935f997e3572634e8a939cbbd92bd46439 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/blake2s.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/blake2s.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/blake2s.o.d" -o ${OBJECTDIR}/_ext/1716827871/blake2s.o ../src/third_party/wolfssl/wolfcrypt/src/blake2s.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/ripemd.o: ../src/third_party/wolfssl/wolfcrypt/src/ripemd.c  .generated_files/flags/default/4b65f2f8d83a117ab677e58842437eae66ae7479 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/ripemd.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/ripemd.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/ripemd.o.d" -o ${OBJECTDIR}/_ext/1716827871/ripemd.o ../src/third_party/wolfssl/wolfcrypt/src/ripemd.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/rabbit.o: ../src/third_party/wolfssl/wolfcrypt/src/rabbit.c  .generated_files/flags/default/443bf674f1639bb8db69c160db571595200dc325 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/rabbit.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/rabbit.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/rabbit.o.d" -o ${OBJECTDIR}/_ext/1716827871/rabbit.o ../src/third_party/wolfssl/wolfcrypt/src/rabbit.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/sp_c32.o: ../src/third_party/wolfssl/wolfcrypt/src/sp_c32.c  .generated_files/flags/default/6d45c30f41309dc55cd688b16e74f051b578487 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sp_c32.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sp_c32.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/sp_c32.o.d" -o ${OBJECTDIR}/_ext/1716827871/sp_c32.o ../src/third_party/wolfssl/wolfcrypt/src/sp_c32.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/ed25519.o: ../src/third_party/wolfssl/wolfcrypt/src/ed25519.c  .generated_files/flags/default/f955c2a3608ad55c1739e23ac504eb47d2b71c79 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/ed25519.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/ed25519.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/ed25519.o.d" -o ${OBJECTDIR}/_ext/1716827871/ed25519.o ../src/third_party/wolfssl/wolfcrypt/src/ed25519.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/fe_448.o: ../src/third_party/wolfssl/wolfcrypt/src/fe_448.c  .generated_files/flags/default/8c5e82f58c289edc1f932ad11aea1d17b471b225 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/fe_448.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/fe_448.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/fe_448.o.d" -o ${OBJECTDIR}/_ext/1716827871/fe_448.o ../src/third_party/wolfssl/wolfcrypt/src/fe_448.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/rc2.o: ../src/third_party/wolfssl/wolfcrypt/src/rc2.c  .generated_files/flags/default/5c83c209975f64257611040d0da5126e66984fc6 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/rc2.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/rc2.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/rc2.o.d" -o ${OBJECTDIR}/_ext/1716827871/rc2.o ../src/third_party/wolfssl/wolfcrypt/src/rc2.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/hash.o: ../src/third_party/wolfssl/wolfcrypt/src/hash.c  .generated_files/flags/default/b7711d29bf4010ca95a44870df89b49a14c2f1ba .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/hash.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/hash.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/hash.o.d" -o ${OBJECTDIR}/_ext/1716827871/hash.o ../src/third_party/wolfssl/wolfcrypt/src/hash.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/dh.o: ../src/third_party/wolfssl/wolfcrypt/src/dh.c  .generated_files/flags/default/52a04607f07c1fbd4a21eb24578c41210b3eb9f5 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/dh.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/dh.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/dh.o.d" -o ${OBJECTDIR}/_ext/1716827871/dh.o ../src/third_party/wolfssl/wolfcrypt/src/dh.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/logging.o: ../src/third_party/wolfssl/wolfcrypt/src/logging.c  .generated_files/flags/default/a63a563c055cb2e370616fb9afbec42d05cd25d6 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/logging.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/logging.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/logging.o.d" -o ${OBJECTDIR}/_ext/1716827871/logging.o ../src/third_party/wolfssl/wolfcrypt/src/logging.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/sp_arm64.o: ../src/third_party/wolfssl/wolfcrypt/src/sp_arm64.c  .generated_files/flags/default/2aceff25d74c1632048ab05a1bb26743496a1051 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sp_arm64.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sp_arm64.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/sp_arm64.o.d" -o ${OBJECTDIR}/_ext/1716827871/sp_arm64.o ../src/third_party/wolfssl/wolfcrypt/src/sp_arm64.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/des3.o: ../src/third_party/wolfssl/wolfcrypt/src/des3.c  .generated_files/flags/default/22583f3d50a27c55d629afb322d72ea02bb097a4 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/des3.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/des3.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/des3.o.d" -o ${OBJECTDIR}/_ext/1716827871/des3.o ../src/third_party/wolfssl/wolfcrypt/src/des3.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/camellia.o: ../src/third_party/wolfssl/wolfcrypt/src/camellia.c  .generated_files/flags/default/54ad3276fe011f75dd8fd1621d8a62ac8c170a9d .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/camellia.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/camellia.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/camellia.o.d" -o ${OBJECTDIR}/_ext/1716827871/camellia.o ../src/third_party/wolfssl/wolfcrypt/src/camellia.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/sha.o: ../src/third_party/wolfssl/wolfcrypt/src/sha.c  .generated_files/flags/default/6f0c81b0d91ef5d6cbd9a3746d5dfb367ad477c6 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sha.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sha.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/sha.o.d" -o ${OBJECTDIR}/_ext/1716827871/sha.o ../src/third_party/wolfssl/wolfcrypt/src/sha.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/wc_pkcs11.o: ../src/third_party/wolfssl/wolfcrypt/src/wc_pkcs11.c  .generated_files/flags/default/c4e2a163b41b10a4d455e2e5b2d8c610e66f2263 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/wc_pkcs11.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/wc_pkcs11.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/wc_pkcs11.o.d" -o ${OBJECTDIR}/_ext/1716827871/wc_pkcs11.o ../src/third_party/wolfssl/wolfcrypt/src/wc_pkcs11.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/hc128.o: ../src/third_party/wolfssl/wolfcrypt/src/hc128.c  .generated_files/flags/default/99e3eddacbd59e75c9d7790052800724064c25a5 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/hc128.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/hc128.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/hc128.o.d" -o ${OBJECTDIR}/_ext/1716827871/hc128.o ../src/third_party/wolfssl/wolfcrypt/src/hc128.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/chacha.o: ../src/third_party/wolfssl/wolfcrypt/src/chacha.c  .generated_files/flags/default/445069b5e0e2c1e65cd11dbab61ae44bdff8103c .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/chacha.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/chacha.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/chacha.o.d" -o ${OBJECTDIR}/_ext/1716827871/chacha.o ../src/third_party/wolfssl/wolfcrypt/src/chacha.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/pwdbased.o: ../src/third_party/wolfssl/wolfcrypt/src/pwdbased.c  .generated_files/flags/default/7c449c889185b02956ecddeb0ca75f4f89422d2d .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/pwdbased.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/pwdbased.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/pwdbased.o.d" -o ${OBJECTDIR}/_ext/1716827871/pwdbased.o ../src/third_party/wolfssl/wolfcrypt/src/pwdbased.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/coding.o: ../src/third_party/wolfssl/wolfcrypt/src/coding.c  .generated_files/flags/default/35e2f7475ded8e0ff977c9ff892f79785d306331 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/coding.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/coding.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/coding.o.d" -o ${OBJECTDIR}/_ext/1716827871/coding.o ../src/third_party/wolfssl/wolfcrypt/src/coding.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/wc_port.o: ../src/third_party/wolfssl/wolfcrypt/src/wc_port.c  .generated_files/flags/default/79c51100b49b428a8fc2a55487f2c4426c889e7a .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/wc_port.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/wc_port.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/wc_port.o.d" -o ${OBJECTDIR}/_ext/1716827871/wc_port.o ../src/third_party/wolfssl/wolfcrypt/src/wc_port.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/fe_low_mem.o: ../src/third_party/wolfssl/wolfcrypt/src/fe_low_mem.c  .generated_files/flags/default/5241f7883ee3edc2bba2a4f081f4391b7d4a714d .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/fe_low_mem.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/fe_low_mem.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/fe_low_mem.o.d" -o ${OBJECTDIR}/_ext/1716827871/fe_low_mem.o ../src/third_party/wolfssl/wolfcrypt/src/fe_low_mem.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/ecc.o: ../src/third_party/wolfssl/wolfcrypt/src/ecc.c  .generated_files/flags/default/b971165d847045f26b358a3e888e48cb8419da24 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/ecc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/ecc.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/ecc.o.d" -o ${OBJECTDIR}/_ext/1716827871/ecc.o ../src/third_party/wolfssl/wolfcrypt/src/ecc.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/ge_low_mem.o: ../src/third_party/wolfssl/wolfcrypt/src/ge_low_mem.c  .generated_files/flags/default/7df9e1b0113dad32efd484dc8c0d99f8dc066dc7 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/ge_low_mem.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/ge_low_mem.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/ge_low_mem.o.d" -o ${OBJECTDIR}/_ext/1716827871/ge_low_mem.o ../src/third_party/wolfssl/wolfcrypt/src/ge_low_mem.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/asn.o: ../src/third_party/wolfssl/wolfcrypt/src/asn.c  .generated_files/flags/default/31056e8e0d546e3af55b37b168dfe9bf2d9306ff .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/asn.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/asn.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/asn.o.d" -o ${OBJECTDIR}/_ext/1716827871/asn.o ../src/third_party/wolfssl/wolfcrypt/src/asn.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/ge_operations.o: ../src/third_party/wolfssl/wolfcrypt/src/ge_operations.c  .generated_files/flags/default/7ff70db107a73a70bf922120fd3df39c67f27399 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/ge_operations.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/ge_operations.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/ge_operations.o.d" -o ${OBJECTDIR}/_ext/1716827871/ge_operations.o ../src/third_party/wolfssl/wolfcrypt/src/ge_operations.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/curve25519.o: ../src/third_party/wolfssl/wolfcrypt/src/curve25519.c  .generated_files/flags/default/488f8c7a84e855a36d8dbf9a0351ef66a79d0727 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/curve25519.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/curve25519.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/curve25519.o.d" -o ${OBJECTDIR}/_ext/1716827871/curve25519.o ../src/third_party/wolfssl/wolfcrypt/src/curve25519.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/sp_arm32.o: ../src/third_party/wolfssl/wolfcrypt/src/sp_arm32.c  .generated_files/flags/default/64acdde24815f5b0a6f88ff8216fdfe6c7d1b0ac .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sp_arm32.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sp_arm32.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/sp_arm32.o.d" -o ${OBJECTDIR}/_ext/1716827871/sp_arm32.o ../src/third_party/wolfssl/wolfcrypt/src/sp_arm32.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/wolfmath.o: ../src/third_party/wolfssl/wolfcrypt/src/wolfmath.c  .generated_files/flags/default/eda7070a950d936e8f8b700a66ccf5bf3f388117 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/wolfmath.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/wolfmath.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/wolfmath.o.d" -o ${OBJECTDIR}/_ext/1716827871/wolfmath.o ../src/third_party/wolfssl/wolfcrypt/src/wolfmath.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/sha3.o: ../src/third_party/wolfssl/wolfcrypt/src/sha3.c  .generated_files/flags/default/10af59fe2db8f03bd2e23bdc29ebe7431a11ee6c .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sha3.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sha3.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/sha3.o.d" -o ${OBJECTDIR}/_ext/1716827871/sha3.o ../src/third_party/wolfssl/wolfcrypt/src/sha3.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/cryptocb.o: ../src/third_party/wolfssl/wolfcrypt/src/cryptocb.c  .generated_files/flags/default/1be04c2a9f2b1b6e71cd6d599daae80e1d0e3dd0 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/cryptocb.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/cryptocb.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/cryptocb.o.d" -o ${OBJECTDIR}/_ext/1716827871/cryptocb.o ../src/third_party/wolfssl/wolfcrypt/src/cryptocb.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/pkcs12.o: ../src/third_party/wolfssl/wolfcrypt/src/pkcs12.c  .generated_files/flags/default/cd0b4f963989c0825c824aac679ca43499902926 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/pkcs12.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/pkcs12.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/pkcs12.o.d" -o ${OBJECTDIR}/_ext/1716827871/pkcs12.o ../src/third_party/wolfssl/wolfcrypt/src/pkcs12.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/sha512.o: ../src/third_party/wolfssl/wolfcrypt/src/sha512.c  .generated_files/flags/default/caa9753acc2e55af1ec03431dae12b9ffbd873d1 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sha512.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sha512.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/sha512.o.d" -o ${OBJECTDIR}/_ext/1716827871/sha512.o ../src/third_party/wolfssl/wolfcrypt/src/sha512.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/md5.o: ../src/third_party/wolfssl/wolfcrypt/src/md5.c  .generated_files/flags/default/959fed7d051eb7ac472af55ea2f9853f6c594e7e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/md5.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/md5.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/md5.o.d" -o ${OBJECTDIR}/_ext/1716827871/md5.o ../src/third_party/wolfssl/wolfcrypt/src/md5.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/rsa.o: ../src/third_party/wolfssl/wolfcrypt/src/rsa.c  .generated_files/flags/default/b7e1e96d0859bce12e2d3184b62e2b06e3b778a6 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/rsa.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/rsa.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/rsa.o.d" -o ${OBJECTDIR}/_ext/1716827871/rsa.o ../src/third_party/wolfssl/wolfcrypt/src/rsa.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/wolfevent.o: ../src/third_party/wolfssl/wolfcrypt/src/wolfevent.c  .generated_files/flags/default/f2603585b2ff10968d0f4b1ab667a23ca8efb56b .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/wolfevent.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/wolfevent.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/wolfevent.o.d" -o ${OBJECTDIR}/_ext/1716827871/wolfevent.o ../src/third_party/wolfssl/wolfcrypt/src/wolfevent.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/asm.o: ../src/third_party/wolfssl/wolfcrypt/src/asm.c  .generated_files/flags/default/65ea113d77a41eebcbb0c7d9c5ab8c91e6fd0890 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/asm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/asm.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/asm.o.d" -o ${OBJECTDIR}/_ext/1716827871/asm.o ../src/third_party/wolfssl/wolfcrypt/src/asm.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/cpuid.o: ../src/third_party/wolfssl/wolfcrypt/src/cpuid.c  .generated_files/flags/default/33be93eb0d45ad98783683b7c397aa08cd61b179 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/cpuid.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/cpuid.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/cpuid.o.d" -o ${OBJECTDIR}/_ext/1716827871/cpuid.o ../src/third_party/wolfssl/wolfcrypt/src/cpuid.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/md4.o: ../src/third_party/wolfssl/wolfcrypt/src/md4.c  .generated_files/flags/default/dcfa3b30a3eafc1223f68cdc6321859818a7628e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/md4.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/md4.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/md4.o.d" -o ${OBJECTDIR}/_ext/1716827871/md4.o ../src/third_party/wolfssl/wolfcrypt/src/md4.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/aes.o: ../src/third_party/wolfssl/wolfcrypt/src/aes.c  .generated_files/flags/default/4ccdab2de1859c96625de991616cd14d848eef65 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/aes.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/aes.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/aes.o.d" -o ${OBJECTDIR}/_ext/1716827871/aes.o ../src/third_party/wolfssl/wolfcrypt/src/aes.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/wc_dsp.o: ../src/third_party/wolfssl/wolfcrypt/src/wc_dsp.c  .generated_files/flags/default/c394ce35f43f068ed25423cbe88f67c45285c1e0 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/wc_dsp.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/wc_dsp.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/wc_dsp.o.d" -o ${OBJECTDIR}/_ext/1716827871/wc_dsp.o ../src/third_party/wolfssl/wolfcrypt/src/wc_dsp.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/ge_448.o: ../src/third_party/wolfssl/wolfcrypt/src/ge_448.c  .generated_files/flags/default/f4f70cc7d43e12655893ba218aace58985d7022c .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/ge_448.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/ge_448.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/ge_448.o.d" -o ${OBJECTDIR}/_ext/1716827871/ge_448.o ../src/third_party/wolfssl/wolfcrypt/src/ge_448.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/dsa.o: ../src/third_party/wolfssl/wolfcrypt/src/dsa.c  .generated_files/flags/default/5ba8b0f80f32297f2289b76fdca5dcdd64564ff0 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/dsa.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/dsa.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/dsa.o.d" -o ${OBJECTDIR}/_ext/1716827871/dsa.o ../src/third_party/wolfssl/wolfcrypt/src/dsa.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/arc4.o: ../src/third_party/wolfssl/wolfcrypt/src/arc4.c  .generated_files/flags/default/23c1197b66968610e2d51f4cb5fdeac91035988d .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/arc4.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/arc4.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/arc4.o.d" -o ${OBJECTDIR}/_ext/1716827871/arc4.o ../src/third_party/wolfssl/wolfcrypt/src/arc4.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/ecc_fp.o: ../src/third_party/wolfssl/wolfcrypt/src/ecc_fp.c  .generated_files/flags/default/aa77d042a6361274e2af8f43acbb90f31d70f151 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/ecc_fp.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/ecc_fp.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/ecc_fp.o.d" -o ${OBJECTDIR}/_ext/1716827871/ecc_fp.o ../src/third_party/wolfssl/wolfcrypt/src/ecc_fp.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/sp_dsp32.o: ../src/third_party/wolfssl/wolfcrypt/src/sp_dsp32.c  .generated_files/flags/default/67eb52e4c8e49de580736758451ae44385491f7b .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sp_dsp32.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sp_dsp32.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/sp_dsp32.o.d" -o ${OBJECTDIR}/_ext/1716827871/sp_dsp32.o ../src/third_party/wolfssl/wolfcrypt/src/sp_dsp32.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/fe_operations.o: ../src/third_party/wolfssl/wolfcrypt/src/fe_operations.c  .generated_files/flags/default/b27d1fcb1f8f2b52f6cfba3a9b645dc4fd168ded .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/fe_operations.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/fe_operations.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/fe_operations.o.d" -o ${OBJECTDIR}/_ext/1716827871/fe_operations.o ../src/third_party/wolfssl/wolfcrypt/src/fe_operations.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/sp_x86_64.o: ../src/third_party/wolfssl/wolfcrypt/src/sp_x86_64.c  .generated_files/flags/default/356a02dcfde0b761c845aceebeb46449aefd31e3 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sp_x86_64.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sp_x86_64.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/sp_x86_64.o.d" -o ${OBJECTDIR}/_ext/1716827871/sp_x86_64.o ../src/third_party/wolfssl/wolfcrypt/src/sp_x86_64.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/sp_armthumb.o: ../src/third_party/wolfssl/wolfcrypt/src/sp_armthumb.c  .generated_files/flags/default/58033097718bfe1396d00f48ed28bec2a4387284 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sp_armthumb.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sp_armthumb.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/sp_armthumb.o.d" -o ${OBJECTDIR}/_ext/1716827871/sp_armthumb.o ../src/third_party/wolfssl/wolfcrypt/src/sp_armthumb.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/signature.o: ../src/third_party/wolfssl/wolfcrypt/src/signature.c  .generated_files/flags/default/61c4d9f41532995fc5deaab0ffe95ab7fca5025f .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/signature.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/signature.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/signature.o.d" -o ${OBJECTDIR}/_ext/1716827871/signature.o ../src/third_party/wolfssl/wolfcrypt/src/signature.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/sha256.o: ../src/third_party/wolfssl/wolfcrypt/src/sha256.c  .generated_files/flags/default/dfb8880ee7f6947d703477ae6aede2f18cdff752 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sha256.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sha256.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/sha256.o.d" -o ${OBJECTDIR}/_ext/1716827871/sha256.o ../src/third_party/wolfssl/wolfcrypt/src/sha256.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/sp_c64.o: ../src/third_party/wolfssl/wolfcrypt/src/sp_c64.c  .generated_files/flags/default/d68927a5a2d6824d05267312febffa51463a007b .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sp_c64.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/sp_c64.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/sp_c64.o.d" -o ${OBJECTDIR}/_ext/1716827871/sp_c64.o ../src/third_party/wolfssl/wolfcrypt/src/sp_c64.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/md2.o: ../src/third_party/wolfssl/wolfcrypt/src/md2.c  .generated_files/flags/default/77b118508b07c0e6b3e9d55da61bd8135d4ada5b .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/md2.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/md2.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/md2.o.d" -o ${OBJECTDIR}/_ext/1716827871/md2.o ../src/third_party/wolfssl/wolfcrypt/src/md2.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1716827871/hmac.o: ../src/third_party/wolfssl/wolfcrypt/src/hmac.c  .generated_files/flags/default/ab3e6b9f9a3b91fff4b437f344bb1e269b638749 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1716827871" 
	@${RM} ${OBJECTDIR}/_ext/1716827871/hmac.o.d 
	@${RM} ${OBJECTDIR}/_ext/1716827871/hmac.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1716827871/hmac.o.d" -o ${OBJECTDIR}/_ext/1716827871/hmac.o ../src/third_party/wolfssl/wolfcrypt/src/hmac.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1664057780/misc.o: ../src/third_party/wolfssl/wolfssl/wolfcrypt/src/misc.c  .generated_files/flags/default/32d6eb5fe5e0d9ec99b0b7e012ba2c7fe9d79f33 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1664057780" 
	@${RM} ${OBJECTDIR}/_ext/1664057780/misc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1664057780/misc.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1664057780/misc.o.d" -o ${OBJECTDIR}/_ext/1664057780/misc.o ../src/third_party/wolfssl/wolfssl/wolfcrypt/src/misc.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1664057780/evp.o: ../src/third_party/wolfssl/wolfssl/wolfcrypt/src/evp.c  .generated_files/flags/default/82e8083d9dc5bde0d66b3debc65998102a786dfd .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1664057780" 
	@${RM} ${OBJECTDIR}/_ext/1664057780/evp.o.d 
	@${RM} ${OBJECTDIR}/_ext/1664057780/evp.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1664057780/evp.o.d" -o ${OBJECTDIR}/_ext/1664057780/evp.o ../src/third_party/wolfssl/wolfssl/wolfcrypt/src/evp.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/main.o: ../src/main.c  .generated_files/flags/default/362e144dc62c49126bd8bd99b5a31681a3fbe98 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/main.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/main.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/main.o.d" -o ${OBJECTDIR}/_ext/1360937237/main.o ../src/main.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/app.o: ../src/app.c  .generated_files/flags/default/44288e7e55322c4267d644e055e9373b3be36f09 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/app.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/app.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/app.o.d" -o ${OBJECTDIR}/_ext/1360937237/app.o ../src/app.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/app_layer.o: ../src/app_layer.c  .generated_files/flags/default/d8f175ca0fd4e4b4aec117a69b556e0f6697965e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/app_layer.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/app_layer.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/app_layer.o.d" -o ${OBJECTDIR}/_ext/1360937237/app_layer.o ../src/app_layer.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1803285470/crc.o: C:/microchip/harmony/Apps/Docs/Devices/Smart\ Energy/Lib\ development/src/crc.c  .generated_files/flags/default/b10e379ed46b37069bdb88fc8604d2007d25fed8 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1803285470" 
	@${RM} ${OBJECTDIR}/_ext/1803285470/crc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1803285470/crc.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -DHAVE_CONFIG_H -DWOLFSSL_IGNORE_FILE_WARN -DWOLFSSL_USER_SETTINGS -I"../src" -I"../src/config/default" -I"../src/config/default/crypto/wolfcrypt" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -I"../src/packs/PIC32CX2051MTG128_DFP" -I"../src/third_party/wolfcrypt" -I"../src/third_party/wolfssl" -I"../src/third_party/wolfssl/wolfssl/wolfcrypt" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1803285470/crc.o.d" -o ${OBJECTDIR}/_ext/1803285470/crc.o "C:/microchip/harmony/Apps/Docs/Devices/Smart Energy/Lib development/src/crc.c"    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/PIC32CX-MTG" ${PACK_COMMON_OPTIONS} 
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compileCPP
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: archive
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${DISTDIR}/MOM_Application_al.X.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    ../src/config/default/PIC32CX2051MTG128.ld
	@${MKDIR} ${DISTDIR} 
	${MP_AR} $(MP_EXTRA_AR_PRE)  -mprocessor=$(MP_PROCESSOR_OPTION)  r ${DISTDIR}/MOM_Application_al.X.${OUTPUT_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}    
else
${DISTDIR}/MOM_Application_al.X.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   ../src/config/default/PIC32CX2051MTG128.ld
	@${MKDIR} ${DISTDIR} 
	${MP_AR} $(MP_EXTRA_AR_PRE)  -mprocessor=$(MP_PROCESSOR_OPTION)  r ${DISTDIR}/MOM_Application_al.X.${OUTPUT_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}    
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r ${OBJECTDIR}
	${RM} -r ${DISTDIR}

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(wildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif
