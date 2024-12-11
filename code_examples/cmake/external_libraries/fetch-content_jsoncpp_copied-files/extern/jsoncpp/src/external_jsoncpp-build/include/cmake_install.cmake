# Install script for directory: E:/Projects/CPlusPlus/LearningCMake/UsingPackages/02-ExternalAdd_Json_WithCopiedHeaderOnly/extern/jsoncpp/include

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/json" TYPE FILE FILES
    "E:/Projects/CPlusPlus/LearningCMake/UsingPackages/02-ExternalAdd_Json_WithCopiedHeaderOnly/extern/jsoncpp/include/json/allocator.h"
    "E:/Projects/CPlusPlus/LearningCMake/UsingPackages/02-ExternalAdd_Json_WithCopiedHeaderOnly/extern/jsoncpp/include/json/assertions.h"
    "E:/Projects/CPlusPlus/LearningCMake/UsingPackages/02-ExternalAdd_Json_WithCopiedHeaderOnly/extern/jsoncpp/include/json/config.h"
    "E:/Projects/CPlusPlus/LearningCMake/UsingPackages/02-ExternalAdd_Json_WithCopiedHeaderOnly/extern/jsoncpp/include/json/forwards.h"
    "E:/Projects/CPlusPlus/LearningCMake/UsingPackages/02-ExternalAdd_Json_WithCopiedHeaderOnly/extern/jsoncpp/include/json/json.h"
    "E:/Projects/CPlusPlus/LearningCMake/UsingPackages/02-ExternalAdd_Json_WithCopiedHeaderOnly/extern/jsoncpp/include/json/json_features.h"
    "E:/Projects/CPlusPlus/LearningCMake/UsingPackages/02-ExternalAdd_Json_WithCopiedHeaderOnly/extern/jsoncpp/include/json/reader.h"
    "E:/Projects/CPlusPlus/LearningCMake/UsingPackages/02-ExternalAdd_Json_WithCopiedHeaderOnly/extern/jsoncpp/include/json/value.h"
    "E:/Projects/CPlusPlus/LearningCMake/UsingPackages/02-ExternalAdd_Json_WithCopiedHeaderOnly/extern/jsoncpp/include/json/version.h"
    "E:/Projects/CPlusPlus/LearningCMake/UsingPackages/02-ExternalAdd_Json_WithCopiedHeaderOnly/extern/jsoncpp/include/json/writer.h"
    )
endif()

