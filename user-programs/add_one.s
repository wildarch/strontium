.section ".text"
.global _start

_start:
  add r1, #1
  cmp r1, #50
  it LT
  svc 0
  b _start
