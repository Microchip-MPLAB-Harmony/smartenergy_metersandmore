
<#if (HarmonyCore.SELECT_RTOS)?? && HarmonyCore.SELECT_RTOS == "FreeRTOS">
    <#lt>static void lMM_HI_Tasks(  void *pvParameters  )
    <#lt>{
    <#lt>    while(true)
    <#lt>    {
    <#lt>        /* Maintain Meters And More LLC */
    <#lt>        MMHI_Tasks(sysObj.metersandmoreHostInterface);
    <#lt>        vTaskDelay(MMHI_RTOS_TASK_DELAY_MS / portTICK_PERIOD_MS);
    <#lt>    }
    <#lt>}
<#elseif (HarmonyCore.SELECT_RTOS)?? && HarmonyCore.SELECT_RTOS == "ThreadX">
    <#lt>TX_THREAD      lMM_HI_Task_TCB;
    <#lt>uint8_t*       lMM_HI_Task_Stk_Ptr;

    <#lt>static void lMM_HI_Tasks( ULONG thread_input )
    <#lt>{
    <#lt>    while(true)
    <#lt>    {
    <#lt>        /* Maintain Meters And More LLC */
    <#lt>        MMHI_Tasks(sysObj.metersandmoreHostInterface);
    <#lt>        tx_thread_sleep((ULONG)(MMHI_RTOS_TASK_DELAY_MS / (TX_TICK_PERIOD_MS)));
    <#lt>    }
    <#lt>}
<#elseif (HarmonyCore.SELECT_RTOS)?? && HarmonyCore.SELECT_RTOS == "MicriumOSIII">
    <#lt>OS_TCB  lMM_HI_Tasks_TCB;
    <#lt>CPU_STK lMM_HI_TasksStk[MMHI_RTOS_STACK_SIZE];

    <#lt>static void lMM_HI_Tasks(  void *pvParameters  )
    <#lt>{
    <#lt>    OS_ERR os_err;
    <#lt>    while(true)
    <#lt>    {
    <#lt>        /* Maintain Meters And More LLC */
    <#lt>        MMHI_Tasks(sysObj.metersandmoreHostInterface);
    <#lt>        OSTimeDly(MMHI_RTOS_TASK_DELAY_MS, OS_OPT_TIME_DLY, &os_err);
    <#lt>    }
    <#lt>}
<#elseif (HarmonyCore.SELECT_RTOS)?? && HarmonyCore.SELECT_RTOS == "MbedOS">
    <#lt>static void lMM_HI_Tasks( void *pvParameters )
    <#lt>{
    <#lt>    while(true)
    <#lt>    {
    <#lt>        /* Maintain Meters And More LLC */
    <#lt>        MMHI_Tasks(sysObj.metersandmoreHostInterface);
    <#lt>        thread_sleep_for((uint32_t)(MMHI_RTOS_TASK_DELAY_MS / MBED_OS_TICK_PERIOD_MS));
    <#lt>    }
    <#lt>}
</#if>
