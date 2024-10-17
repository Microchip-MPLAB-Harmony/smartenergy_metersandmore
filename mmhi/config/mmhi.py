# coding: utf-8
"""
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
"""
mm_hi_helpkeyword = "mm_hi_configurations"

def externalInterruptTrigger(symbol, event):
    key = event["symbol"].getKeyDescription(event["value"])
    intSrc = "PIO" + key[1] + "_IRQn"
    symbol.setValue(intSrc, 1)

def sort_alphanumeric(l):
    import re
    convert = lambda text: int(text) if text.isdigit() else text.lower()
    alphanum_key = lambda key: [ convert(c) for c in re.split('([0-9]+)', key) ]
    return sorted(l, key = alphanum_key)

# Handle messages from other components
def handleMessage(messageID, args):
    retDict = {}

    # ToDo fill if needed

    return retDict


def instantiateComponent(mmHiComponent):

    Log.writeInfoMessage("Loading M&M Host interface module")

    ############################################################################
    #### Code Generation ####
    ############################################################################
    configName = Variables.get("__CONFIGURATION_NAME")

    mmHiConsoleDevice = mmHiComponent.createStringSymbol("MMHI_UART_DEVICE", None)
    mmHiConsoleDevice.setLabel("Device Used")
    mmHiConsoleDevice.setHelp(mm_hi_helpkeyword)
    mmHiConsoleDevice.setReadOnly(True)
    mmHiConsoleDevice.setDefaultValue("")

    mmHiRTSPin = mmHiComponent.createKeyValueSetSymbol("MMHI_RTS_PIN", None)
    mmHiRTSPin.setLabel("RTS Pin")
    mmHiRTSPin.setDefaultValue(0)
    mmHiRTSPin.setOutputMode("Key")
    mmHiRTSPin.setHelp(mm_hi_helpkeyword)
    mmHiRTSPin.setDisplayMode("Description")

    # Send message to core to get available pins
    availablePinDictionary = {}
    availablePinDictionary = Database.sendMessage("core", "PIN_LIST", availablePinDictionary)

    for pad in sort_alphanumeric(availablePinDictionary.values()):
        key = "SYS_PORT_PIN_" + pad
        value = list(availablePinDictionary.keys())[list(availablePinDictionary.values()).index(pad)]
        description = pad
        mmHiRTSPin.addKey(key, value, description)

    mmHiExtIntSource = mmHiComponent.createStringSymbol("MMHI_EXT_INT_SRC", None)
    mmHiExtIntSource.setLabel("External Interrupt Source")
    mmHiExtIntSource.setDefaultValue("PIOA_IRQn")
    mmHiExtIntSource.setVisible(False)
    mmHiExtIntSource.setReadOnly(True)
    mmHiExtIntSource.setHelp(mm_hi_helpkeyword)
    mmHiExtIntSource.setDependencies(externalInterruptTrigger, ["MMHI_RTS_PIN"])

    mmHiPinConfigComment = mmHiComponent.createCommentSymbol("MMHI_RTS_PIN_CONFIG_COMMENT", None)
    mmHiPinConfigComment.setVisible(True)
    mmHiPinConfigComment.setLabel("***Above selected pin must be properly configured by Pin Manager as Interrupt pin***")

    mmHiCustomCommands = mmHiComponent.createIntegerSymbol("MMHI_CUSTOM_COMMANDS", None)
    mmHiCustomCommands.setLabel("Number of custom commands")
    mmHiCustomCommands.setDefaultValue(0)
    mmHiCustomCommands.setMin(0)
    mmHiCustomCommands.setMax(10)
    mmHiCustomCommands.setHelp(mm_hi_helpkeyword)

    mmHiManufCommands = mmHiComponent.createBooleanSymbol("MMHI_MANUF_COMMANDS", None)
    mmHiManufCommands.setLabel("Enable Manufacturer commands")
    mmHiManufCommands.setDefaultValue(True)
    mmHiManufCommands.setHelp(mm_hi_helpkeyword)
    
    #####################################################################################################################################
    # Meters And More Host Interafce Files

    mmHiSrcFile = mmHiComponent.createFileSymbol("MMHI_SOURCE", None)
    mmHiSrcFile.setSourcePath("mmhi/mmhi.c.ftl")
    mmHiSrcFile.setOutputName("mmhi.c")
    mmHiSrcFile.setDestPath("stack/metersandmore/mmhi")
    mmHiSrcFile.setProjectPath("config/" + configName + "/stack/metersandmore/mmhi/")
    mmHiSrcFile.setType("SOURCE")
    mmHiSrcFile.setMarkup(True)

    mmHiHdrFile = mmHiComponent.createFileSymbol("MMHI_HEADER", None)
    mmHiHdrFile.setSourcePath("mmhi/mmhi.h.ftl")
    mmHiHdrFile.setOutputName("mmhi.h")
    mmHiHdrFile.setDestPath("stack/metersandmore/mmhi")
    mmHiHdrFile.setProjectPath("config/" + configName + "/stack/metersandmore/mmhi/")
    mmHiHdrFile.setType("HEADER")
    mmHiHdrFile.setMarkup(True)

    mmHiLocalHdrFile = mmHiComponent.createFileSymbol("MMHI_LOCAL_HEADER", None)
    mmHiLocalHdrFile.setSourcePath("mmhi/mmhi_local.h.ftl")
    mmHiLocalHdrFile.setOutputName("mmhi_local.h")
    mmHiLocalHdrFile.setDestPath("stack/metersandmore/mmhi")
    mmHiLocalHdrFile.setProjectPath("config/" + configName + "/stack/metersandmore/mmhi/")
    mmHiLocalHdrFile.setType("HEADER")
    mmHiLocalHdrFile.setMarkup(True)

    mmHiHdrDefFile = mmHiComponent.createFileSymbol("MMHI_HEADER_DEF", None)
    mmHiHdrDefFile.setSourcePath("mmhi/mmhi_definitions.h")
    mmHiHdrDefFile.setOutputName("mmhi_definitions.h")
    mmHiHdrDefFile.setDestPath("stack/metersandmore/mmhi")
    mmHiHdrDefFile.setProjectPath("config/" + configName + "/stack/metersandmore/mmhi/")
    mmHiHdrDefFile.setType("HEADER")    

    mmHiMIBSrcFile = mmHiComponent.createFileSymbol("MMHI_MIB_SOURCE", None)
    mmHiMIBSrcFile.setSourcePath("mmhi/mmhi_mib.c")
    mmHiMIBSrcFile.setOutputName("mmhi_mib.c")
    mmHiMIBSrcFile.setDestPath("stack/metersandmore/mmhi")
    mmHiMIBSrcFile.setProjectPath("config/" + configName + "/stack/metersandmore/mmhi/")
    mmHiMIBSrcFile.setType("SOURCE")

    mmHiMIBHdrFile = mmHiComponent.createFileSymbol("MMHI_MIB_HEADER", None)
    mmHiMIBHdrFile.setSourcePath("mmhi/mmhi_mib.h")
    mmHiMIBHdrFile.setOutputName("mmhi_mib.h")
    mmHiMIBHdrFile.setDestPath("stack/metersandmore/mmhi")
    mmHiMIBHdrFile.setProjectPath("config/" + configName + "/stack/metersandmore/mmhi/")
    mmHiMIBHdrFile.setType("HEADER")

    #####################################################################################################################################
    # Meters And More HI TEMPLATES
    mmHiSystemConfigFile = mmHiComponent.createFileSymbol("MMHI_CONFIGURATION", None)
    mmHiSystemConfigFile.setType("STRING")
    mmHiSystemConfigFile.setOutputName("core.LIST_SYSTEM_CONFIG_H_MIDDLEWARE_CONFIGURATION")
    mmHiSystemConfigFile.setSourcePath("mmhi/templates/system/configuration.h.ftl")
    mmHiSystemConfigFile.setMarkup(True)

    mmHiSystemDefFile = mmHiComponent.createFileSymbol("MMHI_DEF_OBJ", None)
    mmHiSystemDefFile.setType("STRING")
    mmHiSystemDefFile.setOutputName("core.LIST_SYSTEM_DEFINITIONS_H_OBJECTS")
    mmHiSystemDefFile.setSourcePath("mmhi/templates/system/definitions_objects.h.ftl")
    mmHiSystemDefFile.setMarkup(True)

    mmHiSystemDefFile = mmHiComponent.createFileSymbol("MMHI_DEF", None)
    mmHiSystemDefFile.setType("STRING")
    mmHiSystemDefFile.setOutputName("core.LIST_SYSTEM_DEFINITIONS_H_INCLUDES")
    mmHiSystemDefFile.setSourcePath("mmhi/templates/system/definitions.h.ftl")
    mmHiSystemDefFile.setMarkup(True)

    mmHiSystemInitDataFile = mmHiComponent.createFileSymbol("MMHI_INIT_DATA", None)
    mmHiSystemInitDataFile.setType("STRING")
    mmHiSystemInitDataFile.setOutputName("core.LIST_SYSTEM_INIT_C_LIBRARY_INITIALIZATION_DATA")
    mmHiSystemInitDataFile.setSourcePath("mmhi/templates/system/initialize_data.c.ftl")
    mmHiSystemInitDataFile.setMarkup(True)

    mmHiSystemInitFile = mmHiComponent.createFileSymbol("MMHI_INIT", None)
    mmHiSystemInitFile.setType("STRING")
    mmHiSystemInitFile.setOutputName("core.LIST_SYSTEM_INIT_C_INITIALIZE_MIDDLEWARE")
    mmHiSystemInitFile.setSourcePath("mmhi/templates/system/initialize.c.ftl")
    mmHiSystemInitFile.setMarkup(True)

    mmHiSystemTasksFile = mmHiComponent.createFileSymbol("MMHI_SYS_TASK", None)
    mmHiSystemTasksFile.setType("STRING")
    mmHiSystemTasksFile.setOutputName("core.LIST_SYSTEM_TASKS_C_CALL_LIB_TASKS")
    mmHiSystemTasksFile.setSourcePath("mmhi/templates/system/system_tasks.c.ftl")
    mmHiSystemTasksFile.setMarkup(True)

def onAttachmentConnected(source, target):
    localComponent = source["component"]
    remoteComponent = target["component"]
    remoteID = remoteComponent.getID()
    connectID = source["id"]
    # targetID = target["id"]

    if connectID == "mmHi_console_dependency" :
        deviceUsed = localComponent.getSymbolByID("MMHI_UART_DEVICE")
        deviceUsed.setValue(remoteID.upper())
        Database.sendMessage(remoteID, "UART_SET_BAUD_RATE", {"baudRatevalue":57600, "isReadOnly":True})

        # Database.sendMessage(remoteID, "UART_NON_BLOCKING_MODE", {"isEnabled":True, "isReadOnly":True})
        # Database.sendMessage(remoteID, "UART_NON_BLOCKING_FIFO_MODE", {"isEnabled":True, "isReadOnly":True})
        # Database.sendMessage(remoteID, "UART_NON_BLOCKING_DMA_TX_MODE", {"isEnabled":True, "isReadOnly":True})
        
def onAttachmentDisconnected(source, target):
    localComponent = source["component"]
    remoteComponent = target["component"]
    remoteID = remoteComponent.getID()
    connectID = source["id"]
    # targetID = target["id"]

    if connectID == "mmHi_console_dependency" :
        deviceUsed = localComponent.getSymbolByID("MMHI_UART_DEVICE")
        deviceUsed.clearValue()
        Database.sendMessage(remoteID, "UART_SET_BAUD_RATE", {"baudRatevalue":0, "isReadOnly":False})

        # Database.sendMessage(remoteID, "UART_NON_BLOCKING_MODE", {"isEnabled":False, "isReadOnly":False})
        # Database.sendMessage(remoteID, "UART_NON_BLOCKING_FIFO_MODE", {"isEnabled":False, "isReadOnly":False})
        # Database.sendMessage(remoteID, "UART_NON_BLOCKING_DMA_TX_MODE", {"isEnabled":False, "isReadOnly":False})
