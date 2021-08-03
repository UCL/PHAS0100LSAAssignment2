/*=============================================================================

  PHAS0100LSAASSIGNMENT2: PHAS0100 LSA Assignment 2 package to demo MPI with CMake, CTest and Catch.

  Copyright (c) University College London (UCL). All rights reserved.

  This software is distributed WITHOUT ANY WARRANTY; without even
  the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
  PURPOSE.

  See LICENSE.txt in the top level directory for details.

=============================================================================*/

#ifndef pa2Win32ExportHeader_h
#define pa2Win32ExportHeader_h

/**
* \file pa2Win32ExportHeader.h
* \brief Header to sort Windows dllexport/dllimport.
*/

#if (defined(_WIN32) || defined(WIN32)) && !defined(PHAS0100LSAASSIGNMENT2_STATIC)
  #ifdef PHAS0100LSAASSIGNMENT2_WINDOWS_EXPORT
    #define PHAS0100LSAASSIGNMENT2_WINEXPORT __declspec(dllexport)
  #else
    #define PHAS0100LSAASSIGNMENT2_WINEXPORT __declspec(dllimport)
  #endif  /* PHAS0100LSAASSIGNMENT2_WINEXPORT */
#else
/* linux/mac needs nothing */
  #define PHAS0100LSAASSIGNMENT2_WINEXPORT
#endif

#endif
