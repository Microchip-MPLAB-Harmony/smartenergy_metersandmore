
<#if (HarmonyCore.SELECT_RTOS)?? && HarmonyCore.SELECT_RTOS == "FreeRTOS">
    <#lt>static void lMmHi_STACK_Tasks(  void *pvParameters  )
    <#lt>{
    <#lt>    while(true)
    <#lt>    {
    <#lt>        /* Maintain Meters And More LLC */
    <#lt>        MMHI_Tasks(sysObj.metersandmoreHostInterface);
    <#lt>        vTaskDelay(MMHI_STACK_RTOS_TASK_DELAY_MS / portTICK_PERIOD_MS);
    <#lt>    }
    <#lt>}
<#elseif (HarmonyCore.SELECT_RTOS)?? && HarmonyCore.SELECT_RTOS == "ThreadX">
    <#lt>TX_THREAD      lMmHi_STACK_Task_TCB;
    <#lt>uint8_t*       lMmHi_STACK_Task_Stk_Ptr;

    <#lt>static void lMmHi_STACK_Tasks( ULONG thread_input )
    <#lt>{
    <#lt>    while(true)
    <#lt>    {
    <#lt>        /* Maintain Meters And More LLC */
    <#lt>        MMHI_Tasks(sysObj.metersandmoreHostInterface);
    <#lt>        tx_thread_sleep((ULONG)(MMHI_STACK_RTOS_TASK_DELAY_MS / (TX_TICK_PERIOD_MS)));
    <#lt>    }
    <#lt>}
<#elseif (HarmonyCore.SELECT_RTOS)?? && HarmonyCore.SELECT_RTOS == "MicriumOSIII">
    <#lt>OS_TCB  lMmHi_STACK_Tasks_TCB;
    <#lt>CPU_STK lMmHi_STACK_TasksStk[MMHI_STACK_RTOS_STACK_SIZE];

    <#lt>static void lMmHi_STACK_Tasks(  void *pvParameters  )
    <#lt>{
    <#lt>    OS_ERR os_err;
    <#lt>    while(true)
    <#lt>    {
    <#lt>        /* Maintain Meters And More LLC */
    <#lt>        MMHI_Tasks(sysObj.metersandmoreHostInterface);
    <#lt>        OSTimeDly(MMHI_STACK_RTOS_TASK_DELAY_MS, OS_OPT_TIME_DLY, &os_err);
    <#lt>    }
    <#lt>}
<#elseif (HarmonyCore.SELECT_RTOS)?? && HarmonyCore.SELECT_RTOS == "MbedOS">
    <#lt>static void lMmHi_STACK_Tasks( void *pvParameters )
    <#lt>{
    <#lt>    while(true)
    <#lt>    {
    <#lt>        /* Maintain Meters And More LLC */
    <#lt>        MMHI_Tasks(sysObj.metersandmoreHostInterface);
    <#lt>        thread_sleep_for((uint32_t)(MMHI_STACK_RTOS_TASK_DELAY_MS / MBED_OS_TICK_PERIOD_MS));
    <#lt>    }
    <#lt>}
</#if>
