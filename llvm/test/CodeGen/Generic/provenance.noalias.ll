; RUN: llc < %s

define ptr @test(ptr %p) {
  %p.decl = tail call ptr @llvm.noalias.decl.p0.p0.i32(ptr null, i32 0, metadata !0)
  %p.provenance = tail call ptr @llvm.provenance.noalias.p0.p0.p0.p0.i32(ptr %p, ptr %p.decl, ptr null, ptr undef, i32 0, metadata !0)
  %p.guard = call ptr @llvm.experimental.ptr.provenance.p0.p0(ptr %p, ptr %p.provenance)
  ret i32* %p.guard
}

declare ptr @llvm.noalias.decl.p0.p0.i32(ptr, i32, metadata) argmemonly nounwind
declare ptr @llvm.provenance.noalias.p0.p0.p0.p0.i32(ptr, ptr, ptr, ptr, i32, metadata)  argmemonly nounwind speculatable
declare ptr @llvm.experimental.ptr.provenance.p0.p0(ptr, ptr) nounwind readnone

!0 = !{!0, !"some domain"}
!1 = !{!1, !0, !"some scope"}
