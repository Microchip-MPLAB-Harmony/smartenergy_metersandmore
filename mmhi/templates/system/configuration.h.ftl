/* Meters and More Host Interface Configuration Options */
#define MMHI_INDEX                     (0U)
#define MMHI_EXT_INT_RTS_PIN           ${MMHI_RTS_PIN?string}
<#if eic??>
#define MMHI_EXT_INT_RTS_SRC           EIC_IRQn
<#else>
#define MMHI_EXT_INT_RTS_SRC           ${MMHI_EXT_INT_SRC?string}
</#if>
<#if !(HarmonyCore.SELECT_RTOS)?? || (HarmonyCore.SELECT_RTOS != "BareMetal")>

    <#lt>/* Meters And More Host Interface RTOS configuration */
    <#if HarmonyCore.SELECT_RTOS == "FreeRTOS">
        <#lt>#define MMHI_RTOS_STACK_SIZE         ${MMHI_RTOS_STACK_SIZE / 4}U
    <#else>
        <#lt>#define MMHI_RTOS_STACK_SIZE         ${MMHI_RTOS_STACK_SIZE}U
    </#if>
    <#lt>#define MMHI_RTOS_TASK_PRIORITY      ${MMHI_RTOS_TASK_PRIORITY}U
    <#lt>#define MMHI_RTOS_TASK_DELAY_MS      ${MMHI_RTOS_TASK_DELAY_MS}U
    <#if HarmonyCore.SELECT_RTOS == "MicriumOSIII">
        <#lt>#define MMHI_RTOS_TASK_MSG_QTY       ${MMHI_RTOS_TASK_MSG_QTY}U
        <#lt>#define MMHI_RTOS_TASK_TIME_QUANTA   ${MMHI_RTOS_TASK_TIME_QUANTA}U
    </#if>
</#if>
