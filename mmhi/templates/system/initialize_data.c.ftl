// <editor-fold defaultstate="collapsed" desc="Meters And More Host Interface Initialization Data">
static const MMHI_PLIB_INTERFACE mmhiUARTPlibAPI =
{
    .readFn = (MMHI_PLIB_READ)${.vars["${MMHI_UART_DEVICE?lower_case}"].USART_PLIB_API_PREFIX}_Read,
    .readCallbackRegister = (MMHI_PLIB_READCALLBACKREGISTER)${.vars["${MMHI_UART_DEVICE?lower_case}"].USART_PLIB_API_PREFIX}_ReadCallbackRegister,
    .writeFn = (MMHI_PLIB_WRITE)${.vars["${MMHI_UART_DEVICE?lower_case}"].USART_PLIB_API_PREFIX}_Write,
    .writeCallbackRegister = (MMHI_PLIB_WRITECALLBACKREGISTER)${.vars["${MMHI_UART_DEVICE?lower_case}"].USART_PLIB_API_PREFIX}_WriteCallbackRegister,
    .errorGet = (MMHI_PLIB_ERROR_GET)${.vars["${MMHI_UART_DEVICE?lower_case}"].USART_PLIB_API_PREFIX}_ErrorGet,
};

static const MMHI_INIT_DATA mmhiUARTInitData =
{
    .uartPLIB = (const MMHI_PLIB_INTERFACE*)&mmhiUARTPlibAPI,
};

static const MMHI_INIT mmhiInit =
{
    .deviceInitData = (const MMHI_INIT_DATA*)&mmhiUARTInitData,
};

// </editor-fold>
