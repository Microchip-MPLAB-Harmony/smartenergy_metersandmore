![Microchip logo](https://raw.githubusercontent.com/wiki/Microchip-MPLAB-Harmony/Microchip-MPLAB-Harmony.github.io/images/microchip_logo.png)
![Harmony logo small](https://raw.githubusercontent.com/wiki/Microchip-MPLAB-Harmony/Microchip-MPLAB-Harmony.github.io/images/microchip_mplab_harmony_logo_small.png)

# Microchip MPLAB® Harmony 3 Release Notes

## Harmony 3 Smart Energy Meters And More v1.0.0

### New Features

Smart Energy Meters And More repository contains the code that implements the Meters And More Stack as defined in the Standard Specification from the [Meters And More Alliance](https://metersandmore.com/)
Provided Modules are:
- Meters And More DLL library, which includes implementation of MAC and LLC layers as defined in the Standard
- Meters And More DLL API, as entry point for upper layers using Meters And More Stack
- Meters And More AL (App Layer), as an additional entry point for upper layers using Meters And More Stack, which adds:
  - Encryption and Authentication capabilities
  - Network Management and LMON maintenance on Meter side
- Meters And More Host Interface, as defined in Meters And More Certification requirements, for a separate Modem implementation.
- PAL (Physical Abstraction Layer) for PLC. Provides abstraction between Meters And More MAC and Microchip implementation of Meters And More PLC Driver.

### Known Issues

- None

### Development Tools

- [MPLAB® X IDE v6.20](https://www.microchip.com/mplab/mplab-x-ide)
- [MPLAB® XC32 C/C++ Compiler v4.45](https://www.microchip.com/mplab/compilers)
- MPLAB® X IDE plug-ins:
  - MPLAB® Code Configurator 5.5.1 or higher

### Notes

- This is the first Release of the Meters And More Stack for Microchip MPLAB® Harmony 3 platform.
