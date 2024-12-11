# Install script for directory: E:/Projects/CPlusPlus/LearningCMake/UsingPackages/02-ExternalAdd_Json_WithCopiedHeaderOnly/extern/jsoncpp

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "E:/Projects/CPlusPlus/LearningCMake/UsingPackages/02-ExternalAdd_Json_WithCopiedHeaderOnly/build/install/jsoncpp")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "E:/Projects/CPlusPlus/LearningCMake/UsingPackages/02-ExternalAdd_Json_WithCopiedHeaderOnly/extern/jsoncpp/src/external_jsoncpp-build/pkg-config/jsoncpp.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/jsoncpp/jsoncpp-targets.cmake")
    file(DIFFERENT EXPORT_FILE_CHANGED FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/jsoncpp/jsoncpp-targets.cmake"
         "E:/Projects/CPlusPlus/LearningCMake/UsingPackages/02-ExternalAdd_Json_WithCopiedHeaderOnly/extern/jsoncpp/src/external_jsoncpp-build/CMakeFiles/Export/lib/cmake/jsoncpp/jsoncpp-targets.cmake")
    if(EXPORT_FILE_CHANGED)
      file(GLOB OLD_CONFIG_FILES "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/jsoncpp/jsoncpp-targets-*.cmake")
      if(OLD_CONFIG_FILES)
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/jsoncpp/jsoncpp-targets.cmake\" will be replaced.  Removing files [${OLD_CONFIG_FILES}].")
        file(REMOVE ${OLD_CONFIG_FILES})
      endif()
    endif()
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/jsoncpp" TYPE FILE FILES "E:/Projects/CPlusPlus/LearningCMake/UsingPackages/02-ExternalAdd_Json_WithCopiedHeaderOnly/extern/jsoncpp/src/external_jsoncpp-build/CMakeFiles/Export/lib/cmake/jsoncpp/jsoncpp-targets.cmake")
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/jsoncpp" TYPE FILE FILES "E:/Projects/CPlusPlus/LearningCMake/UsingPackages/02-ExternalAdd_Json_WithCopiedHeaderOnly/extern/jsoncpp/src/external_jsoncpp-build/CMakeFiles/Export/lib/cmake/jsoncpp/jsoncpp-targets-debug.cmake")
  endif()
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Mm][Ii][Nn][Ss][Ii][Zz][Ee][Rr][Ee][Ll])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/jsoncpp" TYPE FILE FILES "E:/Projects/CPlusPlus/LearningCMake/UsingPackages/02-ExternalAdd_Json_WithCopiedHeaderOnly/extern/jsoncpp/src/external_jsoncpp-build/CMakeFiles/Export/lib/cmake/jsoncpp/jsoncpp-targets-minsizerel.cmake")
  endif()
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/jsoncpp" TYPE FILE FILES "E:/Projects/CPlusPlus/LearningCMake/UsingPackages/02-ExternalAdd_Json_WithCopiedHeaderOnly/extern/jsoncpp/src/external_jsoncpp-build/CMakeFiles/Export/lib/cmake/jsoncpp/jsoncpp-targets-relwithdebinfo.cmake")
  endif()
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/jsoncpp" TYPE FILE FILES "E:/Projects/CPlusPlus/LearningCMake/UsingPackages/02-ExternalAdd_Json_WithCopiedHeaderOnly/extern/jsoncpp/src/external_jsoncpp-build/CMakeFiles/Export/lib/cmake/jsoncpp/jsoncpp-targets-release.cmake")
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/jsoncpp" TYPE FILE FILES
    "E:/Projects/CPlusPlus/LearningCMake/UsingPackages/02-ExternalAdd_Json_WithCopiedHeaderOnly/extern/jsoncpp/src/external_jsoncpp-build/jsoncppConfigVersion.cmake"
    "E:/Projects/CPlusPlus/LearningCMake/UsingPackages/02-ExternalAdd_Json_WithCopiedHeaderOnly/extern/jsoncpp/src/external_jsoncpp-build/jsoncppConfig.cmake"
    "E:/Projects/CPlusPlus/LearningCMake/UsingPackages/02-ExternalAdd_Json_WithCopiedHeaderOnly/extern/jsoncpp/jsoncpp-namespaced-targets.cmake"
    )
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("E:/Projects/CPlusPlus/LearningCMake/UsingPackages/02-ExternalAdd_Json_WithCopiedHeaderOnly/extern/jsoncpp/src/external_jsoncpp-build/src/cmake_install.cmake")
  include("E:/Projects/CPlusPlus/LearningCMake/UsingPackages/02-ExternalAdd_Json_WithCopiedHeaderOnly/extern/jsoncpp/src/external_jsoncpp-build/include/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "E:/Projects/CPlusPlus/LearningCMake/UsingPackages/02-ExternalAdd_Json_WithCopiedHeaderOnly/extern/jsoncpp/src/external_jsoncpp-build/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
