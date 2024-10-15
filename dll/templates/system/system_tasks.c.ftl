
<#if !(HarmonyCore.SELECT_RTOS)?? || (HarmonyCore.SELECT_RTOS == "BareMetal")>
    /* Maintain Meters And More DLL */
    DLL_Tasks(sysObj.metersandmoreDll);
    <#if METERSANDMORE_INC_APP_LAYER == true>

    /* Maintain Meters And More App Layer */
    AL_Tasks(sysObj.metersandmoreApp);
    </#if>

<#elseif HarmonyCore.SELECT_RTOS == "FreeRTOS">
    (void) xTaskCreate( lMM_STACK_TASKS,
        "MM_STACK_TASKS",
        MM_STACK_RTOS_STACK_SIZE,
        (void*)NULL,
        MM_STACK_RTOS_TASK_PRIORITY,
        (TaskHandle_t*)NULL
    );
<#elseif HarmonyCore.SELECT_RTOS == "ThreadX">
    (void) tx_byte_allocate(&byte_pool_0,
        (VOID **) &lMM_STACK_Task_Stk_Ptr,
        MM_STACK_RTOS_STACK_SIZE,
        TX_NO_WAIT
    );

    (void) tx_thread_create(&lMM_STACK_Task_TCB,
        "MM_STACK_TASKS",
        lMM_STACK_TASKS,
        0,
        lMM_STACK_Task_Stk_Ptr,
        MM_STACK_RTOS_STACK_SIZE,
        MM_STACK_RTOS_TASK_PRIORITY,
        MM_STACK_RTOS_TASK_PRIORITY,
        TX_NO_TIME_SLICE,
        TX_AUTO_START
    );
<#elseif HarmonyCore.SELECT_RTOS == "MicriumOSIII">
    <#assign MM_STACK_RTOS_TASK_OPTIONS = "OS_OPT_TASK_NONE" + G3_RTOS_TASK_OPT_STK_CHK?then(' | OS_OPT_TASK_STK_CHK', '') + G3_RTOS_TASK_OPT_STK_CLR?then(' | OS_OPT_TASK_STK_CLR', '') + G3_RTOS_TASK_OPT_SAVE_FP?then(' | OS_OPT_TASK_SAVE_FP', '') + G3_RTOS_TASK_OPT_NO_TLS?then(' | OS_OPT_TASK_NO_TLS', '')>
    (void) OSTaskCreate((OS_TCB      *)&lMM_STACK_TASKS_TCB,
                 (CPU_CHAR    *)"MM_STACK_TASKS",
                 (OS_TASK_PTR  )lMM_STACK_TASKS,
                 (void        *)0,
                 (OS_PRIO      )MM_STACK_RTOS_TASK_PRIORITY,
                 (CPU_STK     *)&lMM_STACK_TASKSStk[0],
                 (CPU_STK_SIZE )0u,
                 (CPU_STK_SIZE )MM_STACK_RTOS_STACK_SIZE,
    <#if MicriumOSIII.UCOSIII_CFG_TASK_Q_EN == true>
                 (OS_MSG_QTY   )MM_STACK_RTOS_TASK_MSG_QTY,
    <#else>
                 (OS_MSG_QTY   )0u,
    </#if>
    <#if MicriumOSIII.UCOSIII_CFG_SCHED_ROUND_ROBIN_EN == true>
                 (OS_TICK      )MM_STACK_RTOS_TASK_TIME_QUANTA,
    <#else>
                 (OS_TICK      )0u,
    </#if>
                 (void        *)0,
                 (OS_OPT       )(${MM_STACK_RTOS_TASK_OPTIONS}),
                 (OS_ERR      *)&os_err);
<#elseif HarmonyCore.SELECT_RTOS == "MbedOS">
    Thread MM_STACK_thread((osPriority)(osPriorityNormal + (MM_STACK_RTOS_TASK_PRIORITY - 1)), MM_STACK_RTOS_STACK_SIZE, NULL, "lMM_STACK_TASKS");
    (void) MM_STACK_thread.start(callback(lMM_STACK_TASKS, (void *)NULL));
</#if>