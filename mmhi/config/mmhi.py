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

def getEICSignals():
    eicSignalsList = []
    for signal in eicSignalsATDF:
        index = signal.getAttribute("index")
        if (index != None):
            eicPin = "EIC_PIN_{}".format(index)
            if eicPin not in eicSignalsList:
                eicSignalsList.append(eicPin)

    if (eicSignalsList == []):
        eicSignalsList = ["None"]

    return eicSignalsList

def getEICSignalsFromPin(pin):
    eicList = []
    eicPad = "{}{:02d}".format(pin.replace("R","P")[:2],int(pin[2:]))
    for signal in eicSignalsATDF:
        pad = signal.getAttribute("pad")
        index = signal.getAttribute("index")
        if ((pad in eicPad) and (index!=None)):
            eicList.append("EIC_PIN_" + index)

    return eicList

def checkEICSignals(symbol, event):
    index = mmHiRTSPin.getValue()
    pinDesc = mmHiRTSPin.getKeyDescription(index)
    eic = plcEICSignal.getValue()

    eicSignalsFromPin = getEICSignalsFromPin(pinDesc)

    if eic in eicSignalsFromPin:
        symbol.setVisible(False)
    else:
        symbol.setVisible(True)

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

    global mmHiRTSPin
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

    # Check EIC peripheral
    periphNode = ATDF.getNode("/avr-tools-device-file/devices/device/peripherals")
    peripherals = periphNode.getChildren()
    eicFound = False
    for module in range (0, len(peripherals)):
        if str(peripherals[module].getAttribute("name")) == "EIC":
            eicFound = True
    
    if (eicFound):
        global eicSignalsATDF
        eicSignalsATDF = ATDF.getNode('/avr-tools-device-file/devices/device/peripherals/module@[name="EIC"]/instance/signals').getChildren()

        global plcEICSignal
        eicSignals = getEICSignals()
        plcEICSignal = mmHiComponent.createComboSymbol("MMHI_EIC_SIGNAL", mmHiRTSPin, eicSignals)
        plcEICSignal.setLabel("EIC signal")
        plcEICSignal.setDefaultValue(eicSignals[0])

        plcEICSignalComment = mmHiComponent.createCommentSymbol("MMHI_EIC_SIGNAL_COMMENT", mmHiRTSPin)
        plcEICSignalComment.setVisible(False)
        plcEICSignalComment.setLabel("***Selected EIC signal cannot be assigned to PIN value. Please check it with the PIN Manager***")
        plcEICSignalComment.setDependencies(checkEICSignals, ["MMHI_RTS_PIN" ,"MMHI_EIC_SIGNAL"])

    mmHiExtIntSource = mmHiComponent.createStringSymbol("MMHI_EXT_INT_SRC", None)
    mmHiExtIntSource.setLabel("External Interrupt Source")
    if eicFound:
        mmHiExtIntSource.setDefaultValue("EIC_IRQn")
    else:
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
    mmHiManufCommands.setDefaultValue(False)
    mmHiManufCommands.setHelp(mm_hi_helpkeyword)

    # RTOS CONFIG
    mmHiRTOSMenu = mmHiComponent.createMenuSymbol("MMHI_RTOS_MENU", None)
    mmHiRTOSMenu.setLabel("RTOS settings")
    mmHiRTOSMenu.setDescription("RTOS settings")
    mmHiRTOSMenu.setVisible(getActiveRtos() != "BareMetal")
    mmHiRTOSMenu.setDependencies(showRTOSMenu, ["HarmonyCore.SELECT_RTOS"])
    mmHiRTOSMenu.setHelp(mm_hi_helpkeyword)

    mmHiRTOSStackSize = mmHiComponent.createIntegerSymbol("MMHI_RTOS_STACK_SIZE", mmHiRTOSMenu)
    mmHiRTOSStackSize.setLabel("Stack Size (in bytes)")
    mmHiRTOSStackSize.setDefaultValue(3584)
    mmHiRTOSStackSize.setMin(1024)
    mmHiRTOSStackSize.setMax(16*1024)
    mmHiRTOSStackSize.setHelp(mm_hi_helpkeyword)

    mmHiRTOSTaskPriority = mmHiComponent.createIntegerSymbol("MMHI_RTOS_TASK_PRIORITY", mmHiRTOSMenu)
    mmHiRTOSTaskPriority.setLabel("Task Priority")
    mmHiRTOSTaskPriority.setDefaultValue(1)
    mmHiRTOSTaskPriority.setMin(0)
    mmHiRTOSTaskPriority.setHelp(mm_hi_helpkeyword)

    mmHiRTOSUseDelay = mmHiComponent.createBooleanSymbol("MMHI_RTOS_TASK_USE_DELAY", mmHiRTOSMenu)
    mmHiRTOSUseDelay.setLabel("Use Task Delay")
    mmHiRTOSUseDelay.setDescription("Specifies whether task delay is used or not")
    mmHiRTOSUseDelay.setDefaultValue(True)
    mmHiRTOSUseDelay.setReadOnly(True)
    mmHiRTOSUseDelay.setHelp(mm_hi_helpkeyword)

    mmHiRTOSDelay = mmHiComponent.createIntegerSymbol("MMHI_RTOS_TASK_DELAY_MS", mmHiRTOSUseDelay)
    mmHiRTOSDelay.setLabel("Task Delay in ms")
    mmHiRTOSDelay.setDescription("Specifies the Meters And More stack task delay in ms")
    mmHiRTOSDelay.setDefaultValue(5)
    mmHiRTOSDelay.setMin(1)
    mmHiRTOSDelay.setMax(20)
    mmHiRTOSDelay.setHelp(mm_hi_helpkeyword)

    mmHiRTOSMsgQSize = mmHiComponent.createIntegerSymbol("MMHI_RTOS_TASK_MSG_QTY", mmHiRTOSMenu)
    mmHiRTOSMsgQSize.setLabel("Maximum Message Queue Size")
    mmHiRTOSMsgQSize.setDescription("A µC/OS-III task contains an optional internal message queue (if OS_CFG_TASK_Q_EN is set to DEF_ENABLED in os_cfg.h). This argument specifies the maximum number of messages that the task can receive through this message queue. The user may specify that the task is unable to receive messages by setting this argument to 0")
    mmHiRTOSMsgQSize.setDefaultValue(0)
    mmHiRTOSMsgQSize.setMin(0)
    mmHiRTOSMsgQSize.setVisible(getActiveRtos() == "MicriumOSIII")
    mmHiRTOSMsgQSize.setDependencies(commandRtosMicriumOSIIIAppTaskVisibility, ["HarmonyCore.SELECT_RTOS"])
    mmHiRTOSMsgQSize.setHelp(mm_hi_helpkeyword)

    mmHiRTOSTaskTimeQuanta = mmHiComponent.createIntegerSymbol("MMHI_RTOS_TASK_TIME_QUANTA", mmHiRTOSMenu)
    mmHiRTOSTaskTimeQuanta.setLabel("Task Time Quanta")
    mmHiRTOSTaskTimeQuanta.setDescription("The amount of time (in clock ticks) for the time quanta when Round Robin is enabled. If you specify 0, then the default time quanta will be used which is the tick rate divided by 10.")
    mmHiRTOSTaskTimeQuanta.setDefaultValue(0)
    mmHiRTOSTaskTimeQuanta.setMin(0)
    mmHiRTOSTaskTimeQuanta.setVisible(getActiveRtos() == "MicriumOSIII")
    mmHiRTOSTaskTimeQuanta.setDependencies(commandRtosMicriumOSIIIAppTaskVisibility, ["HarmonyCore.SELECT_RTOS"])
    mmHiRTOSTaskTimeQuanta.setHelp(mm_hi_helpkeyword)

    mmHiRTOSTaskSpecificOpt = mmHiComponent.createBooleanSymbol("MMHI_RTOS_TASK_OPT_NONE", mmHiRTOSMenu)
    mmHiRTOSTaskSpecificOpt.setLabel("Task Specific Options")
    mmHiRTOSTaskSpecificOpt.setDescription("Contains task-specific options. Each option consists of one bit. The option is selected when the bit is set. The current version of µC/OS-III supports the following options:")
    mmHiRTOSTaskSpecificOpt.setDefaultValue(True)
    mmHiRTOSTaskSpecificOpt.setVisible(getActiveRtos() == "MicriumOSIII")
    mmHiRTOSTaskSpecificOpt.setDependencies(commandRtosMicriumOSIIIAppTaskVisibility, ["HarmonyCore.SELECT_RTOS"])
    mmHiRTOSTaskSpecificOpt.setHelp(mm_hi_helpkeyword)

    mmHiRTOSTaskStkChk = mmHiComponent.createBooleanSymbol("MMHI_RTOS_TASK_OPT_STK_CHK", mmHiRTOSTaskSpecificOpt)
    mmHiRTOSTaskStkChk.setLabel("Stack checking is allowed for the task")
    mmHiRTOSTaskStkChk.setDescription("Specifies whether stack checking is allowed for the task")
    mmHiRTOSTaskStkChk.setDefaultValue(True)
    mmHiRTOSTaskStkChk.setDependencies(commandRtosMicriumOSIIITaskOptVisibility, ["MMHI_RTOS_TASK_OPT_NONE"])
    mmHiRTOSTaskStkChk.setHelp(mm_hi_helpkeyword)

    mmHiRTOSTaskStkClr = mmHiComponent.createBooleanSymbol("MMHI_RTOS_TASK_OPT_STK_CLR", mmHiRTOSTaskSpecificOpt)
    mmHiRTOSTaskStkClr.setLabel("Stack needs to be cleared")
    mmHiRTOSTaskStkClr.setDescription("Specifies whether the stack needs to be cleared")
    mmHiRTOSTaskStkClr.setDefaultValue(True)
    mmHiRTOSTaskStkClr.setDependencies(commandRtosMicriumOSIIITaskOptVisibility, ["MMHI_RTOS_TASK_OPT_NONE"])
    mmHiRTOSTaskStkClr.setHelp(mm_hi_helpkeyword)

    mmHiRTOSTaskSaveFp = mmHiComponent.createBooleanSymbol("MMHI_RTOS_TASK_OPT_SAVE_FP", mmHiRTOSTaskSpecificOpt)
    mmHiRTOSTaskSaveFp.setLabel("Floating-point registers needs to be saved")
    mmHiRTOSTaskSaveFp.setDescription("Specifies whether floating-point registers are saved. This option is only valid if the processor has floating-point hardware and the processor-specific code saves the floating-point registers")
    mmHiRTOSTaskSaveFp.setDefaultValue(False)
    mmHiRTOSTaskSaveFp.setDependencies(commandRtosMicriumOSIIITaskOptVisibility, ["MMHI_RTOS_TASK_OPT_NONE"])
    mmHiRTOSTaskSaveFp.setHelp(mm_hi_helpkeyword)

    mmHiRTOSTaskNoTls = mmHiComponent.createBooleanSymbol("MMHI_RTOS_TASK_OPT_NO_TLS", mmHiRTOSTaskSpecificOpt)
    mmHiRTOSTaskNoTls.setLabel("TLS (Thread Local Storage) support needed for the task")
    mmHiRTOSTaskNoTls.setDescription("If the caller doesn’t want or need TLS (Thread Local Storage) support for the task being created. If you do not include this option, TLS will be supported by default. TLS support was added in V3.03.00")
    mmHiRTOSTaskNoTls.setDefaultValue(False)
    mmHiRTOSTaskNoTls.setDependencies(commandRtosMicriumOSIIITaskOptVisibility, ["MMHI_RTOS_TASK_OPT_NONE"])
    mmHiRTOSTaskNoTls.setHelp(mm_hi_helpkeyword)

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

    mmHiSystemRtosTasksFile = mmHiComponent.createFileSymbol("MMHI_SYS_RTOS_TASK", None)
    mmHiSystemRtosTasksFile.setType("STRING")
    mmHiSystemRtosTasksFile.setOutputName("core.LIST_SYSTEM_RTOS_TASKS_C_DEFINITIONS")
    mmHiSystemRtosTasksFile.setSourcePath("mmhi/templates/system/system_rtos_tasks.c.ftl")
    mmHiSystemRtosTasksFile.setMarkup(True)
    mmHiSystemRtosTasksFile.setEnabled(getActiveRtos() != "BareMetal")
    mmHiSystemRtosTasksFile.setDependencies(genRtosTask, ["HarmonyCore.SELECT_RTOS"])

def showTaskRate(symbol, event):
    symbol.setVisible(event["value"] == "BareMetal")

def showRTOSMenu(symbol, event):
    symbol.setVisible(event["value"] != "BareMetal")

def genRtosTask(symbol, event):
    symbol.setEnabled(event["value"] != "BareMetal")

def commandRtosMicriumOSIIIAppTaskVisibility(symbol, event):
    symbol.setVisible(event["value"] == "MicriumOSIII")

def commandRtosMicriumOSIIITaskOptVisibility(symbol, event):
    symbol.setVisible(event["value"])

def getActiveRtos():
    return Database.getSymbolValue("HarmonyCore", "SELECT_RTOS")

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
