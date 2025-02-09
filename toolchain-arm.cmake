
# The name of the target operating system
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)

set(CMAKE_C_COMPILER C:/Users/ydung/Desktop/monoos.org/toolchain-gcc/bin/arm-none-eabi-gcc.exe)
set(CMAKE_ASM_COMPILER C:/Users/ydung/Desktop/monoos.org/toolchain-gcc/bin/arm-none-eabi-gcc.exe)
set(CMAKE_CXX_COMPILER C:/Users/ydung/Desktop/monoos.org/toolchain-gcc/bin/arm-none-eabi-g++.exe)
set(CMAKE_LINKER C:/Users/ydung/Desktop/monoos.org/toolchain-gcc/bin/arm-none-eabi-ld.exe)
set(CMAKE_OBJCOPY C:/Users/ydung/Desktop/monoos.org/toolchain-gcc/bin/arm-none-eabi-objcopy.exe)

# Không cần thư viện hệ thống
set(CMAKE_EXE_LINKER_FLAGS_INIT "-nostartfiles")
