//===- PDBSymbolPublicSymbol.h - public symbol info -------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_DEBUGINFO_PDB_PDBSYMBOLPUBLICSYMBOL_H
#define LLVM_DEBUGINFO_PDB_PDBSYMBOLPUBLICSYMBOL_H

#include "PDBSymbol.h"
#include "PDBTypes.h"
#include "llvm/Support/Compiler.h"

namespace llvm {

namespace pdb {

class LLVM_ABI PDBSymbolPublicSymbol : public PDBSymbol {
  DECLARE_PDB_SYMBOL_CONCRETE_TYPE(PDB_SymType::PublicSymbol)
public:
  void dump(PDBSymDumper &Dumper) const override;

  FORWARD_SYMBOL_METHOD(getAddressOffset)
  FORWARD_SYMBOL_METHOD(getAddressSection)
  FORWARD_SYMBOL_METHOD(isCode)
  FORWARD_SYMBOL_METHOD(isFunction)
  FORWARD_SYMBOL_METHOD(getLength)
  FORWARD_SYMBOL_ID_METHOD(getLexicalParent)
  FORWARD_SYMBOL_METHOD(getLocationType)
  FORWARD_SYMBOL_METHOD(isManagedCode)
  FORWARD_SYMBOL_METHOD(isMSILCode)
  FORWARD_SYMBOL_METHOD(getName)
  FORWARD_SYMBOL_METHOD(getRelativeVirtualAddress)
  FORWARD_SYMBOL_METHOD(getVirtualAddress)
  FORWARD_SYMBOL_METHOD(getUndecoratedName)
};

} // namespace pdb
} // namespace llvm

#endif // LLVM_DEBUGINFO_PDB_PDBSYMBOLPUBLICSYMBOL_H
