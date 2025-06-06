; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mattr=+sve2 -force-streaming-compatible < %s | FileCheck %s
; RUN: llc -mattr=+sme -force-streaming < %s | FileCheck %s
; RUN: llc -force-streaming-compatible < %s | FileCheck %s --check-prefix=NONEON-NOSVE


target triple = "aarch64-unknown-linux-gnu"

define i1 @ptest_v16i1(ptr %a, ptr %b) {
; CHECK-LABEL: ptest_v16i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q1, q0, [x0, #32]
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    ldp q3, q2, [x0]
; CHECK-NEXT:    fcmne p1.s, p0/z, z0.s, #0.0
; CHECK-NEXT:    fcmne p2.s, p0/z, z1.s, #0.0
; CHECK-NEXT:    fcmne p3.s, p0/z, z2.s, #0.0
; CHECK-NEXT:    fcmne p0.s, p0/z, z3.s, #0.0
; CHECK-NEXT:    mov z0.s, p1/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    mov z1.s, p2/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    mov z2.s, p3/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    mov z3.s, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    ptrue p0.h, vl4
; CHECK-NEXT:    uzp1 z5.h, z0.h, z0.h
; CHECK-NEXT:    uzp1 z4.h, z1.h, z1.h
; CHECK-NEXT:    uzp1 z1.h, z2.h, z2.h
; CHECK-NEXT:    uzp1 z0.h, z3.h, z3.h
; CHECK-NEXT:    splice z2.h, p0, { z4.h, z5.h }
; CHECK-NEXT:    splice z0.h, p0, { z0.h, z1.h }
; CHECK-NEXT:    ptrue p0.b, vl8
; CHECK-NEXT:    uzp1 z2.b, z2.b, z2.b
; CHECK-NEXT:    uzp1 z1.b, z0.b, z0.b
; CHECK-NEXT:    splice z0.b, p0, { z1.b, z2.b }
; CHECK-NEXT:    ptrue p0.b, vl16
; CHECK-NEXT:    umaxv b0, p0, z0.b
; CHECK-NEXT:    fmov w8, s0
; CHECK-NEXT:    and w0, w8, #0x1
; CHECK-NEXT:    ret
;
; NONEON-NOSVE-LABEL: ptest_v16i1:
; NONEON-NOSVE:       // %bb.0:
; NONEON-NOSVE-NEXT:    sub sp, sp, #64
; NONEON-NOSVE-NEXT:    .cfi_def_cfa_offset 64
; NONEON-NOSVE-NEXT:    ldp q1, q0, [x0]
; NONEON-NOSVE-NEXT:    mov w8, #255 // =0xff
; NONEON-NOSVE-NEXT:    ldp q3, q2, [x0, #32]
; NONEON-NOSVE-NEXT:    stp q1, q2, [sp]
; NONEON-NOSVE-NEXT:    stp q0, q3, [sp, #32]
; NONEON-NOSVE-NEXT:    ldp s1, s0, [sp, #40]
; NONEON-NOSVE-NEXT:    fcmp s0, #0.0
; NONEON-NOSVE-NEXT:    csel w9, w8, wzr, ne
; NONEON-NOSVE-NEXT:    fcmp s1, #0.0
; NONEON-NOSVE-NEXT:    ldp s1, s0, [sp]
; NONEON-NOSVE-NEXT:    csetm w10, ne
; NONEON-NOSVE-NEXT:    fcmp s0, #0.0
; NONEON-NOSVE-NEXT:    csetm w11, ne
; NONEON-NOSVE-NEXT:    fcmp s1, #0.0
; NONEON-NOSVE-NEXT:    ldp s0, s1, [sp, #8]
; NONEON-NOSVE-NEXT:    csinv w11, w11, wzr, eq
; NONEON-NOSVE-NEXT:    fcmp s0, #0.0
; NONEON-NOSVE-NEXT:    csinv w11, w11, wzr, eq
; NONEON-NOSVE-NEXT:    fcmp s1, #0.0
; NONEON-NOSVE-NEXT:    ldp s0, s1, [sp, #32]
; NONEON-NOSVE-NEXT:    csinv w11, w11, wzr, eq
; NONEON-NOSVE-NEXT:    fcmp s0, #0.0
; NONEON-NOSVE-NEXT:    csinv w11, w11, wzr, eq
; NONEON-NOSVE-NEXT:    fcmp s1, #0.0
; NONEON-NOSVE-NEXT:    ldp s0, s1, [sp, #48]
; NONEON-NOSVE-NEXT:    csinv w11, w11, wzr, eq
; NONEON-NOSVE-NEXT:    cmp w11, w10
; NONEON-NOSVE-NEXT:    csel w10, w11, w10, hi
; NONEON-NOSVE-NEXT:    and w10, w10, #0xff
; NONEON-NOSVE-NEXT:    cmp w10, w9
; NONEON-NOSVE-NEXT:    csel w9, w10, w9, hi
; NONEON-NOSVE-NEXT:    fcmp s0, #0.0
; NONEON-NOSVE-NEXT:    csel w10, w8, wzr, ne
; NONEON-NOSVE-NEXT:    cmp w9, w10
; NONEON-NOSVE-NEXT:    csel w9, w9, w10, hi
; NONEON-NOSVE-NEXT:    fcmp s1, #0.0
; NONEON-NOSVE-NEXT:    ldp s0, s1, [sp, #56]
; NONEON-NOSVE-NEXT:    csel w10, w8, wzr, ne
; NONEON-NOSVE-NEXT:    cmp w9, w10
; NONEON-NOSVE-NEXT:    csel w9, w9, w10, hi
; NONEON-NOSVE-NEXT:    fcmp s0, #0.0
; NONEON-NOSVE-NEXT:    csel w10, w8, wzr, ne
; NONEON-NOSVE-NEXT:    cmp w9, w10
; NONEON-NOSVE-NEXT:    csel w9, w9, w10, hi
; NONEON-NOSVE-NEXT:    fcmp s1, #0.0
; NONEON-NOSVE-NEXT:    ldp s0, s1, [sp, #16]
; NONEON-NOSVE-NEXT:    csel w10, w8, wzr, ne
; NONEON-NOSVE-NEXT:    cmp w9, w10
; NONEON-NOSVE-NEXT:    csel w9, w9, w10, hi
; NONEON-NOSVE-NEXT:    fcmp s0, #0.0
; NONEON-NOSVE-NEXT:    csel w10, w8, wzr, ne
; NONEON-NOSVE-NEXT:    cmp w9, w10
; NONEON-NOSVE-NEXT:    csel w9, w9, w10, hi
; NONEON-NOSVE-NEXT:    fcmp s1, #0.0
; NONEON-NOSVE-NEXT:    ldp s0, s1, [sp, #24]
; NONEON-NOSVE-NEXT:    csel w10, w8, wzr, ne
; NONEON-NOSVE-NEXT:    cmp w9, w10
; NONEON-NOSVE-NEXT:    csel w9, w9, w10, hi
; NONEON-NOSVE-NEXT:    fcmp s0, #0.0
; NONEON-NOSVE-NEXT:    csel w10, w8, wzr, ne
; NONEON-NOSVE-NEXT:    cmp w9, w10
; NONEON-NOSVE-NEXT:    csel w9, w9, w10, hi
; NONEON-NOSVE-NEXT:    fcmp s1, #0.0
; NONEON-NOSVE-NEXT:    csel w8, w8, wzr, ne
; NONEON-NOSVE-NEXT:    cmp w9, w8
; NONEON-NOSVE-NEXT:    csel w8, w9, w8, hi
; NONEON-NOSVE-NEXT:    and w0, w8, #0x1
; NONEON-NOSVE-NEXT:    add sp, sp, #64
; NONEON-NOSVE-NEXT:    ret
  %v0 = bitcast ptr %a to ptr
  %v1 = load <16 x float>, ptr %v0, align 4
  %v2 = fcmp une <16 x float> %v1, zeroinitializer
  %v3 = call i1 @llvm.vector.reduce.or.i1.v16i1 (<16 x i1> %v2)
  ret i1 %v3
}

define i1 @ptest_or_v16i1(ptr %a, ptr %b) {
; CHECK-LABEL: ptest_or_v16i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0, #32]
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    ldp q2, q3, [x1, #32]
; CHECK-NEXT:    ldp q4, q5, [x0]
; CHECK-NEXT:    fcmne p1.s, p0/z, z1.s, #0.0
; CHECK-NEXT:    ldp q6, q1, [x1]
; CHECK-NEXT:    fcmne p3.s, p0/z, z3.s, #0.0
; CHECK-NEXT:    fcmne p2.s, p0/z, z0.s, #0.0
; CHECK-NEXT:    fcmne p5.s, p0/z, z2.s, #0.0
; CHECK-NEXT:    fcmne p4.s, p0/z, z5.s, #0.0
; CHECK-NEXT:    fcmne p7.s, p0/z, z4.s, #0.0
; CHECK-NEXT:    fcmne p6.s, p0/z, z1.s, #0.0
; CHECK-NEXT:    fcmne p0.s, p0/z, z6.s, #0.0
; CHECK-NEXT:    mov z0.s, p1/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    mov z2.s, p3/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    mov z1.s, p2/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    mov z4.s, p5/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    mov z3.s, p4/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    mov z6.s, p7/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    mov z5.s, p6/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    mov z7.s, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    uzp1 z17.h, z0.h, z0.h
; CHECK-NEXT:    uzp1 z19.h, z2.h, z2.h
; CHECK-NEXT:    uzp1 z16.h, z1.h, z1.h
; CHECK-NEXT:    ptrue p0.h, vl4
; CHECK-NEXT:    uzp1 z1.h, z3.h, z3.h
; CHECK-NEXT:    uzp1 z18.h, z4.h, z4.h
; CHECK-NEXT:    uzp1 z3.h, z5.h, z5.h
; CHECK-NEXT:    uzp1 z0.h, z6.h, z6.h
; CHECK-NEXT:    uzp1 z2.h, z7.h, z7.h
; CHECK-NEXT:    splice z4.h, p0, { z16.h, z17.h }
; CHECK-NEXT:    splice z5.h, p0, { z18.h, z19.h }
; CHECK-NEXT:    splice z0.h, p0, { z0.h, z1.h }
; CHECK-NEXT:    splice z1.h, p0, { z2.h, z3.h }
; CHECK-NEXT:    ptrue p0.b, vl8
; CHECK-NEXT:    uzp1 z3.b, z4.b, z4.b
; CHECK-NEXT:    uzp1 z5.b, z5.b, z5.b
; CHECK-NEXT:    uzp1 z2.b, z0.b, z0.b
; CHECK-NEXT:    uzp1 z4.b, z1.b, z1.b
; CHECK-NEXT:    splice z0.b, p0, { z2.b, z3.b }
; CHECK-NEXT:    splice z1.b, p0, { z4.b, z5.b }
; CHECK-NEXT:    ptrue p0.b, vl16
; CHECK-NEXT:    orr z0.d, z0.d, z1.d
; CHECK-NEXT:    umaxv b0, p0, z0.b
; CHECK-NEXT:    fmov w8, s0
; CHECK-NEXT:    and w0, w8, #0x1
; CHECK-NEXT:    ret
;
; NONEON-NOSVE-LABEL: ptest_or_v16i1:
; NONEON-NOSVE:       // %bb.0:
; NONEON-NOSVE-NEXT:    sub sp, sp, #128
; NONEON-NOSVE-NEXT:    .cfi_def_cfa_offset 128
; NONEON-NOSVE-NEXT:    ldp q1, q0, [x0]
; NONEON-NOSVE-NEXT:    ldp q3, q2, [x0, #32]
; NONEON-NOSVE-NEXT:    str q1, [sp]
; NONEON-NOSVE-NEXT:    stp q0, q3, [sp, #48]
; NONEON-NOSVE-NEXT:    str q2, [sp, #32]
; NONEON-NOSVE-NEXT:    ldr s1, [sp, #52]
; NONEON-NOSVE-NEXT:    ldr q0, [x1, #16]
; NONEON-NOSVE-NEXT:    str q0, [sp, #96]
; NONEON-NOSVE-NEXT:    ldp s2, s0, [sp, #96]
; NONEON-NOSVE-NEXT:    fcmp s0, #0.0
; NONEON-NOSVE-NEXT:    ldr s0, [sp, #48]
; NONEON-NOSVE-NEXT:    csetm w8, ne
; NONEON-NOSVE-NEXT:    fcmp s1, #0.0
; NONEON-NOSVE-NEXT:    ldr q1, [x1]
; NONEON-NOSVE-NEXT:    str q1, [sp, #16]
; NONEON-NOSVE-NEXT:    csinv w8, w8, wzr, eq
; NONEON-NOSVE-NEXT:    fcmp s2, #0.0
; NONEON-NOSVE-NEXT:    ldr s2, [sp, #12]
; NONEON-NOSVE-NEXT:    csetm w9, ne
; NONEON-NOSVE-NEXT:    fcmp s0, #0.0
; NONEON-NOSVE-NEXT:    ldp s1, s0, [sp, #24]
; NONEON-NOSVE-NEXT:    csinv w9, w9, wzr, eq
; NONEON-NOSVE-NEXT:    fcmp s0, #0.0
; NONEON-NOSVE-NEXT:    ldr s0, [sp, #8]
; NONEON-NOSVE-NEXT:    csetm w10, ne
; NONEON-NOSVE-NEXT:    fcmp s2, #0.0
; NONEON-NOSVE-NEXT:    csinv w10, w10, wzr, eq
; NONEON-NOSVE-NEXT:    fcmp s1, #0.0
; NONEON-NOSVE-NEXT:    csetm w11, ne
; NONEON-NOSVE-NEXT:    fcmp s0, #0.0
; NONEON-NOSVE-NEXT:    ldp s1, s0, [sp, #16]
; NONEON-NOSVE-NEXT:    csinv w11, w11, wzr, eq
; NONEON-NOSVE-NEXT:    fcmp s0, #0.0
; NONEON-NOSVE-NEXT:    ldp s2, s0, [sp]
; NONEON-NOSVE-NEXT:    orr w10, w11, w10
; NONEON-NOSVE-NEXT:    csetm w12, ne
; NONEON-NOSVE-NEXT:    fcmp s0, #0.0
; NONEON-NOSVE-NEXT:    csinv w12, w12, wzr, eq
; NONEON-NOSVE-NEXT:    fcmp s1, #0.0
; NONEON-NOSVE-NEXT:    ldp s0, s1, [sp, #104]
; NONEON-NOSVE-NEXT:    csetm w13, ne
; NONEON-NOSVE-NEXT:    fcmp s2, #0.0
; NONEON-NOSVE-NEXT:    csinv w14, w13, wzr, eq
; NONEON-NOSVE-NEXT:    fcmp s0, #0.0
; NONEON-NOSVE-NEXT:    ldp s0, s2, [sp, #56]
; NONEON-NOSVE-NEXT:    orr w12, w14, w12
; NONEON-NOSVE-NEXT:    orr w10, w12, w10
; NONEON-NOSVE-NEXT:    csetm w13, ne
; NONEON-NOSVE-NEXT:    orr w9, w10, w9
; NONEON-NOSVE-NEXT:    fcmp s0, #0.0
; NONEON-NOSVE-NEXT:    ldr q0, [x1, #32]
; NONEON-NOSVE-NEXT:    str q0, [sp, #112]
; NONEON-NOSVE-NEXT:    csinv w13, w13, wzr, eq
; NONEON-NOSVE-NEXT:    fcmp s1, #0.0
; NONEON-NOSVE-NEXT:    ldr s1, [sp, #64]
; NONEON-NOSVE-NEXT:    csetm w15, ne
; NONEON-NOSVE-NEXT:    fcmp s2, #0.0
; NONEON-NOSVE-NEXT:    ldp s0, s2, [sp, #112]
; NONEON-NOSVE-NEXT:    csinv w15, w15, wzr, eq
; NONEON-NOSVE-NEXT:    fcmp s0, #0.0
; NONEON-NOSVE-NEXT:    and w11, w15, #0xff
; NONEON-NOSVE-NEXT:    csetm w16, ne
; NONEON-NOSVE-NEXT:    fcmp s1, #0.0
; NONEON-NOSVE-NEXT:    ldp s0, s1, [sp, #68]
; NONEON-NOSVE-NEXT:    csinv w16, w16, wzr, eq
; NONEON-NOSVE-NEXT:    fcmp s2, #0.0
; NONEON-NOSVE-NEXT:    csetm w17, ne
; NONEON-NOSVE-NEXT:    fcmp s0, #0.0
; NONEON-NOSVE-NEXT:    ldp s0, s2, [sp, #120]
; NONEON-NOSVE-NEXT:    csinv w17, w17, wzr, eq
; NONEON-NOSVE-NEXT:    fcmp s0, #0.0
; NONEON-NOSVE-NEXT:    ldr s0, [sp, #76]
; NONEON-NOSVE-NEXT:    csetm w18, ne
; NONEON-NOSVE-NEXT:    fcmp s1, #0.0
; NONEON-NOSVE-NEXT:    ldr q1, [x1, #48]
; NONEON-NOSVE-NEXT:    str q1, [sp, #80]
; NONEON-NOSVE-NEXT:    csinv w18, w18, wzr, eq
; NONEON-NOSVE-NEXT:    fcmp s2, #0.0
; NONEON-NOSVE-NEXT:    ldr s2, [sp, #32]
; NONEON-NOSVE-NEXT:    csetm w0, ne
; NONEON-NOSVE-NEXT:    fcmp s0, #0.0
; NONEON-NOSVE-NEXT:    ldp s0, s1, [sp, #80]
; NONEON-NOSVE-NEXT:    csinv w0, w0, wzr, eq
; NONEON-NOSVE-NEXT:    fcmp s0, #0.0
; NONEON-NOSVE-NEXT:    csetm w1, ne
; NONEON-NOSVE-NEXT:    fcmp s2, #0.0
; NONEON-NOSVE-NEXT:    csinv w1, w1, wzr, eq
; NONEON-NOSVE-NEXT:    fcmp s1, #0.0
; NONEON-NOSVE-NEXT:    ldp s0, s1, [sp, #36]
; NONEON-NOSVE-NEXT:    csetm w2, ne
; NONEON-NOSVE-NEXT:    fcmp s0, #0.0
; NONEON-NOSVE-NEXT:    ldp s0, s2, [sp, #88]
; NONEON-NOSVE-NEXT:    csinv w2, w2, wzr, eq
; NONEON-NOSVE-NEXT:    fcmp s0, #0.0
; NONEON-NOSVE-NEXT:    ldr s0, [sp, #44]
; NONEON-NOSVE-NEXT:    csetm w3, ne
; NONEON-NOSVE-NEXT:    fcmp s1, #0.0
; NONEON-NOSVE-NEXT:    csinv w3, w3, wzr, eq
; NONEON-NOSVE-NEXT:    fcmp s2, #0.0
; NONEON-NOSVE-NEXT:    csetm w4, ne
; NONEON-NOSVE-NEXT:    fcmp s0, #0.0
; NONEON-NOSVE-NEXT:    csinv w10, w4, wzr, eq
; NONEON-NOSVE-NEXT:    cmp w9, w8
; NONEON-NOSVE-NEXT:    csel w8, w9, w8, hi
; NONEON-NOSVE-NEXT:    and w9, w13, #0xff
; NONEON-NOSVE-NEXT:    and w10, w10, #0xff
; NONEON-NOSVE-NEXT:    and w8, w8, #0xff
; NONEON-NOSVE-NEXT:    cmp w8, w9
; NONEON-NOSVE-NEXT:    csel w8, w8, w9, hi
; NONEON-NOSVE-NEXT:    and w9, w16, #0xff
; NONEON-NOSVE-NEXT:    cmp w8, w11
; NONEON-NOSVE-NEXT:    csel w8, w8, w11, hi
; NONEON-NOSVE-NEXT:    and w11, w17, #0xff
; NONEON-NOSVE-NEXT:    cmp w8, w9
; NONEON-NOSVE-NEXT:    csel w8, w8, w9, hi
; NONEON-NOSVE-NEXT:    and w9, w18, #0xff
; NONEON-NOSVE-NEXT:    cmp w8, w11
; NONEON-NOSVE-NEXT:    csel w8, w8, w11, hi
; NONEON-NOSVE-NEXT:    and w11, w0, #0xff
; NONEON-NOSVE-NEXT:    cmp w8, w9
; NONEON-NOSVE-NEXT:    csel w8, w8, w9, hi
; NONEON-NOSVE-NEXT:    and w9, w1, #0xff
; NONEON-NOSVE-NEXT:    cmp w8, w11
; NONEON-NOSVE-NEXT:    csel w8, w8, w11, hi
; NONEON-NOSVE-NEXT:    and w11, w2, #0xff
; NONEON-NOSVE-NEXT:    cmp w8, w9
; NONEON-NOSVE-NEXT:    csel w8, w8, w9, hi
; NONEON-NOSVE-NEXT:    and w9, w3, #0xff
; NONEON-NOSVE-NEXT:    cmp w8, w11
; NONEON-NOSVE-NEXT:    csel w8, w8, w11, hi
; NONEON-NOSVE-NEXT:    cmp w8, w9
; NONEON-NOSVE-NEXT:    csel w8, w8, w9, hi
; NONEON-NOSVE-NEXT:    cmp w8, w10
; NONEON-NOSVE-NEXT:    csel w8, w8, w10, hi
; NONEON-NOSVE-NEXT:    and w0, w8, #0x1
; NONEON-NOSVE-NEXT:    add sp, sp, #128
; NONEON-NOSVE-NEXT:    ret
  %v0 = bitcast ptr %a to ptr
  %v1 = load <16 x float>, ptr %v0, align 4
  %v2 = fcmp une <16 x float> %v1, zeroinitializer
  %v3 = bitcast ptr %b to ptr
  %v4 = load <16 x float>, ptr %v3, align 4
  %v5 = fcmp une <16 x float> %v4, zeroinitializer
  %v6 = or <16 x i1> %v2, %v5
  %v7 = call i1 @llvm.vector.reduce.or.i1.v16i1 (<16 x i1> %v6)
  ret i1 %v7
}

declare i1 @llvm.vector.reduce.or.i1.v16i1(<16 x i1>)

;
; AND reduction.
;

define i1 @ptest_and_v16i1(ptr %a, ptr %b) {
; CHECK-LABEL: ptest_and_v16i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0, #32]
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    ldp q2, q3, [x1, #32]
; CHECK-NEXT:    ldp q4, q5, [x0]
; CHECK-NEXT:    fcmne p1.s, p0/z, z1.s, #0.0
; CHECK-NEXT:    ldp q6, q1, [x1]
; CHECK-NEXT:    fcmne p3.s, p0/z, z3.s, #0.0
; CHECK-NEXT:    fcmne p2.s, p0/z, z0.s, #0.0
; CHECK-NEXT:    fcmne p5.s, p0/z, z2.s, #0.0
; CHECK-NEXT:    fcmne p4.s, p0/z, z5.s, #0.0
; CHECK-NEXT:    fcmne p7.s, p0/z, z4.s, #0.0
; CHECK-NEXT:    fcmne p6.s, p0/z, z1.s, #0.0
; CHECK-NEXT:    fcmne p0.s, p0/z, z6.s, #0.0
; CHECK-NEXT:    mov z0.s, p1/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    mov z2.s, p3/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    mov z1.s, p2/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    mov z4.s, p5/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    mov z3.s, p4/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    mov z6.s, p7/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    mov z5.s, p6/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    mov z7.s, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    uzp1 z17.h, z0.h, z0.h
; CHECK-NEXT:    uzp1 z19.h, z2.h, z2.h
; CHECK-NEXT:    uzp1 z16.h, z1.h, z1.h
; CHECK-NEXT:    ptrue p0.h, vl4
; CHECK-NEXT:    uzp1 z1.h, z3.h, z3.h
; CHECK-NEXT:    uzp1 z18.h, z4.h, z4.h
; CHECK-NEXT:    uzp1 z3.h, z5.h, z5.h
; CHECK-NEXT:    uzp1 z0.h, z6.h, z6.h
; CHECK-NEXT:    uzp1 z2.h, z7.h, z7.h
; CHECK-NEXT:    splice z4.h, p0, { z16.h, z17.h }
; CHECK-NEXT:    splice z5.h, p0, { z18.h, z19.h }
; CHECK-NEXT:    splice z0.h, p0, { z0.h, z1.h }
; CHECK-NEXT:    splice z1.h, p0, { z2.h, z3.h }
; CHECK-NEXT:    ptrue p0.b, vl8
; CHECK-NEXT:    uzp1 z3.b, z4.b, z4.b
; CHECK-NEXT:    uzp1 z5.b, z5.b, z5.b
; CHECK-NEXT:    uzp1 z2.b, z0.b, z0.b
; CHECK-NEXT:    uzp1 z4.b, z1.b, z1.b
; CHECK-NEXT:    splice z0.b, p0, { z2.b, z3.b }
; CHECK-NEXT:    splice z1.b, p0, { z4.b, z5.b }
; CHECK-NEXT:    ptrue p0.b, vl16
; CHECK-NEXT:    and z0.d, z0.d, z1.d
; CHECK-NEXT:    uminv b0, p0, z0.b
; CHECK-NEXT:    fmov w8, s0
; CHECK-NEXT:    and w0, w8, #0x1
; CHECK-NEXT:    ret
;
; NONEON-NOSVE-LABEL: ptest_and_v16i1:
; NONEON-NOSVE:       // %bb.0:
; NONEON-NOSVE-NEXT:    sub sp, sp, #128
; NONEON-NOSVE-NEXT:    .cfi_def_cfa_offset 128
; NONEON-NOSVE-NEXT:    ldp q1, q0, [x0]
; NONEON-NOSVE-NEXT:    ldp q3, q2, [x0, #32]
; NONEON-NOSVE-NEXT:    str q1, [sp]
; NONEON-NOSVE-NEXT:    stp q0, q3, [sp, #48]
; NONEON-NOSVE-NEXT:    str q2, [sp, #32]
; NONEON-NOSVE-NEXT:    ldr s1, [sp, #52]
; NONEON-NOSVE-NEXT:    ldr q0, [x1, #16]
; NONEON-NOSVE-NEXT:    str q0, [sp, #96]
; NONEON-NOSVE-NEXT:    ldp s2, s0, [sp, #96]
; NONEON-NOSVE-NEXT:    fcmp s0, #0.0
; NONEON-NOSVE-NEXT:    ldr s0, [sp, #48]
; NONEON-NOSVE-NEXT:    csetm w8, ne
; NONEON-NOSVE-NEXT:    fcmp s1, #0.0
; NONEON-NOSVE-NEXT:    ldr q1, [x1]
; NONEON-NOSVE-NEXT:    str q1, [sp, #16]
; NONEON-NOSVE-NEXT:    csel w8, w8, wzr, ne
; NONEON-NOSVE-NEXT:    fcmp s2, #0.0
; NONEON-NOSVE-NEXT:    ldr s2, [sp, #12]
; NONEON-NOSVE-NEXT:    csetm w9, ne
; NONEON-NOSVE-NEXT:    fcmp s0, #0.0
; NONEON-NOSVE-NEXT:    ldp s1, s0, [sp, #24]
; NONEON-NOSVE-NEXT:    csel w9, w9, wzr, ne
; NONEON-NOSVE-NEXT:    fcmp s0, #0.0
; NONEON-NOSVE-NEXT:    ldr s0, [sp, #8]
; NONEON-NOSVE-NEXT:    csetm w10, ne
; NONEON-NOSVE-NEXT:    fcmp s2, #0.0
; NONEON-NOSVE-NEXT:    csel w10, w10, wzr, ne
; NONEON-NOSVE-NEXT:    fcmp s1, #0.0
; NONEON-NOSVE-NEXT:    csetm w11, ne
; NONEON-NOSVE-NEXT:    fcmp s0, #0.0
; NONEON-NOSVE-NEXT:    ldp s1, s0, [sp, #16]
; NONEON-NOSVE-NEXT:    csel w11, w11, wzr, ne
; NONEON-NOSVE-NEXT:    fcmp s0, #0.0
; NONEON-NOSVE-NEXT:    ldp s2, s0, [sp]
; NONEON-NOSVE-NEXT:    and w10, w11, w10
; NONEON-NOSVE-NEXT:    csetm w12, ne
; NONEON-NOSVE-NEXT:    fcmp s0, #0.0
; NONEON-NOSVE-NEXT:    csel w12, w12, wzr, ne
; NONEON-NOSVE-NEXT:    fcmp s1, #0.0
; NONEON-NOSVE-NEXT:    ldp s0, s1, [sp, #104]
; NONEON-NOSVE-NEXT:    csetm w13, ne
; NONEON-NOSVE-NEXT:    fcmp s2, #0.0
; NONEON-NOSVE-NEXT:    csel w14, w13, wzr, ne
; NONEON-NOSVE-NEXT:    fcmp s0, #0.0
; NONEON-NOSVE-NEXT:    ldp s0, s2, [sp, #56]
; NONEON-NOSVE-NEXT:    and w12, w14, w12
; NONEON-NOSVE-NEXT:    and w10, w12, w10
; NONEON-NOSVE-NEXT:    csetm w13, ne
; NONEON-NOSVE-NEXT:    and w9, w10, w9
; NONEON-NOSVE-NEXT:    fcmp s0, #0.0
; NONEON-NOSVE-NEXT:    ldr q0, [x1, #32]
; NONEON-NOSVE-NEXT:    str q0, [sp, #112]
; NONEON-NOSVE-NEXT:    csel w13, w13, wzr, ne
; NONEON-NOSVE-NEXT:    fcmp s1, #0.0
; NONEON-NOSVE-NEXT:    ldr s1, [sp, #64]
; NONEON-NOSVE-NEXT:    csetm w15, ne
; NONEON-NOSVE-NEXT:    fcmp s2, #0.0
; NONEON-NOSVE-NEXT:    ldp s0, s2, [sp, #112]
; NONEON-NOSVE-NEXT:    csel w15, w15, wzr, ne
; NONEON-NOSVE-NEXT:    fcmp s0, #0.0
; NONEON-NOSVE-NEXT:    and w11, w15, #0xff
; NONEON-NOSVE-NEXT:    csetm w16, ne
; NONEON-NOSVE-NEXT:    fcmp s1, #0.0
; NONEON-NOSVE-NEXT:    ldp s0, s1, [sp, #68]
; NONEON-NOSVE-NEXT:    csel w16, w16, wzr, ne
; NONEON-NOSVE-NEXT:    fcmp s2, #0.0
; NONEON-NOSVE-NEXT:    csetm w17, ne
; NONEON-NOSVE-NEXT:    fcmp s0, #0.0
; NONEON-NOSVE-NEXT:    ldp s0, s2, [sp, #120]
; NONEON-NOSVE-NEXT:    csel w17, w17, wzr, ne
; NONEON-NOSVE-NEXT:    fcmp s0, #0.0
; NONEON-NOSVE-NEXT:    ldr s0, [sp, #76]
; NONEON-NOSVE-NEXT:    csetm w18, ne
; NONEON-NOSVE-NEXT:    fcmp s1, #0.0
; NONEON-NOSVE-NEXT:    ldr q1, [x1, #48]
; NONEON-NOSVE-NEXT:    str q1, [sp, #80]
; NONEON-NOSVE-NEXT:    csel w18, w18, wzr, ne
; NONEON-NOSVE-NEXT:    fcmp s2, #0.0
; NONEON-NOSVE-NEXT:    ldr s2, [sp, #32]
; NONEON-NOSVE-NEXT:    csetm w0, ne
; NONEON-NOSVE-NEXT:    fcmp s0, #0.0
; NONEON-NOSVE-NEXT:    ldp s0, s1, [sp, #80]
; NONEON-NOSVE-NEXT:    csel w0, w0, wzr, ne
; NONEON-NOSVE-NEXT:    fcmp s0, #0.0
; NONEON-NOSVE-NEXT:    csetm w1, ne
; NONEON-NOSVE-NEXT:    fcmp s2, #0.0
; NONEON-NOSVE-NEXT:    csel w1, w1, wzr, ne
; NONEON-NOSVE-NEXT:    fcmp s1, #0.0
; NONEON-NOSVE-NEXT:    ldp s0, s1, [sp, #36]
; NONEON-NOSVE-NEXT:    csetm w2, ne
; NONEON-NOSVE-NEXT:    fcmp s0, #0.0
; NONEON-NOSVE-NEXT:    ldp s0, s2, [sp, #88]
; NONEON-NOSVE-NEXT:    csel w2, w2, wzr, ne
; NONEON-NOSVE-NEXT:    fcmp s0, #0.0
; NONEON-NOSVE-NEXT:    ldr s0, [sp, #44]
; NONEON-NOSVE-NEXT:    csetm w3, ne
; NONEON-NOSVE-NEXT:    fcmp s1, #0.0
; NONEON-NOSVE-NEXT:    csel w3, w3, wzr, ne
; NONEON-NOSVE-NEXT:    fcmp s2, #0.0
; NONEON-NOSVE-NEXT:    csetm w4, ne
; NONEON-NOSVE-NEXT:    fcmp s0, #0.0
; NONEON-NOSVE-NEXT:    csel w10, w4, wzr, ne
; NONEON-NOSVE-NEXT:    cmp w9, w8
; NONEON-NOSVE-NEXT:    csel w8, w9, w8, lo
; NONEON-NOSVE-NEXT:    and w9, w13, #0xff
; NONEON-NOSVE-NEXT:    and w10, w10, #0xff
; NONEON-NOSVE-NEXT:    and w8, w8, #0xff
; NONEON-NOSVE-NEXT:    cmp w8, w9
; NONEON-NOSVE-NEXT:    csel w8, w8, w9, lo
; NONEON-NOSVE-NEXT:    and w9, w16, #0xff
; NONEON-NOSVE-NEXT:    cmp w8, w11
; NONEON-NOSVE-NEXT:    csel w8, w8, w11, lo
; NONEON-NOSVE-NEXT:    and w11, w17, #0xff
; NONEON-NOSVE-NEXT:    cmp w8, w9
; NONEON-NOSVE-NEXT:    csel w8, w8, w9, lo
; NONEON-NOSVE-NEXT:    and w9, w18, #0xff
; NONEON-NOSVE-NEXT:    cmp w8, w11
; NONEON-NOSVE-NEXT:    csel w8, w8, w11, lo
; NONEON-NOSVE-NEXT:    and w11, w0, #0xff
; NONEON-NOSVE-NEXT:    cmp w8, w9
; NONEON-NOSVE-NEXT:    csel w8, w8, w9, lo
; NONEON-NOSVE-NEXT:    and w9, w1, #0xff
; NONEON-NOSVE-NEXT:    cmp w8, w11
; NONEON-NOSVE-NEXT:    csel w8, w8, w11, lo
; NONEON-NOSVE-NEXT:    and w11, w2, #0xff
; NONEON-NOSVE-NEXT:    cmp w8, w9
; NONEON-NOSVE-NEXT:    csel w8, w8, w9, lo
; NONEON-NOSVE-NEXT:    and w9, w3, #0xff
; NONEON-NOSVE-NEXT:    cmp w8, w11
; NONEON-NOSVE-NEXT:    csel w8, w8, w11, lo
; NONEON-NOSVE-NEXT:    cmp w8, w9
; NONEON-NOSVE-NEXT:    csel w8, w8, w9, lo
; NONEON-NOSVE-NEXT:    cmp w8, w10
; NONEON-NOSVE-NEXT:    csel w8, w8, w10, lo
; NONEON-NOSVE-NEXT:    and w0, w8, #0x1
; NONEON-NOSVE-NEXT:    add sp, sp, #128
; NONEON-NOSVE-NEXT:    ret
  %v0 = bitcast ptr %a to ptr
  %v1 = load <16 x float>, ptr %v0, align 4
  %v2 = fcmp une <16 x float> %v1, zeroinitializer
  %v3 = bitcast ptr %b to ptr
  %v4 = load <16 x float>, ptr %v3, align 4
  %v5 = fcmp une <16 x float> %v4, zeroinitializer
  %v6 = and <16 x i1> %v2, %v5
  %v7 = call i1 @llvm.vector.reduce.and.i1.v16i1 (<16 x i1> %v6)
  ret i1 %v7
}

declare i1 @llvm.vector.reduce.and.i1.v16i1(<16 x i1>)
