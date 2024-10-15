    /* Initialize Meters And More DLL Instance */
    sysObj.metersandmoreDll = DLL_Initialize((const SYS_MODULE_INDEX)0U, (SYS_MODULE_INIT *)&dllInitData);
<#if METERSANDMORE_INC_APP_LAYER == true>

    /* Initialize Meters And More App Layer Instance */
    sysObj.metersandmoreApp = AL_Initialize((const SYS_MODULE_INDEX)0U, (SYS_MODULE_INIT *)&alInitData);
</#if>
