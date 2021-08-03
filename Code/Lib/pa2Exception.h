/*=============================================================================

  PHAS0100LSAASSIGNMENT2: PHAS0100 LSA Assignment 2 package to demo MPI with CMake, CTest and Catch.

  Copyright (c) University College London (UCL). All rights reserved.

  This software is distributed WITHOUT ANY WARRANTY; without even
  the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
  PURPOSE.

  See LICENSE.txt in the top level directory for details.

=============================================================================*/

#ifndef pa2Exception_h
#define pa2Exception_h

#include "pa2Win32ExportHeader.h"
#include <stdexcept>
#include <ostream>
#include <sstream>

namespace pa2 {

/**
* \class Exception
* \brief Base exception class.
* \ingroup types
*/
class PHAS0100LSAASSIGNMENT2_WINEXPORT Exception : public std::exception
{
public:

  Exception(const std::string& fileName, int lineNumber);
  virtual ~Exception();

  std::string GetFileName() const;
  int GetLineNumber() const;

  std::string GetDescription() const;
  void SetDescription(const std::string& desc);
  virtual const char* What();

  Exception& operator<<(std::ostream& (*func)(std::ostream&))
  {
    std::ostringstream ss;
    ss << this->GetDescription() << func;
    this->SetDescription(ss.str());
    return *this;
  }

  template <class T> inline Exception& operator<<(T& data)
  {
    std::ostringstream ss;
    ss << this->GetDescription() << data;
    this->SetDescription(ss.str());
    return *this;
  }

   template <class T> inline Exception& operator<<(const T& data)
   {
     std::ostringstream ss;
     ss << this->GetDescription() << data;
     this->SetDescription(ss.str());
     return *this;
   }

private:
  std::string m_Description;
  std::string m_FileName;
  int         m_LineNumber;
};

} // end namespace

#endif
