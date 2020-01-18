# Notes:
# 1. Official released provided as tar files from https://laws.lanl.gov/projects/data/eos/eospacReleases.php
# 2. Versions ported to support MSVC are at https://github.com/KineticTheory/eospac6
# 3. The repository contains two top level directories.  The actual source code is in the "Source" directory (Source/CMakeLists.txt)

include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)
string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "static" EOSPAC_BUILD_STATIC)
unset(eospac_extra_config_options)
if( EOSPAC_BUILD_STATIC )
    set( eospac_extra_config_options "-DEOSPAC6_LIBRARY_TYPE=STATIC" )
#else()
#    set( eospac_extra_config_options "-DEOSPAC6_LIBRARY_TYPE=SHARED" )
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO KineticTheory/eospac6
    REF eospac-6.4.0
    SHA512 ddab0bcb5f63d2dca8ba0cb4b8fa076f5d9ba5e3c1eb97be3e109597a25356210f6fdbdd935d9adcc8a94a45a3a0b05a1ee4bb621935a7b001303defff542417
    HEAD_REF develop
    #PATCHES
    #  fix-compile-error-uwp.patch
		#  fix-uwperror.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}/Source
    # PREFER_NINJA
    OPTIONS ${eospac_extra_config_options}
)

vcpkg_install_cmake()

# vcpkg_fixup_cmake_targets(CONFIG_PATH lib/draco/cmake)

# Install tools and plugins
#file(GLOB TOOLS "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/*.exe")
#if(TOOLS)
#    file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools/draco)
#    file(COPY ${TOOLS} DESTINATION ${CURRENT_PACKAGES_DIR}/tools/draco)
#endif()

#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin)
#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib/draco)
#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin)
#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/lib/draco)

#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

#vcpkg_copy_pdbs()

# Handle copyright
file(COPY ${SOURCE_PATH}/Source/COPYRIGHTNOTICE DESTINATION ${CURRENT_PACKAGES_DIR}/share/eospac)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/eospac/COPYRIGHTNOTICE ${CURRENT_PACKAGES_DIR}/share/eospac/copyright)

# only keep one set of include files. 
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)