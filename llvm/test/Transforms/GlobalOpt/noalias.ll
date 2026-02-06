; RUN: opt < %s -passes=globalopt -S | FileCheck %s
; RUN: opt < %s -passes=module(convert-noalias),globalopt -S | FileCheck %s

; CHECK-NOT: @G0
; CHECK: @G1 =
; CHECK-SAME: constant
@G0 = internal global i32 zeroinitializer
@G1 = internal global [4 x i32] [i32 1, i32 2, i32 3, i32 4]

; CHECK-LABEL: define void @test1
; CHECK-NEXT: ret void
define void @test1() {
  %decl = call ptr @llvm.noalias.decl.p0.p0.i64(ptr null, i64 0, metadata !1)
  %r = call ptr @llvm.noalias.p0.p0.p0.i64(ptr @G0, ptr %decl, ptr null, i64 0, metadata !1), !noalias !1
  store i32 123, ptr %r, !noalias !1
  ret void
}

; CHECK-LABEL: define i32 @test2
; CHECK: load i32
define i32 @test2(i64 %i) {
  %decl = call ptr @llvm.noalias.decl.p0.p0.i64(ptr null, i64 0, metadata !4)
  %r = call ptr @llvm.noalias.p0.p0.p0.i64(ptr @G1, ptr %decl, ptr null, i64 0, metadata !4), !noalias !4
  %tmp1 = getelementptr i32, ptr %r, i64 %i
  %tmp2 = load i32, ptr %tmp1, !noalias !4
  ret i32 %tmp2
}

declare ptr @llvm.noalias.decl.p0.p0.i64(ptr, i64, metadata) nounwind willreturn memory(inaccessiblemem: readwrite)
declare ptr @llvm.noalias.p0.p0.p0.i64(ptr, ptr, ptr, i64, metadata) nounwind willreturn memory(argmem: readwrite)

!1 = !{!2}
!2 = distinct !{!2, !3, !"test1: r"}
!3 = distinct !{!3, !"test1"}
!4 = !{!5}
!5 = distinct !{!5, !6, !"test2: r"}
!6 = distinct !{!6, !"test2"}
