; RUN: llc < %s

define ptr @test(ptr %p, ptr %p.provenance) {
  %p.joined = call ptr @llvm.experimental.ptr.provenance.p0.p0(ptr %p, ptr %p.provenance)
  ret ptr %p.joined
}

declare ptr @llvm.experimental.ptr.provenance.p0.p0(ptr, ptr) nounwind readnone
