//===- PDBSymbolTypePointer.h - pointer type info ---------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_DEBUGINFO_PDB_PDBSYMBOLTYPEPOINTER_H
#define LLVM_DEBUGINFO_PDB_PDBSYMBOLTYPEPOINTER_H

#include "PDBSymbol.h"
#include "PDBTypes.h"
#include "llvm/Support/Compiler.h"

namespace llvm {

namespace pdb {

class LLVM_ABI PDBSymbolTypePointer : public PDBSymbol {
  DECLARE_PDB_SYMBOL_CONCRETE_TYPE(PDB_SymType::PointerType)
public:
  void dump(PDBSymDumper &Dumper) const override;
  void dumpRight(PDBSymDumper &Dumper) const override;

  FORWARD_SYMBOL_METHOD(isConstType)
  FORWARD_SYMBOL_ID_METHOD(getClassParent)
  FORWARD_SYMBOL_METHOD(getLength)
  FORWARD_SYMBOL_ID_METHOD(getLexicalParent)
  FORWARD_SYMBOL_METHOD(isReference)
  FORWARD_SYMBOL_METHOD(isRValueReference)
  FORWARD_SYMBOL_METHOD(isPointerToDataMember)
  FORWARD_SYMBOL_METHOD(isPointerToMemberFunction)
  FORWARD_SYMBOL_ID_METHOD_WITH_NAME(getType, getPointeeType)
  FORWARD_SYMBOL_METHOD(isRestrictedType)
  FORWARD_SYMBOL_METHOD(isUnalignedType)
  FORWARD_SYMBOL_METHOD(isVolatileType)
};

} // namespace pdb
} // namespace llvm

#endif // LLVM_DEBUGINFO_PDB_PDBSYMBOLTYPEPOINTER_H
