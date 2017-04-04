.section ".text"
.global _start

_start:
  add r1, #1
  svc 1
  svc 0
  b _start
