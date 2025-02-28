    /* Initialize Meters And More DLL Instance */
    sysObj.metersandmoreDll = DLL_Initialize((const SYS_MODULE_INDEX)0U, (SYS_MODULE_INIT *)&dllInitData);
<#if METERSANDMORE_INC_AL == true>

    /* Initialize Meters And More AL Instance */
    sysObj.metersandmoreAl = AL_Initialize((const SYS_MODULE_INDEX)0U, (SYS_MODULE_INIT *)&alInitData);
    <#if AL_SERIALIZATION_EN == true>

    /* Initialize Meters And More AL Serialization Instance */
    sysObj.metersandmoreAlSerial = AL_SERIAL_Initialize((const SYS_MODULE_INDEX)0U);
    </#if>
</#if>
