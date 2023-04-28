; RUN: llc < %s

define ptr @test(ptr %p) {
  %p.decl = tail call ptr @llvm.noalias.decl.p0.p0.i32(ptr null, i32 0, metadata !0)
  %v = call ptr @llvm.noalias.p0.p0.p0.i32(ptr %p, ptr %p.decl, ptr null, i32 0, metadata !0)
  ret i32* %v
}

declare ptr @llvm.noalias.decl.p0.p0.i32(ptr, i32, metadata) argmemonly nounwind
declare ptr @llvm.noalias.p0.p0.p0.i32(ptr, ptr, ptr, i32, metadata) argmemonly nounwind speculatable

!0 = !{!0, !"some domain"}
!1 = !{!1, !0, !"some scope"}
