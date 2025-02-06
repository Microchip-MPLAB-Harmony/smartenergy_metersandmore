/* Meters and More Host Interface Configuration Options */
#define MMHI_INDEX                     (0U)
#define MMHI_EXT_INT_RTS_PIN           ${MMHI_RTS_PIN?string}
<#if eic??>
#define MMHI_EXT_INT_RTS_SRC           EIC_IRQn
<#else>
#define MMHI_EXT_INT_RTS_SRC           ${MMHI_EXT_INT_SRC?string}
</#if>
