
<#if !(HarmonyCore.SELECT_RTOS)?? || (HarmonyCore.SELECT_RTOS == "BareMetal")>
    <#lt>/* G3 stack task rate in milliseconds */
    <#lt>#define MM_STACK_TASK_RATE_MS            ${METERSANDMORE_TASK_RATE_MS}U
    <#lt>#define MM_STACK_LLC_REPEATS             ${METERSANDMORE_LLC_REPEATS}U

<#else>
    <#lt>/* G3 stack RTOS configuration */
    <#if HarmonyCore.SELECT_RTOS == "FreeRTOS">
        <#lt>#define MM_STACK_RTOS_STACK_SIZE         ${METERSANDMORE_RTOS_STACK_SIZE / 4}U
    <#else>
        <#lt>#define MM_STACK_RTOS_STACK_SIZE         ${METERSANDMORE_RTOS_STACK_SIZE}U
    </#if>
    <#lt>#define MM_STACK_RTOS_TASK_PRIORITY      ${METERSANDMORE_RTOS_TASK_PRIORITY}U
    <#lt>#define MM_STACK_RTOS_TASK_DELAY_MS      ${METERSANDMORE_RTOS_TASK_DELAY_MS}U
    <#if HarmonyCore.SELECT_RTOS == "MicriumOSIII">
        <#lt>#define MM_STACK_RTOS_TASK_MSG_QTY       ${METERSANDMORE_RTOS_TASK_MSG_QTY}U
        <#lt>#define MM_STACK_RTOS_TASK_TIME_QUANTA   ${METERSANDMORE_RTOS_TASK_TIME_QUANTA}U
    </#if>
</#if>
