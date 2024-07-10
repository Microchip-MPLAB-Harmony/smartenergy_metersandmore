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
mm_dll_helpkeyword = "mm_dll_configurations"

def instantiateComponent(mmDllComponent):

    Log.writeInfoMessage("Loading M&M Dll module")

    ############################################################################
    #### Code Generation ####
    ############################################################################
    configName = Variables.get("__CONFIGURATION_NAME")

    # Select Meters & More role
    mmRoles = ["-- Select a Meters & More Stack Mode from list --", "Slave node", "Master node"]
    mmRole = mmDllComponent.createComboSymbol("METERSANDMORE_ROLE", None, mmRoles)
    mmRole.setLabel("Role for Meters & More node")
    mmRole.setVisible(True)
    mmRole.setDescription("Select Meters & More Mode")
    mmRole.setDefaultValue("Slave node")
    mmRole.setHelp(mm_dll_helpkeyword)

    # Meters & More Task rate control
    mmTaskRate = mmDllComponent.createIntegerSymbol("METERSANDMORE_TASK_RATE_MS", None)
    mmTaskRate.setLabel("Meters & More stack task rate (ms)")
    mmTaskRate.setDescription("Number of milliseconds between Meters & More stack task processing")
    mmTaskRate.setVisible(getActiveRtos() == "BareMetal")
    mmTaskRate.setDefaultValue(5)
    mmTaskRate.setMin(1)
    mmTaskRate.setMax(20)
    mmTaskRate.setDependencies(showTaskRate, ["HarmonyCore.SELECT_RTOS"])
    mmTaskRate.setHelp(mm_dll_helpkeyword)

   # Default LLC repeats
    mmDllRxQueueLimit = mmDllComponent.createIntegerSymbol("METERSANDMORE_LLC_REPEATS", None)
    mmDllRxQueueLimit.setHelp("mmDll_helpkeyword")
    mmDllRxQueueLimit.setLabel("Repeats")
    mmDllRxQueueLimit.setDescription("Default LLC packet repeats")
    mmDllRxQueueLimit.setDefaultValue(2)
    mmDllRxQueueLimit.setMin(0)
    mmDllRxQueueLimit.setMax(10)
    mmDllRxQueueLimit.setHelp(mm_dll_helpkeyword)

# RTOS CONFIG
    mmRTOSMenu = mmDllComponent.createMenuSymbol("METERSANDMORE_RTOS_MENU", None)
    mmRTOSMenu.setLabel("RTOS settings")
    mmRTOSMenu.setDescription("RTOS settings")
    mmRTOSMenu.setVisible(getActiveRtos() != "BareMetal")
    mmRTOSMenu.setDependencies(showRTOSMenu, ["HarmonyCore.SELECT_RTOS"])
    mmRTOSMenu.setHelp(mm_dll_helpkeyword)

    mmRTOSStackSize = mmDllComponent.createIntegerSymbol("METERSANDMORE_RTOS_STACK_SIZE", mmRTOSMenu)
    mmRTOSStackSize.setLabel("Stack Size (in bytes)")
    mmRTOSStackSize.setDefaultValue(3584)
    mmRTOSStackSize.setMin(1024)
    mmRTOSStackSize.setMax(16*1024)
    mmRTOSStackSize.setHelp(mm_dll_helpkeyword)

    mmRTOSTaskPriority = mmDllComponent.createIntegerSymbol("METERSANDMORE_RTOS_TASK_PRIORITY", mmRTOSMenu)
    mmRTOSTaskPriority.setLabel("Task Priority")
    mmRTOSTaskPriority.setDefaultValue(1)
    mmRTOSTaskPriority.setMin(0)
    mmRTOSTaskPriority.setHelp(mm_dll_helpkeyword)

    mmRTOSUseDelay = mmDllComponent.createBooleanSymbol("METERSANDMORE_RTOS_TASK_USE_DELAY", mmRTOSMenu)
    mmRTOSUseDelay.setLabel("Use Task Delay")
    mmRTOSUseDelay.setDescription("Specifies whether task delay is used or not")
    mmRTOSUseDelay.setDefaultValue(True)
    mmRTOSUseDelay.setReadOnly(True)
    mmRTOSUseDelay.setHelp(mm_dll_helpkeyword)

    mmRTOSDelay = mmDllComponent.createIntegerSymbol("METERSANDMORE_RTOS_TASK_DELAY_MS", mmRTOSUseDelay)
    mmRTOSDelay.setLabel("Task Delay in ms")
    mmRTOSDelay.setDescription("Specifies the Meters & More stack task delay in ms")
    mmRTOSDelay.setDefaultValue(5)
    mmRTOSDelay.setMin(1)
    mmRTOSDelay.setMax(20)
    mmRTOSDelay.setHelp(mm_dll_helpkeyword)

    mmRTOSMsgQSize = mmDllComponent.createIntegerSymbol("METERSANDMORE_RTOS_TASK_MSG_QTY", mmRTOSMenu)
    mmRTOSMsgQSize.setLabel("Maximum Message Queue Size")
    mmRTOSMsgQSize.setDescription("A µC/OS-III task contains an optional internal message queue (if OS_CFG_TASK_Q_EN is set to DEF_ENABLED in os_cfg.h). This argument specifies the maximum number of messages that the task can receive through this message queue. The user may specify that the task is unable to receive messages by setting this argument to 0")
    mmRTOSMsgQSize.setDefaultValue(0)
    mmRTOSMsgQSize.setMin(0)
    mmRTOSMsgQSize.setVisible(getActiveRtos() == "MicriumOSIII")
    mmRTOSMsgQSize.setDependencies(commandRtosMicriumOSIIIAppTaskVisibility, ["HarmonyCore.SELECT_RTOS"])
    mmRTOSMsgQSize.setHelp(mm_dll_helpkeyword)

    mmRTOSTaskTimeQuanta = mmDllComponent.createIntegerSymbol("METERSANDMORE_RTOS_TASK_TIME_QUANTA", mmRTOSMenu)
    mmRTOSTaskTimeQuanta.setLabel("Task Time Quanta")
    mmRTOSTaskTimeQuanta.setDescription("The amount of time (in clock ticks) for the time quanta when Round Robin is enabled. If you specify 0, then the default time quanta will be used which is the tick rate divided by 10.")
    mmRTOSTaskTimeQuanta.setDefaultValue(0)
    mmRTOSTaskTimeQuanta.setMin(0)
    mmRTOSTaskTimeQuanta.setVisible(getActiveRtos() == "MicriumOSIII")
    mmRTOSTaskTimeQuanta.setDependencies(commandRtosMicriumOSIIIAppTaskVisibility, ["HarmonyCore.SELECT_RTOS"])
    mmRTOSTaskTimeQuanta.setHelp(mm_dll_helpkeyword)

    mmRTOSTaskSpecificOpt = mmDllComponent.createBooleanSymbol("METERSANDMORE_RTOS_TASK_OPT_NONE", mmRTOSMenu)
    mmRTOSTaskSpecificOpt.setLabel("Task Specific Options")
    mmRTOSTaskSpecificOpt.setDescription("Contains task-specific options. Each option consists of one bit. The option is selected when the bit is set. The current version of µC/OS-III supports the following options:")
    mmRTOSTaskSpecificOpt.setDefaultValue(True)
    mmRTOSTaskSpecificOpt.setVisible(getActiveRtos() == "MicriumOSIII")
    mmRTOSTaskSpecificOpt.setDependencies(commandRtosMicriumOSIIIAppTaskVisibility, ["HarmonyCore.SELECT_RTOS"])
    mmRTOSTaskSpecificOpt.setHelp(mm_dll_helpkeyword)

    mmRTOSTaskStkChk = mmDllComponent.createBooleanSymbol("METERSANDMORE_RTOS_TASK_OPT_STK_CHK", mmRTOSTaskSpecificOpt)
    mmRTOSTaskStkChk.setLabel("Stack checking is allowed for the task")
    mmRTOSTaskStkChk.setDescription("Specifies whether stack checking is allowed for the task")
    mmRTOSTaskStkChk.setDefaultValue(True)
    mmRTOSTaskStkChk.setDependencies(commandRtosMicriumOSIIITaskOptVisibility, ["METERSANDMORE_RTOS_TASK_OPT_NONE"])
    mmRTOSTaskStkChk.setHelp(mm_dll_helpkeyword)

    mmRTOSTaskStkClr = mmDllComponent.createBooleanSymbol("METERSANDMORE_RTOS_TASK_OPT_STK_CLR", mmRTOSTaskSpecificOpt)
    mmRTOSTaskStkClr.setLabel("Stack needs to be cleared")
    mmRTOSTaskStkClr.setDescription("Specifies whether the stack needs to be cleared")
    mmRTOSTaskStkClr.setDefaultValue(True)
    mmRTOSTaskStkClr.setDependencies(commandRtosMicriumOSIIITaskOptVisibility, ["METERSANDMORE_RTOS_TASK_OPT_NONE"])
    mmRTOSTaskStkClr.setHelp(mm_dll_helpkeyword)

    mmRTOSTaskSaveFp = mmDllComponent.createBooleanSymbol("METERSANDMORE_RTOS_TASK_OPT_SAVE_FP", mmRTOSTaskSpecificOpt)
    mmRTOSTaskSaveFp.setLabel("Floating-point registers needs to be saved")
    mmRTOSTaskSaveFp.setDescription("Specifies whether floating-point registers are saved. This option is only valid if the processor has floating-point hardware and the processor-specific code saves the floating-point registers")
    mmRTOSTaskSaveFp.setDefaultValue(False)
    mmRTOSTaskSaveFp.setDependencies(commandRtosMicriumOSIIITaskOptVisibility, ["METERSANDMORE_RTOS_TASK_OPT_NONE"])
    mmRTOSTaskSaveFp.setHelp(mm_dll_helpkeyword)

    mmRTOSTaskNoTls = mmDllComponent.createBooleanSymbol("METERSANDMORE_RTOS_TASK_OPT_NO_TLS", mmRTOSTaskSpecificOpt)
    mmRTOSTaskNoTls.setLabel("TLS (Thread Local Storage) support needed for the task")
    mmRTOSTaskNoTls.setDescription("If the caller doesn’t want or need TLS (Thread Local Storage) support for the task being created. If you do not include this option, TLS will be supported by default. TLS support was added in V3.03.00")
    mmRTOSTaskNoTls.setDefaultValue(False)
    mmRTOSTaskNoTls.setDependencies(commandRtosMicriumOSIIITaskOptVisibility, ["METERSANDMORE_RTOS_TASK_OPT_NONE"])
    mmRTOSTaskNoTls.setHelp(mm_dll_helpkeyword)

    #####################################################################################################################################
    # Meters&More DLL FILES
    global mmDllLibFile
    mmDllLibFile = mmDllComponent.createLibrarySymbol("METERSANDMORE_DLL_LIBRARY", None)
    mmDllLibFile.setSourcePath("libs/metersandmore_lib_dll.a")
    mmDllLibFile.setOutputName("metersandmore_lib_dll.a")
    mmDllLibFile.setDestPath("stack/metersandmore/dll")
    mmDllLibFile.setEnabled(True)

    mmDllHdrFile = mmDllComponent.createFileSymbol("METERSANDMORE_DLL_HEADER", None)
    mmDllHdrFile.setSourcePath("dll/dll.h")
    mmDllHdrFile.setOutputName("dll.h")
    mmDllHdrFile.setDestPath("stack/metersandmore/dll")
    mmDllHdrFile.setProjectPath("config/" + configName + "/stack/metersandmore/dll/")
    mmDllHdrFile.setType("HEADER")

    #####################################################################################################################################
    # Meters&More DLL TEMPLATES
    mmDllSystemConfigFile = mmDllComponent.createFileSymbol("METERSANDMORE_DLL_CONFIGURATION", None)
    mmDllSystemConfigFile.setType("STRING")
    mmDllSystemConfigFile.setOutputName("core.LIST_SYSTEM_CONFIG_H_MIDDLEWARE_CONFIGURATION")
    mmDllSystemConfigFile.setSourcePath("dll/templates/system/configuration.h.ftl")
    mmDllSystemConfigFile.setMarkup(True)

    mmDllSystemDefFile = mmDllComponent.createFileSymbol("METERSANDMORE_DLL_DEF", None)
    mmDllSystemDefFile.setType("STRING")
    mmDllSystemDefFile.setOutputName("core.LIST_SYSTEM_DEFINITIONS_H_INCLUDES")
    mmDllSystemDefFile.setSourcePath("dll/templates/system/definitions.h.ftl")
    mmDllSystemDefFile.setMarkup(True)

    mmDllSystemInitDataFile = mmDllComponent.createFileSymbol("METERSANDMORE_DLL_INIT_DATA", None)
    mmDllSystemInitDataFile.setType("STRING")
    mmDllSystemInitDataFile.setOutputName("core.LIST_SYSTEM_INIT_C_LIBRARY_INITIALIZATION_DATA")
    mmDllSystemInitDataFile.setSourcePath("dll/templates/system/initialize_data.c.ftl")
    mmDllSystemInitDataFile.setMarkup(True)

    mmDllSystemInitFile = mmDllComponent.createFileSymbol("METERSANDMORE_DLL_INIT", None)
    mmDllSystemInitFile.setType("STRING")
    mmDllSystemInitFile.setOutputName("core.LIST_SYSTEM_INIT_C_INITIALIZE_MIDDLEWARE")
    mmDllSystemInitFile.setSourcePath("dll/templates/system/initialize.c.ftl")
    mmDllSystemInitFile.setMarkup(True)

    mmDllSystemTasksFile = mmDllComponent.createFileSymbol("METERSANDMORE_DLL_SYS_TASK", None)
    mmDllSystemTasksFile.setType("STRING")
    mmDllSystemTasksFile.setOutputName("core.LIST_SYSTEM_TASKS_C_CALL_LIB_TASKS")
    mmDllSystemTasksFile.setSourcePath("dll/templates/system/system_tasks.c.ftl")
    mmDllSystemTasksFile.setMarkup(True)

    mmDllSystemRtosTasksFile = mmDllComponent.createFileSymbol("METERSANDMORE_DLL_SYS_RTOS_TASK", None)
    mmDllSystemRtosTasksFile.setType("STRING")
    mmDllSystemRtosTasksFile.setOutputName("core.LIST_SYSTEM_RTOS_TASKS_C_DEFINITIONS")
    mmDllSystemRtosTasksFile.setSourcePath("dll/templates/system/system_rtos_tasks.c.ftl")
    mmDllSystemRtosTasksFile.setMarkup(True)
    mmDllSystemRtosTasksFile.setEnabled(getActiveRtos() != "BareMetal")
    mmDllSystemRtosTasksFile.setDependencies(genRtosTask, ["HarmonyCore.SELECT_RTOS"])



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

# Handle messages from other components
def handleMessage(messageID, args):
    global mmPalPVDDMonitor
    retDict = {}

    # ToDo fill if needed

    return retDict
