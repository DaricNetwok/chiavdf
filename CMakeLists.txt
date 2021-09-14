CMAKE_MINIMUM_REQUIRED(VERSION 3.18 FATAL_ERROR)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

IF (NOT CMAKE_BUILD_TYPE)
    SET(CMAKE_BUILD_TYPE "RELEASE")
elseif (CMAKE_BUILD_TYPE STREQUAL "Debug")
    set(CMAKE_VERBOSE_MAKEFILE True)
endif ()

include(ProcessorCount)
ProcessorCount(NumberOfProcessors)

message(STATUS "CMAKE_MODULE_PATH: ${CMAKE_MODULE_PATH} - ${CMAKE_ASM_COMPILER}")
set(CMAKE_MODULE_PATH
        ${CMAKE_CURRENT_LIST_DIR}/cmake
        ${CMAKE_MODULE_PATH}
        )

set(PROJECT_NAME "vdf_bench")
project(${PROJECT_NAME} VERSION 0.1.0)

include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/libgmp.cmake)
setup_libgmp()

#find_package(GMP REQUIRED)
#find_package(GMPXX REQUIRED)
find_package(Boost REQUIRED)


add_subdirectory(asm_compiler)
add_dependencies(asm_compiler GMP)

MESSAGE(STATUS "gmp_INSTALL_DIR: ${gmp_LIB_DIR}\n-- gmp_INCLUDE_DIR: ${gmp_INCLUDE_DIR}")

get_target_property(asm_compiler_DIR asm_compiler BINARY_DIR)
message(STATUS "asm_compiler_DIR: ${asm_compiler_DIR}")

set(ASM_OBJECTS
        ${asm_compiler_DIR}/asm_compiled.o
        ${asm_compiler_DIR}/avx2_asm_compiled.o
        ${asm_compiler_DIR}/avx512_asm_compiled.o)

add_executable(${PROJECT_NAME}
        vdf_bench.cpp
        threading.h
        ${CMAKE_CURRENT_SOURCE_DIR}/refcode/lzcnt.c
        ${ASM_OBJECTS}
        )


SET_SOURCE_FILES_PROPERTIES(
        ${ASM_OBJECTS}
        PROPERTIES
        EXTERNAL_OBJECT true
        GENERATED true
)
include_directories(asm_compiler)
add_dependencies(vdf_bench asm_compiler)

set(CMAKE_CXX_FLAGS "-flto -std=c++1z -D VDF_MODE=0 -D FAST_MACHINE=1 -no-pie -fvisibility=hidden -O3")
set(CMAKE_STATIC_LINKER_FLAGS "-no-pie")

target_link_libraries(${PROJECT_NAME} PRIVATE
        ${GMP_LIBRARIES}
        ${GMPXX_LIBRARIES}
        ${Boost_LIBRARIES}
        -lmpfr
        -lflint
        -lstdc++
        -pthread
        )