#/*============================================================================
#
#  PHAS0100LSAASSIGNMENT2: PHAS0100 LSA Assignment 2 package to demo MPI with CMake, CTest and Catch.
#
#  Copyright (c) University College London (UCL). All rights reserved.
#
#  This software is distributed WITHOUT ANY WARRANTY; without even
#  the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
#  PURPOSE.
#
#  See LICENSE.txt in the top level directory for details.
#
#============================================================================*/

set(_command_line_apps
  pa2HelloWorld
)

foreach(_app ${_command_line_apps})
  add_executable(${_app} ${_app}.cpp)
  target_link_libraries(${_app} ${PHAS0100LSAASSIGNMENT2_LIBRARIES} ${ALL_THIRD_PARTY_LIBRARIES})
endforeach()
