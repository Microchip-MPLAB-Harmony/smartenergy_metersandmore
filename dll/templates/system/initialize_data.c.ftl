/* Meters And More DLL Initialization Data */
static DLL_INIT dllInitData = {

<#if (HarmonyCore.SELECT_RTOS)?? && (HarmonyCore.SELECT_RTOS != "BareMetal")>
    /* RTOS enabled: DLL task executed always */
    .taskRateMs = 0U ,
<#else>
    /* DLL task rate in milliseconds */
    .taskRateMs = MM_STACK_TASK_RATE_MS ,
</#if>

    /* Is master node (false in slave node) */
<#if (METERSANDMORE_ROLE == "DCU")>
    .isMaster = true
<#else>
    .isMaster = false
</#if>

};
<#if METERSANDMORE_INC_AL == true>

/* Meters And More AL Initialization Data */
static AL_INIT alInitData = {

<#if (HarmonyCore.SELECT_RTOS)?? && (HarmonyCore.SELECT_RTOS != "BareMetal")>
    /* RTOS enabled: App Layer task executed always */
    .taskRateMs = 0U ,
<#else>
    /* App Layer task rate in milliseconds */
    .taskRateMs = MM_STACK_TASK_RATE_MS ,
</#if>

    /* Is master node (false in slave node) */
<#if (METERSANDMORE_ROLE == "DCU")>
    .isMaster = true
<#else>
    .isMaster = false
</#if>

};
</#if>
