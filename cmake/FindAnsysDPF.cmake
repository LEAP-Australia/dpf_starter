# Find Ansys DFP
#   Ansys DPF is a 

#
# This module defines:
#   AnsysDPF_VERSION        - Ansys Release for DPF
#   AnsysDPF_INCLUDE_DIRS   - include path for dpf_api.h
#
#=============================================================================
# Copyright 2021, Nishit Joseph
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice, this
#    list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# The views and conclusions contained in the software and documentation are those
# of the authors and should not be interpreted as representing official policies,
# either expressed or implied, of the FreeBSD Project.
#=============================================================================

if(ANSYS_DPF_VERSION)
    set(SUPPORTED_ANSYS_DPF_VERSIONS "${ANSYS_DPF_VERSION}")
else()
set(SUPPORTED_ANSYS_DPF_VERSIONS
    "232" "231" "222" "221")
endif()

if(NOT ANSYS_ROOT)
  set(ANSYS_ROOT "")
  foreach(ansys_ver ${SUPPORTED_ANSYS_DPF_VERSIONS})
    set(awp_name "AWP_ROOT${ansys_ver}")
    if(DEFINED ENV{${awp_name}})
      set(ANSYS_ROOT $ENV{${awp_name}})
      string(REPLACE "\\" "/" ANSYS_ROOT "${ANSYS_ROOT}")
      set (AnsysDPF_VERSION "v${ansys_ver}")
      break()
    endif()
  endforeach()
endif()

if(ANSYS_ROOT STREQUAL "")
  message(ERROR "Unable to determin ANSYS Root Directory")
endif()

find_path(
  AnsysDPF_INCLUDE_DIRS
  NAME "dpf_api.h"
  PATHS "${ANSYS_ROOT}/dpf/include"
)

include(FindPackageHandleStandardArgs)

find_package_handle_standard_args(
  AnsysDPF
  FOUND_VAR AnsysDPF_FOUND
  REQUIRED_VARS
  AnsysDPF_INCLUDE_DIRS 
  VERSION_VAR AnsysDPF_VERSION
)

add_library(Ansys::AnsysDPF INTERFACE IMPORTED)
add_library(Ansys::DPF ALIAS Ansys::AnsysDPF)

set_target_properties(
  Ansys::AnsysDPF PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES "${AnsysDPF_INCLUDE_DIRS}"
)

mark_as_advanced(
  SUPPORTED_ANSYS_DPF_VERSIONS
  ANSYS_ROOT
)
