# Install script for directory: E:/Projects/CPlusPlus/LearningCMake/UsingPackages/02-ExternalAdd_Json_WithCopiedHeaderOnly/extern/jsoncpp/src/lib_json

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
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "E:/Projects/CPlusPlus/LearningCMake/UsingPackages/02-ExternalAdd_Json_WithCopiedHeaderOnly/extern/jsoncpp/src/external_jsoncpp-build/lib/Debug/jsoncpp.lib")
  elseif("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "E:/Projects/CPlusPlus/LearningCMake/UsingPackages/02-ExternalAdd_Json_WithCopiedHeaderOnly/extern/jsoncpp/src/external_jsoncpp-build/lib/Release/jsoncpp.lib")
  elseif("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Mm][Ii][Nn][Ss][Ii][Zz][Ee][Rr][Ee][Ll])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "E:/Projects/CPlusPlus/LearningCMake/UsingPackages/02-ExternalAdd_Json_WithCopiedHeaderOnly/extern/jsoncpp/src/external_jsoncpp-build/lib/MinSizeRel/jsoncpp.lib")
  elseif("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "E:/Projects/CPlusPlus/LearningCMake/UsingPackages/02-ExternalAdd_Json_WithCopiedHeaderOnly/extern/jsoncpp/src/external_jsoncpp-build/lib/RelWithDebInfo/jsoncpp.lib")
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/objects-Debug/jsoncpp_object" TYPE FILE FILES
      "json_reader.obj"
      "json_value.obj"
      "json_writer.obj"
      FILES_FROM_DIR "E:/Projects/CPlusPlus/LearningCMake/UsingPackages/02-ExternalAdd_Json_WithCopiedHeaderOnly/extern/jsoncpp/src/external_jsoncpp-build/src/lib_json/jsoncpp_object.dir/Debug/")
  elseif("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/objects-Release/jsoncpp_object" TYPE FILE FILES
      "json_reader.obj"
      "json_value.obj"
      "json_writer.obj"
      FILES_FROM_DIR "E:/Projects/CPlusPlus/LearningCMake/UsingPackages/02-ExternalAdd_Json_WithCopiedHeaderOnly/extern/jsoncpp/src/external_jsoncpp-build/src/lib_json/jsoncpp_object.dir/Release/")
  elseif("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Mm][Ii][Nn][Ss][Ii][Zz][Ee][Rr][Ee][Ll])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/objects-MinSizeRel/jsoncpp_object" TYPE FILE FILES
      "json_reader.obj"
      "json_value.obj"
      "json_writer.obj"
      FILES_FROM_DIR "E:/Projects/CPlusPlus/LearningCMake/UsingPackages/02-ExternalAdd_Json_WithCopiedHeaderOnly/extern/jsoncpp/src/external_jsoncpp-build/src/lib_json/jsoncpp_object.dir/MinSizeRel/")
  elseif("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/objects-RelWithDebInfo/jsoncpp_object" TYPE FILE FILES
      "json_reader.obj"
      "json_value.obj"
      "json_writer.obj"
      FILES_FROM_DIR "E:/Projects/CPlusPlus/LearningCMake/UsingPackages/02-ExternalAdd_Json_WithCopiedHeaderOnly/extern/jsoncpp/src/external_jsoncpp-build/src/lib_json/jsoncpp_object.dir/RelWithDebInfo/")
  endif()
endif()

