// -*- C++ -*-
//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef _LIBCPP___CXX03___ALGORITHM_NONE_OF_H
#define _LIBCPP___CXX03___ALGORITHM_NONE_OF_H

#include <__cxx03/__config>

#if !defined(_LIBCPP_HAS_NO_PRAGMA_SYSTEM_HEADER)
#  pragma GCC system_header
#endif

_LIBCPP_BEGIN_NAMESPACE_STD

template <class _InputIterator, class _Predicate>
_LIBCPP_NODISCARD inline _LIBCPP_HIDE_FROM_ABI bool
none_of(_InputIterator __first, _InputIterator __last, _Predicate __pred) {
  for (; __first != __last; ++__first)
    if (__pred(*__first))
      return false;
  return true;
}

_LIBCPP_END_NAMESPACE_STD

#endif // _LIBCPP___CXX03___ALGORITHM_NONE_OF_H
