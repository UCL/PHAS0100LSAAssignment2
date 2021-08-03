/*=============================================================================

  PHAS0100LSAASSIGNMENT2: PHAS0100 LSA Assignment 2 package to demo MPI with CMake, CTest and Catch.

  Copyright (c) University College London (UCL). All rights reserved.

  This software is distributed WITHOUT ANY WARRANTY; without even
  the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
  PURPOSE.

  See LICENSE.txt in the top level directory for details.

=============================================================================*/

#include <pa2MyFunctions.h>
#include <pa2ExceptionMacro.h>
#include <iostream>

#include <mpi.h>

/**
 * \brief Command Line Entry Point for end-user MPI program.
 */
int main(int argc, char** argv)
{
  int returnStatus = EXIT_FAILURE;

  // Must be first MPI call
  MPI_Init(&argc, &argv);

  try
  {
    int rank, size;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    std::cout << "Processor " << rank << " of " << size << " says hello\n";

    returnStatus = EXIT_SUCCESS;
  }
  catch (pa2::Exception& e)
  {
    std::cerr << "Caught pa2::Exception: " << e.GetDescription() << std::endl;
  }
  catch (std::exception& e)
  {
    std::cerr << "Caught std::exception: " << e.what() << std::endl;
  }

  // Must be last MPI call
  MPI_Finalize();

  return returnStatus;
}
