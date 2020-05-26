##
## Author:   Ermal Dreshaj
## License:  See LICENSE.TXT file included in the project
##
##
## Teensy 4.0 target specific CMake file
##

set(MCU_NAME "TEENSY40")

if(NOT DEFINED LINKER_SCRIPT)
    message(FATAL_ERROR "No linker script defined")
endif(NOT DEFINED LINKER_SCRIPT)
message("Linker script: ${LINKER_SCRIPT}")

#---------------------------------------------------------------------------------------
# Set target specific compiler/linker flags
#---------------------------------------------------------------------------------------

# Object build options
# -mcpu=cortex-m4       SepcifiesTarget ARM processor.
# -mfpu=fpv4-sp-d16     Specifies floating-point hardware.
# -mfloat-abi=softfp    Allows the generation of code using hardware floating-point instructions, but still uses the soft-float calling conventions.

set(OBJECT_GEN_FLAGS "-mcpu=cortex-m7 -mfloat-abi=hard -mfpu=fpv5-d16 -MMD -nostartfiles")

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${OBJECT_GEN_FLAGS}" CACHE INTERNAL "C Compiler options")
set(CMAKE_CXX_FLAGS "-fno-unwind-tables -fno-exceptions -fpermissive -fno-rtti -fno-threadsafe-statics -felide-constructors -Wno-error=narrowing ${CMAKE_CXX_FLAGS} ${OBJECT_GEN_FLAGS}" CACHE INTERNAL "C++ Compiler options")
set(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS} ${OBJECT_GEN_FLAGS}" CACHE INTERNAL "ASM Compiler options")

# Linker flags
if(PRINT_SIZE_INFO_AFTER_LINK)
    set(CMAKE_EXE_LINKER_PRINT_FLAGS "-Wl,--print-memory-usage")
endif()

set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${CMAKE_EXE_LINKER_PRINT_FLAGS} -mthumb -mcpu=cortex-m7 -mfloat-abi=hard -mfpu=fpv5-d16 -T${LINKER_SCRIPT}" CACHE INTERNAL "Linker options")

