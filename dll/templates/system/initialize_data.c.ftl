/* Meters & More Initialization Data */
static LLC_INIT drvLLCInitData = {

<#if (HarmonyCore.SELECT_RTOS)?? && (HarmonyCore.SELECT_RTOS != "BareMetal")>
    /* RTOS enabled: ADP task executed always */
    .taskRateMs = 0U ,
<#else>
    /* ADP task rate in milliseconds */
    .taskRateMs = MM_STACK_TASK_RATE_MS ,
</#if>

    /* Is master node (false in slave node) */
<#if (METERSANDMORE_ROLE != "Master node")>
        .isMaster = true
<#else>
        .isMaster = false
</#if>

};
