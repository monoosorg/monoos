# Định nghĩa hệ thống ARM (Không có OS)
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)

enable_language(ASM)

set(CMAKE_ASM_COMPILER "C:/Users/ydung/Desktop/monoos.org/build_environment/bin/arm-none-eabi-gcc")
set(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS} -mcpu=cortex-a7 -fpic -ffreestanding -nostdlib -Wall")

add_executable(boot boot.asm)
# add_library(boot boot.asm)

