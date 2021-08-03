/*=============================================================================

  PHAS0100LSAASSIGNMENT2: PHAS0100 LSA Assignment 2 package to demo MPI with CMake, CTest and Catch.

  Copyright (c) University College London (UCL). All rights reserved.

  This software is distributed WITHOUT ANY WARRANTY; without even
  the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
  PURPOSE.

  See LICENSE.txt in the top level directory for details.

=============================================================================*/

#ifndef pa2ExceptionMacro_h
#define pa2ExceptionMacro_h

#include "pa2Exception.h"

#define pa2ExceptionThrow() throw pa2::Exception(__FILE__,__LINE__)

#endif
