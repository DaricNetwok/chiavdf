
macro(setup_libgmp)

    #find_package(GMP REQUIRED)

    include(ExternalProject)
    set(gmp_ROOT_DIR "${CMAKE_BINARY_DIR}/_deps/gmp")
    ExternalProject_Add(GMP
            PREFIX ${gmp_ROOT_DIR}
            URL https://gmplib.org/download/gmp/gmp-6.2.1.tar.xz
            URL_HASH MD5=0b82665c4a92fd2ade7440c13fcaa42b

            DOWNLOAD_DIR ${gmp_ROOT_DIR}/download
            SOURCE_DIR ${gmp_ROOT_DIR}/src
            BINARY_DIR ${gmp_ROOT_DIR}/bin
            INSTALL_DIR ${gmp_ROOT_DIR}/install
            STAMP_DIR ${gmp_ROOT_DIR}/stamp

            UPDATE_COMMAND ""
            PATCH_COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_SOURCE_DIR}/lib/gmp-patch-6.2.1/ <SOURCE_DIR>/
            CONFIGURE_COMMAND <SOURCE_DIR>/./configure --prefix=<INSTALL_DIR> --enable-fat --enable-cxx
            BUILD_COMMAND ${CMAKE_MAKE_PROGRAM} -j${NumberOfProcessors}
            )

    ExternalProject_Get_Property(GMP INSTALL_DIR)
    set(gmp_LIB_DIR ${INSTALL_DIR}/lib)
    set(gmp_INCLUDE_DIR ${INSTALL_DIR}/include)
    set(GMP_LIBRARIES "-lgmp")
    set(GMPXX_LIBRARIES "-lgmpxx")
    link_directories(${gmp_LIB_DIR})

endmacro()

