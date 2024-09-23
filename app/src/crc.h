/*******************************************************************************
  CRC service used by PLC components Header File

  Company:
    Microchip Technology Inc.

  File Name:
    crc.h

  Summary:
    CRC service used by PLC components Implementation.

  Description:
    The CRC wrapper provides a simple interface to manage the CRC needs
    for PLC components. This file implements the CRC core interface routines
    for PLC.

*******************************************************************************/

// DOM-IGNORE-BEGIN
/*
Copyright (C) 2023, Microchip Technology Inc., and its subsidiaries. All rights reserved.

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
// DOM-IGNORE-END

#ifndef CRC_H    // Guards against multiple inclusion
#define CRC_H

// *****************************************************************************
// *****************************************************************************
// Section: Included Files
// *****************************************************************************
// *****************************************************************************

#include <stdint.h>
#include <stdbool.h>
#include "system/system.h"

// DOM-IGNORE-BEGIN
#ifdef __cplusplus  // Provide C++ Compatibility

    extern "C" {

#endif
// DOM-IGNORE-END

// *****************************************************************************
// *****************************************************************************
// Section: Data Types
// *****************************************************************************
// *****************************************************************************

// *****************************************************************************
/* CRC Types

   Summary
    The list of all CRC types supported (8, 16 and 32 bits).

   Remarks:
    None
*/

// *****************************************************************************
// *****************************************************************************
// Section: CRC Interface Definition
// *****************************************************************************
// *****************************************************************************

// *****************************************************************************
/* Function:
    uint32_t CRC_Get32(
      uint8_t *pData, 
      size_t length, 
      uint32_t crcInitValue
    );
  Summary:
    Obtains the CRC for a data stream.

  Description:
    This routine gets the CRC value (32 bits, depending on arguments)
    of the data stream provided as argument.

  Precondition:
    None.

  Parameters:
    pData  -    Pointer to buffer containing the data stream.

    length -    Length of the data stream.

    initValue - Initialization value for CRC computation.

  Returns:
    the routine returns a valid CRC value.
    
    Returned CRC is always a 32-bit value.

  Example:
    <code>
    uint32_t valueTmp32;

    valueTmp32 = CRC_Get32(pData, length, initValue);
    </code>

  Remarks:
    None.
*/
uint32_t CRC_Get32(uint8_t *pData, size_t length, uint32_t crcInitValue);


#endif //CRC_H
