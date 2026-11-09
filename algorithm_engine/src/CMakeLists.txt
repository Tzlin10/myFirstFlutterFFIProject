# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.

cmake_minimum_required(VERSION 3.10)

project(algorithm_engine_library VERSION 0.0.1 LANGUAGES C CXX)

add_library(algorithm_engine SHARED
  algorithm_engine.cpp
)

set_target_properties(algorithm_engine PROPERTIES
  PUBLIC_HEADER algorithm_engine.h
  OUTPUT_NAME "algorithm_engine"
  CXX_STANDARD 17
  CXX_STANDARD_REQUIRED ON
)

target_include_directories(algorithm_engine PUBLIC
  ${CMAKE_CURRENT_SOURCE_DIR}
)

target_compile_definitions(algorithm_engine PUBLIC DART_SHARED_LIB)

if (ANDROID)
  target_link_options(algorithm_engine PRIVATE "-Wl,-z,max-page-size=16384")
endif()
