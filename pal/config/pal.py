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
mm_pal_helpkeyword = "mm_pal_configurations"

def activatesDependencies(symbol, event):
    if (event["id"] == "MM_PAL_PVDD_MONITOR"):
        if (event["value"] == True):
            if(Database.getComponentByID("srv_pvddmon") == None):
                Database.activateComponents(["srv_pvddmon"])
        else:
            Database.deactivateComponents(["srv_pvddmon"])

def instantiateComponent(mmPalComponent):

    Log.writeInfoMessage("Loading M&M PAL module")

    ############################################################################
    #### Code Generation ####
    ############################################################################
    configName = Variables.get("__CONFIGURATION_NAME")

    global mmPalPVDDMonitor
    mmPalPVDDMonitor = mmPalComponent.createBooleanSymbol("MM_PAL_PVDD_MONITOR", None)
    mmPalPVDDMonitor.setLabel("PVDD Monitor")
    mmPalPVDDMonitor.setDefaultValue(False)
    mmPalPVDDMonitor.setHelp(mm_pal_helpkeyword)
    if Database.getSymbolValue("drvPlcPhy", "DRV_PLC_MODE") == "PL360":
        mmPalPVDDMonitor.setReadOnly(True)

    mmPalDummySymbol = mmPalComponent.createBooleanSymbol("MM_PAL_PLC_DUMMY", None)
    mmPalDummySymbol.setLabel("Dummy")
    mmPalDummySymbol.setDefaultValue(False)
    mmPalDummySymbol.setVisible(False)
    mmPalDummySymbol.setDependencies(activatesDependencies, ["MM_PAL_PVDD_MONITOR"])

    #####################################################################################################################################
    # Meters&More PAL FILES

    mmPalSrcFile = mmPalComponent.createFileSymbol("MM_PAL_SOURCE", None)
    mmPalSrcFile.setSourcePath("pal/src/pal.c.ftl")
    mmPalSrcFile.setOutputName("pal.c")
    mmPalSrcFile.setDestPath("stack/metersandmore/pal")
    mmPalSrcFile.setProjectPath("config/" + configName + "/stack/metersandmore/pal/")
    mmPalSrcFile.setType("SOURCE")
    mmPalSrcFile.setMarkup(True)

    mmPalHdrFile = mmPalComponent.createFileSymbol("MM_PAL_HEADER", None)
    mmPalHdrFile.setSourcePath("pal/pal.h")
    mmPalHdrFile.setOutputName("pal.h")
    mmPalHdrFile.setDestPath("stack/metersandmore/pal")
    mmPalHdrFile.setProjectPath("config/" + configName + "/stack/metersandmore/pal/")
    mmPalHdrFile.setType("HEADER")

    #####################################################################################################################################
    # Meters&More PAL TEMPLATES

    mmPalSystemDefFile = mmPalComponent.createFileSymbol("MM_PAL_DEF", None)
    mmPalSystemDefFile.setType("STRING")
    mmPalSystemDefFile.setOutputName("core.LIST_SYSTEM_DEFINITIONS_H_INCLUDES")
    mmPalSystemDefFile.setSourcePath("pal/templates/system/definitions.h.ftl")
    mmPalSystemDefFile.setMarkup(True)

# Handle messages from other components
def handleMessage(messageID, args):
    global mmPalPVDDMonitor
    retDict = {}

    if messageID == "PLC_DEVICE":
        retDict = {"Return": "Success"}
        plcDevice = args["Device"]
        if plcDevice == "PL360":
            mmPalPVDDMonitor.setReadOnly(True)
            mmPalPVDDMonitor.setValue(False)
        else:
            mmPalPVDDMonitor.setReadOnly(False)
    else:
        retDict = {"Return": "UnImplemented Command"}

    return retDict
