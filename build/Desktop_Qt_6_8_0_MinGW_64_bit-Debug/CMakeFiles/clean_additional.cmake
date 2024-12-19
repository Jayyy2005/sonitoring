# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles\\appsonitoring_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\appsonitoring_autogen.dir\\ParseCache.txt"
  "appsonitoring_autogen"
  )
endif()
