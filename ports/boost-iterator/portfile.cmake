# Automatically generated by boost-vcpkg-helpers/generate-ports.ps1

include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/iterator
    REF boost-1.72.0
    SHA512 67f703777a0995263855af69a80ded81e151700a18daf141bea86243c0f9443c3a0110248c3c95c0bd0b575004eac618faff4f8a66820aac42d83ac03a152e3a
    HEAD_REF master
)

include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
