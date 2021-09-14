CMAKE_MINIMUM_REQUIRED(VERSION 3.14 FATAL_ERROR)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

IF (NOT CMAKE_BUILD_TYPE)
    SET(CMAKE_BUILD_TYPE "RELEASE")
ENDIF ()

set(CMAKE_ASM_COMPILER "as")

list(APPEND CMAKE_MODULE_PATH
        ${CMAKE_CURRENT_LIST_DIR}/../cmake)

set(PROJECT_NAME "asm_compiler")
project(${PROJECT_NAME} VERSION 0.1.0)

#find_package(GMP REQUIRED)
find_package(GMPXX REQUIRED)
find_package(Boost REQUIRED)

set(VERBOSE 1)
add_executable(${PROJECT_NAME}
        compile_asm.cpp
        )
target_link_libraries(${PROJECT_NAME} PRIVATE
        ${GMP_LIBRARIES} ${GMPXX_LIBRARIES}
        )


message(STATUS "Now executing compiler: ${PROJECT_NAME}")
add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
        COMMAND "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}"
        COMMAND "${CMAKE_ASM_COMPILER}" "-o"
        "${CMAKE_CURRENT_BINARY_DIR}/asm_compiled.o"
        "${CMAKE_CURRENT_BINARY_DIR}/asm_compiled.s"
        COMMENT "Generating assembly and compiling: ${PROJECT_NAME} \n${CMAKE_CURRENT_BINARY_DIR}/asm_compiled.o")

add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
        COMMAND "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}" "avx2"
        COMMAND "${CMAKE_ASM_COMPILER}" "-o"
        "${CMAKE_CURRENT_BINARY_DIR}/avx2_asm_compiled.o"
        "${CMAKE_CURRENT_BINARY_DIR}/avx2_asm_compiled.s"
        COMMENT "Now executing compiler: ${CMAKE_ASM_COMPILER} ${PROJECT_NAME} \n${CMAKE_CURRENT_BINARY_DIR}/avx2_asm_compiled.o")

add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
        COMMAND "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}" "avx512"
        COMMAND "${CMAKE_ASM_COMPILER}" "-o"
        "${CMAKE_CURRENT_BINARY_DIR}/avx512_asm_compiled.o"
        "${CMAKE_CURRENT_BINARY_DIR}/avx512_asm_compiled.s"
        COMMENT "Now executing compiler: ${PROJECT_NAME} \n${CMAKE_CURRENT_BINARY_DIR}/avx512_asm_compiled.o")

#add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
#        COMMAND "${CMAKE_ASM_COMPILER}"
#                "${CMAKE_CURRENT_BINARY_DIR}/asm_compiled.s"
#                "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}/avx2_asm_compiled.s"
#                "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}/avx512_asm_compiled.s"
#                "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}/compile_asm.o"
#        #DEPENDS
#        COMMENT "Now executing compiler: ${PROJECT_NAME} \n${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}"
#
#        )

#add_executable(${PROJECT_NAME}
#        ${CMAKE_CURRENT_SOURCE_DIR}/vdf_bench.cpp
#        vdf.h
#        asm_main.h
#        asm_types.h
#        asm_vm.h
#        vdf_new.h
#        bit_manipulation.h
#        )
#
#include_directories(Boost_INCLUDE)
#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++17")
#include_directories(/home/mjhatamy/workspace/crypto/dev/mpir_build)
#
#message(STATUS "GMP: ${GMP_INCLUDE} -- ${GMP_LIBRARY_DIR}")
##target_compile_definitions(vdf_bench PRIVATE -DCOMPILE_ASM)
#target_link_directories(${PROJECT_NAME}
#        PRIVATE
#        /home/mjhatamy/workspace/crypto/dev/mpir_build/lib)
#target_link_libraries(${PROJECT_NAME} PRIVATE
#        ${GMP_LIBRARIES}
#        ${Boost_LIBRARIES}
#        ${GMPXX_LIBRARIES}
#        -lmpir
#        -lmpfr
#        -lflint
#        -lstdc++
#        -pthread)
#

