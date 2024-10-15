
<#if (HarmonyCore.SELECT_RTOS)?? && HarmonyCore.SELECT_RTOS == "FreeRTOS">
    <#lt>static void lMm_STACK_Tasks(  void *pvParameters  )
    <#lt>{
    <#lt>    while(true)
    <#lt>    {
    <#lt>        /* Maintain Meters And More DLL */
    <#lt>        DLL_Tasks(sysObj.metersandmoreDll);
    <#if METERSANDMORE_INC_APP_LAYER == true>
    <#lt>        /* Maintain Meters And More App Layer */
    <#lt>        AL_Tasks(sysObj.metersandmoreApp);
    </#if>
    <#lt>        vTaskDelay(MM_STACK_RTOS_TASK_DELAY_MS / portTICK_PERIOD_MS);
    <#lt>    }
    <#lt>}
<#elseif (HarmonyCore.SELECT_RTOS)?? && HarmonyCore.SELECT_RTOS == "ThreadX">
    <#lt>TX_THREAD      lMM_STACK_Task_TCB;
    <#lt>uint8_t*       lMM_STACK_Task_Stk_Ptr;

    <#lt>static void lMm_STACK_Tasks( ULONG thread_input )
    <#lt>{
    <#lt>    while(true)
    <#lt>    {
    <#lt>        /* Maintain Meters And More DLL */
    <#lt>        DLL_Tasks(sysObj.metersandmoreDll);
    <#if METERSANDMORE_INC_APP_LAYER == true>
    <#lt>        /* Maintain Meters And More App Layer */
    <#lt>        AL_Tasks(sysObj.metersandmoreApp);
    </#if>
    <#lt>        tx_thread_sleep((ULONG)(MM_STACK_RTOS_TASK_DELAY_MS / (TX_TICK_PERIOD_MS)));
    <#lt>    }
    <#lt>}
<#elseif (HarmonyCore.SELECT_RTOS)?? && HarmonyCore.SELECT_RTOS == "MicriumOSIII">
    <#lt>OS_TCB  lMm_STACK_Tasks_TCB;
    <#lt>CPU_STK lMm_STACK_TasksStk[MM_STACK_RTOS_STACK_SIZE];

    <#lt>static void lMm_STACK_Tasks(  void *pvParameters  )
    <#lt>{
    <#lt>    OS_ERR os_err;
    <#lt>    while(true)
    <#lt>    {
    <#lt>        /* Maintain Meters And More DLL */
    <#lt>        DLL_Tasks(sysObj.metersandmoreDll);
    <#if METERSANDMORE_INC_APP_LAYER == true>
    <#lt>        /* Maintain Meters And More App Layer */
    <#lt>        AL_Tasks(sysObj.metersandmoreApp);
    </#if>
    <#lt>        OSTimeDly(MM_STACK_RTOS_TASK_DELAY_MS, OS_OPT_TIME_DLY, &os_err);
    <#lt>    }
    <#lt>}
<#elseif (HarmonyCore.SELECT_RTOS)?? && HarmonyCore.SELECT_RTOS == "MbedOS">
    <#lt>static void lMm_STACK_Tasks( void *pvParameters )
    <#lt>{
    <#lt>    while(true)
    <#lt>    {
    <#lt>        /* Maintain Meters And More DLL */
    <#lt>        DLL_Tasks(sysObj.metersandmoreDll);
    <#if METERSANDMORE_INC_APP_LAYER == true>
    <#lt>        /* Maintain Meters And More App Layer */
    <#lt>        AL_Tasks(sysObj.metersandmoreApp);
    </#if>
    <#lt>        thread_sleep_for((uint32_t)(MM_STACK_RTOS_TASK_DELAY_MS / MBED_OS_TICK_PERIOD_MS));
    <#lt>    }
    <#lt>}
</#if>
