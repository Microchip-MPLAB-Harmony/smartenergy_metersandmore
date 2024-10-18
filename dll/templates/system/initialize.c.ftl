    /* Initialize Meters And More DLL Instance */
    sysObj.metersandmoreDll = DLL_Initialize((const SYS_MODULE_INDEX)0U, (SYS_MODULE_INIT *)&dllInitData);
<#if METERSANDMORE_INC_AL == true>

    /* Initialize Meters And More AL Instance */
    sysObj.metersandmoreAl = AL_Initialize((const SYS_MODULE_INDEX)0U, (SYS_MODULE_INIT *)&alInitData);
</#if>
