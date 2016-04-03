
target/arm-none-eabi/release/kernel.o:     file format elf32-littlearm


Disassembly of section .text.main:

00000000 <main>:
   0:	e92d4070 	push	{r4, r5, r6, lr}
   4:	e59f4470 	ldr	r4, [pc, #1136]	; 47c <main+0x47c>
   8:	e3a05000 	mov	r5, #0
   c:	e5845000 	str	r5, [r4]
  10:	e59f0468 	ldr	r0, [pc, #1128]	; 480 <main+0x480>
  14:	e5805000 	str	r5, [r0]
  18:	ebfffffe 	bl	0 <main>
  1c:	e59f6460 	ldr	r6, [pc, #1120]	; 484 <main+0x484>
  20:	e3a00903 	mov	r0, #49152	; 0xc000
  24:	e5860000 	str	r0, [r6]
  28:	ebfffffe 	bl	0 <main>
  2c:	e5865000 	str	r5, [r6]
  30:	e3a010ff 	mov	r1, #255	; 0xff
  34:	e59f044c 	ldr	r0, [pc, #1100]	; 488 <main+0x488>
  38:	e3811c07 	orr	r1, r1, #1792	; 0x700
  3c:	e5801000 	str	r1, [r0]
  40:	e3a01001 	mov	r1, #1
  44:	e59f0440 	ldr	r0, [pc, #1088]	; 48c <main+0x48c>
  48:	e5801000 	str	r1, [r0]
  4c:	e3a01028 	mov	r1, #40	; 0x28
  50:	e59f0438 	ldr	r0, [pc, #1080]	; 490 <main+0x490>
  54:	e5801000 	str	r1, [r0]
  58:	e3a01070 	mov	r1, #112	; 0x70
  5c:	e59f0430 	ldr	r0, [pc, #1072]	; 494 <main+0x494>
  60:	e5801000 	str	r1, [r0]
  64:	e3a010f2 	mov	r1, #242	; 0xf2
  68:	e59f0428 	ldr	r0, [pc, #1064]	; 498 <main+0x498>
  6c:	e3811c07 	orr	r1, r1, #1792	; 0x700
  70:	e5801000 	str	r1, [r0]
  74:	e3a00001 	mov	r0, #1
  78:	e3800c03 	orr	r0, r0, #768	; 0x300
  7c:	e5840000 	str	r0, [r4]
  80:	e59f0414 	ldr	r0, [pc, #1044]	; 49c <main+0x49c>
  84:	e5900000 	ldr	r0, [r0]
  88:	e3100020 	tst	r0, #32
  8c:	1afffffb 	bne	80 <main+0x80>
  90:	e59f0408 	ldr	r0, [pc, #1032]	; 4a0 <main+0x4a0>
  94:	e3a0100a 	mov	r1, #10
  98:	e5801000 	str	r1, [r0]
  9c:	e59f03f8 	ldr	r0, [pc, #1016]	; 49c <main+0x49c>
  a0:	e5900000 	ldr	r0, [r0]
  a4:	e3100020 	tst	r0, #32
  a8:	1afffffb 	bne	9c <main+0x9c>
  ac:	e59f03ec 	ldr	r0, [pc, #1004]	; 4a0 <main+0x4a0>
  b0:	e3a0105b 	mov	r1, #91	; 0x5b
  b4:	e5801000 	str	r1, [r0]
  b8:	e59f03dc 	ldr	r0, [pc, #988]	; 49c <main+0x49c>
  bc:	e5900000 	ldr	r0, [r0]
  c0:	e3100020 	tst	r0, #32
  c4:	1afffffb 	bne	b8 <main+0xb8>
  c8:	e59f03d0 	ldr	r0, [pc, #976]	; 4a0 <main+0x4a0>
  cc:	e3a0104c 	mov	r1, #76	; 0x4c
  d0:	e5801000 	str	r1, [r0]
  d4:	e59f03c0 	ldr	r0, [pc, #960]	; 49c <main+0x49c>
  d8:	e5900000 	ldr	r0, [r0]
  dc:	e3100020 	tst	r0, #32
  e0:	1afffffb 	bne	d4 <main+0xd4>
  e4:	e59f03b4 	ldr	r0, [pc, #948]	; 4a0 <main+0x4a0>
  e8:	e3a0104f 	mov	r1, #79	; 0x4f
  ec:	e5801000 	str	r1, [r0]
  f0:	e59f03a4 	ldr	r0, [pc, #932]	; 49c <main+0x49c>
  f4:	e5900000 	ldr	r0, [r0]
  f8:	e3100020 	tst	r0, #32
  fc:	1afffffb 	bne	f0 <main+0xf0>
 100:	e59f0398 	ldr	r0, [pc, #920]	; 4a0 <main+0x4a0>
 104:	e3a01047 	mov	r1, #71	; 0x47
 108:	e5801000 	str	r1, [r0]
 10c:	e59f0388 	ldr	r0, [pc, #904]	; 49c <main+0x49c>
 110:	e5900000 	ldr	r0, [r0]
 114:	e3100020 	tst	r0, #32
 118:	1afffffb 	bne	10c <main+0x10c>
 11c:	e59f037c 	ldr	r0, [pc, #892]	; 4a0 <main+0x4a0>
 120:	e3a0105d 	mov	r1, #93	; 0x5d
 124:	e5801000 	str	r1, [r0]
 128:	e59f036c 	ldr	r0, [pc, #876]	; 49c <main+0x49c>
 12c:	e5900000 	ldr	r0, [r0]
 130:	e3100020 	tst	r0, #32
 134:	1afffffb 	bne	128 <main+0x128>
 138:	e59f0360 	ldr	r0, [pc, #864]	; 4a0 <main+0x4a0>
 13c:	e3a01020 	mov	r1, #32
 140:	e5801000 	str	r1, [r0]
 144:	e59f0358 	ldr	r0, [pc, #856]	; 4a4 <main+0x4a4>
 148:	e280101a 	add	r1, r0, #26
 14c:	e5d02000 	ldrb	r2, [r0]
 150:	e59f3344 	ldr	r3, [pc, #836]	; 49c <main+0x49c>
 154:	e5933000 	ldr	r3, [r3]
 158:	e3130020 	tst	r3, #32
 15c:	1afffffb 	bne	150 <main+0x150>
 160:	e59f3338 	ldr	r3, [pc, #824]	; 4a0 <main+0x4a0>
 164:	e2800001 	add	r0, r0, #1
 168:	e1500001 	cmp	r0, r1
 16c:	e5832000 	str	r2, [r3]
 170:	1afffff5 	bne	14c <main+0x14c>
 174:	e59f0320 	ldr	r0, [pc, #800]	; 49c <main+0x49c>
 178:	e5900000 	ldr	r0, [r0]
 17c:	e3100020 	tst	r0, #32
 180:	1afffffb 	bne	174 <main+0x174>
 184:	e59f0314 	ldr	r0, [pc, #788]	; 4a0 <main+0x4a0>
 188:	e3a0100a 	mov	r1, #10
 18c:	e5801000 	str	r1, [r0]
 190:	e3a01001 	mov	r1, #1
 194:	e59f030c 	ldr	r0, [pc, #780]	; 4a8 <main+0x4a8>
 198:	e5801000 	str	r1, [r0]
 19c:	e3a00b2d 	mov	r0, #46080	; 0xb400
 1a0:	e3a01801 	mov	r1, #65536	; 0x10000
 1a4:	e3800202 	orr	r0, r0, #536870912	; 0x20000000
 1a8:	e5801000 	str	r1, [r0]
 1ac:	e3a010a6 	mov	r1, #166	; 0xa6
 1b0:	e59f02f4 	ldr	r0, [pc, #756]	; 4ac <main+0x4ac>
 1b4:	e5801000 	str	r1, [r0]
 1b8:	ebfffffe 	bl	0 <_enable_interrupts>
 1bc:	e59f02d8 	ldr	r0, [pc, #728]	; 49c <main+0x49c>
 1c0:	e5900000 	ldr	r0, [r0]
 1c4:	e3100020 	tst	r0, #32
 1c8:	1afffffb 	bne	1bc <main+0x1bc>
 1cc:	e59f02cc 	ldr	r0, [pc, #716]	; 4a0 <main+0x4a0>
 1d0:	e3a0105b 	mov	r1, #91	; 0x5b
 1d4:	e5801000 	str	r1, [r0]
 1d8:	e59f02bc 	ldr	r0, [pc, #700]	; 49c <main+0x49c>
 1dc:	e5900000 	ldr	r0, [r0]
 1e0:	e3100020 	tst	r0, #32
 1e4:	1afffffb 	bne	1d8 <main+0x1d8>
 1e8:	e59f02b0 	ldr	r0, [pc, #688]	; 4a0 <main+0x4a0>
 1ec:	e3a0104c 	mov	r1, #76	; 0x4c
 1f0:	e5801000 	str	r1, [r0]
 1f4:	e59f02a0 	ldr	r0, [pc, #672]	; 49c <main+0x49c>
 1f8:	e5900000 	ldr	r0, [r0]
 1fc:	e3100020 	tst	r0, #32
 200:	1afffffb 	bne	1f4 <main+0x1f4>
 204:	e59f0294 	ldr	r0, [pc, #660]	; 4a0 <main+0x4a0>
 208:	e3a0104f 	mov	r1, #79	; 0x4f
 20c:	e5801000 	str	r1, [r0]
 210:	e59f0284 	ldr	r0, [pc, #644]	; 49c <main+0x49c>
 214:	e5900000 	ldr	r0, [r0]
 218:	e3100020 	tst	r0, #32
 21c:	1afffffb 	bne	210 <main+0x210>
 220:	e59f0278 	ldr	r0, [pc, #632]	; 4a0 <main+0x4a0>
 224:	e3a01047 	mov	r1, #71	; 0x47
 228:	e5801000 	str	r1, [r0]
 22c:	e59f0268 	ldr	r0, [pc, #616]	; 49c <main+0x49c>
 230:	e5900000 	ldr	r0, [r0]
 234:	e3100020 	tst	r0, #32
 238:	1afffffb 	bne	22c <main+0x22c>
 23c:	e59f025c 	ldr	r0, [pc, #604]	; 4a0 <main+0x4a0>
 240:	e3a0105d 	mov	r1, #93	; 0x5d
 244:	e5801000 	str	r1, [r0]
 248:	e59f024c 	ldr	r0, [pc, #588]	; 49c <main+0x49c>
 24c:	e5900000 	ldr	r0, [r0]
 250:	e3100020 	tst	r0, #32
 254:	1afffffb 	bne	248 <main+0x248>
 258:	e59f0240 	ldr	r0, [pc, #576]	; 4a0 <main+0x4a0>
 25c:	e3a01020 	mov	r1, #32
 260:	e5801000 	str	r1, [r0]
 264:	e59f0230 	ldr	r0, [pc, #560]	; 49c <main+0x49c>
 268:	e5900000 	ldr	r0, [r0]
 26c:	e3100020 	tst	r0, #32
 270:	1afffffb 	bne	264 <main+0x264>
 274:	e59f0224 	ldr	r0, [pc, #548]	; 4a0 <main+0x4a0>
 278:	e3a01049 	mov	r1, #73	; 0x49
 27c:	e5801000 	str	r1, [r0]
 280:	e59f0214 	ldr	r0, [pc, #532]	; 49c <main+0x49c>
 284:	e5900000 	ldr	r0, [r0]
 288:	e3100020 	tst	r0, #32
 28c:	1afffffb 	bne	280 <main+0x280>
 290:	e59f0208 	ldr	r0, [pc, #520]	; 4a0 <main+0x4a0>
 294:	e3a0106e 	mov	r1, #110	; 0x6e
 298:	e5801000 	str	r1, [r0]
 29c:	e59f01f8 	ldr	r0, [pc, #504]	; 49c <main+0x49c>
 2a0:	e5900000 	ldr	r0, [r0]
 2a4:	e3100020 	tst	r0, #32
 2a8:	1afffffb 	bne	29c <main+0x29c>
 2ac:	e59f01ec 	ldr	r0, [pc, #492]	; 4a0 <main+0x4a0>
 2b0:	e3a01074 	mov	r1, #116	; 0x74
 2b4:	e5801000 	str	r1, [r0]
 2b8:	e59f01dc 	ldr	r0, [pc, #476]	; 49c <main+0x49c>
 2bc:	e5900000 	ldr	r0, [r0]
 2c0:	e3100020 	tst	r0, #32
 2c4:	1afffffb 	bne	2b8 <main+0x2b8>
 2c8:	e59f01d0 	ldr	r0, [pc, #464]	; 4a0 <main+0x4a0>
 2cc:	e3a01065 	mov	r1, #101	; 0x65
 2d0:	e5801000 	str	r1, [r0]
 2d4:	e59f01c0 	ldr	r0, [pc, #448]	; 49c <main+0x49c>
 2d8:	e5900000 	ldr	r0, [r0]
 2dc:	e3100020 	tst	r0, #32
 2e0:	1afffffb 	bne	2d4 <main+0x2d4>
 2e4:	e59f01b4 	ldr	r0, [pc, #436]	; 4a0 <main+0x4a0>
 2e8:	e3a01072 	mov	r1, #114	; 0x72
 2ec:	e5801000 	str	r1, [r0]
 2f0:	e59f01a4 	ldr	r0, [pc, #420]	; 49c <main+0x49c>
 2f4:	e5900000 	ldr	r0, [r0]
 2f8:	e3100020 	tst	r0, #32
 2fc:	1afffffb 	bne	2f0 <main+0x2f0>
 300:	e59f0198 	ldr	r0, [pc, #408]	; 4a0 <main+0x4a0>
 304:	e3a01072 	mov	r1, #114	; 0x72
 308:	e5801000 	str	r1, [r0]
 30c:	e59f0188 	ldr	r0, [pc, #392]	; 49c <main+0x49c>
 310:	e5900000 	ldr	r0, [r0]
 314:	e3100020 	tst	r0, #32
 318:	1afffffb 	bne	30c <main+0x30c>
 31c:	e59f017c 	ldr	r0, [pc, #380]	; 4a0 <main+0x4a0>
 320:	e3a01075 	mov	r1, #117	; 0x75
 324:	e5801000 	str	r1, [r0]
 328:	e59f016c 	ldr	r0, [pc, #364]	; 49c <main+0x49c>
 32c:	e5900000 	ldr	r0, [r0]
 330:	e3100020 	tst	r0, #32
 334:	1afffffb 	bne	328 <main+0x328>
 338:	e59f0160 	ldr	r0, [pc, #352]	; 4a0 <main+0x4a0>
 33c:	e3a01070 	mov	r1, #112	; 0x70
 340:	e5801000 	str	r1, [r0]
 344:	e59f0150 	ldr	r0, [pc, #336]	; 49c <main+0x49c>
 348:	e5900000 	ldr	r0, [r0]
 34c:	e3100020 	tst	r0, #32
 350:	1afffffb 	bne	344 <main+0x344>
 354:	e59f0144 	ldr	r0, [pc, #324]	; 4a0 <main+0x4a0>
 358:	e3a01074 	mov	r1, #116	; 0x74
 35c:	e5801000 	str	r1, [r0]
 360:	e59f0134 	ldr	r0, [pc, #308]	; 49c <main+0x49c>
 364:	e5900000 	ldr	r0, [r0]
 368:	e3100020 	tst	r0, #32
 36c:	1afffffb 	bne	360 <main+0x360>
 370:	e59f0128 	ldr	r0, [pc, #296]	; 4a0 <main+0x4a0>
 374:	e3a01073 	mov	r1, #115	; 0x73
 378:	e5801000 	str	r1, [r0]
 37c:	e59f0118 	ldr	r0, [pc, #280]	; 49c <main+0x49c>
 380:	e5900000 	ldr	r0, [r0]
 384:	e3100020 	tst	r0, #32
 388:	1afffffb 	bne	37c <main+0x37c>
 38c:	e59f010c 	ldr	r0, [pc, #268]	; 4a0 <main+0x4a0>
 390:	e3a01020 	mov	r1, #32
 394:	e5801000 	str	r1, [r0]
 398:	e59f00fc 	ldr	r0, [pc, #252]	; 49c <main+0x49c>
 39c:	e5900000 	ldr	r0, [r0]
 3a0:	e3100020 	tst	r0, #32
 3a4:	1afffffb 	bne	398 <main+0x398>
 3a8:	e59f00f0 	ldr	r0, [pc, #240]	; 4a0 <main+0x4a0>
 3ac:	e3a01065 	mov	r1, #101	; 0x65
 3b0:	e5801000 	str	r1, [r0]
 3b4:	e59f00e0 	ldr	r0, [pc, #224]	; 49c <main+0x49c>
 3b8:	e5900000 	ldr	r0, [r0]
 3bc:	e3100020 	tst	r0, #32
 3c0:	1afffffb 	bne	3b4 <main+0x3b4>
 3c4:	e59f00d4 	ldr	r0, [pc, #212]	; 4a0 <main+0x4a0>
 3c8:	e3a0106e 	mov	r1, #110	; 0x6e
 3cc:	e5801000 	str	r1, [r0]
 3d0:	e59f00c4 	ldr	r0, [pc, #196]	; 49c <main+0x49c>
 3d4:	e5900000 	ldr	r0, [r0]
 3d8:	e3100020 	tst	r0, #32
 3dc:	1afffffb 	bne	3d0 <main+0x3d0>
 3e0:	e59f00b8 	ldr	r0, [pc, #184]	; 4a0 <main+0x4a0>
 3e4:	e3a01061 	mov	r1, #97	; 0x61
 3e8:	e5801000 	str	r1, [r0]
 3ec:	e59f00a8 	ldr	r0, [pc, #168]	; 49c <main+0x49c>
 3f0:	e5900000 	ldr	r0, [r0]
 3f4:	e3100020 	tst	r0, #32
 3f8:	1afffffb 	bne	3ec <main+0x3ec>
 3fc:	e59f009c 	ldr	r0, [pc, #156]	; 4a0 <main+0x4a0>
 400:	e3a01062 	mov	r1, #98	; 0x62
 404:	e5801000 	str	r1, [r0]
 408:	e59f008c 	ldr	r0, [pc, #140]	; 49c <main+0x49c>
 40c:	e5900000 	ldr	r0, [r0]
 410:	e3100020 	tst	r0, #32
 414:	1afffffb 	bne	408 <main+0x408>
 418:	e59f0080 	ldr	r0, [pc, #128]	; 4a0 <main+0x4a0>
 41c:	e3a0106c 	mov	r1, #108	; 0x6c
 420:	e5801000 	str	r1, [r0]
 424:	e59f0070 	ldr	r0, [pc, #112]	; 49c <main+0x49c>
 428:	e5900000 	ldr	r0, [r0]
 42c:	e3100020 	tst	r0, #32
 430:	1afffffb 	bne	424 <main+0x424>
 434:	e59f0064 	ldr	r0, [pc, #100]	; 4a0 <main+0x4a0>
 438:	e3a01065 	mov	r1, #101	; 0x65
 43c:	e5801000 	str	r1, [r0]
 440:	e59f0054 	ldr	r0, [pc, #84]	; 49c <main+0x49c>
 444:	e5900000 	ldr	r0, [r0]
 448:	e3100020 	tst	r0, #32
 44c:	1afffffb 	bne	440 <main+0x440>
 450:	e59f0048 	ldr	r0, [pc, #72]	; 4a0 <main+0x4a0>
 454:	e3a01064 	mov	r1, #100	; 0x64
 458:	e5801000 	str	r1, [r0]
 45c:	e59f0038 	ldr	r0, [pc, #56]	; 49c <main+0x49c>
 460:	e5900000 	ldr	r0, [r0]
 464:	e3100020 	tst	r0, #32
 468:	1afffffb 	bne	45c <main+0x45c>
 46c:	e59f002c 	ldr	r0, [pc, #44]	; 4a0 <main+0x4a0>
 470:	e3a0100a 	mov	r1, #10
 474:	e5801000 	str	r1, [r0]
 478:	eafffffe 	b	478 <main+0x478>
 47c:	20201030 	.word	0x20201030
 480:	20200094 	.word	0x20200094
 484:	20200098 	.word	0x20200098
 488:	20201044 	.word	0x20201044
 48c:	20201024 	.word	0x20201024
 490:	20201028 	.word	0x20201028
 494:	2020102c 	.word	0x2020102c
 498:	20201038 	.word	0x20201038
 49c:	20201018 	.word	0x20201018
 4a0:	20201000 	.word	0x20201000
 4a4:	00000000 	.word	0x00000000
 4a8:	2000b218 	.word	0x2000b218
 4ac:	2000b408 	.word	0x2000b408

Disassembly of section .text._ZN10interrupts13IrqController12enable_timer20he001fb963e6741feVjaE:

00000000 <_ZN10interrupts13IrqController12enable_timer20he001fb963e6741feVjaE>:
   0:	e3a01001 	mov	r1, #1
   4:	e5801018 	str	r1, [r0, #24]
   8:	e1a0f00e 	mov	pc, lr

Disassembly of section .text._ZN10interrupts13IrqController3get20heccc742d8dd3cdc3HjaE:

00000000 <_ZN10interrupts13IrqController3get20heccc742d8dd3cdc3HjaE>:
   0:	e3a00cb2 	mov	r0, #45568	; 0xb200
   4:	e3800202 	orr	r0, r0, #536870912	; 0x20000000
   8:	e1a0f00e 	mov	pc, lr

Disassembly of section .text._ZN4uart4wait20h48001a8f6aeb974a4haE:

00000000 <_ZN4uart4wait20h48001a8f6aeb974a4haE>:
   0:	e3a00096 	mov	r0, #150	; 0x96
   4:	e2500001 	subs	r0, r0, #1
   8:	1afffffd 	bne	4 <_ZN4uart4wait20h48001a8f6aeb974a4haE+0x4>
   c:	e1a0f00e 	mov	pc, lr

Disassembly of section .text.reset_vector:

00000000 <reset_vector>:
   0:	e1a0f00e 	mov	pc, lr

Disassembly of section .text.fast_interrupt_vector:

00000000 <fast_interrupt_vector>:
   0:	e1a0f00e 	mov	pc, lr

Disassembly of section .text.undefined_instruction_vector:

00000000 <undefined_instruction_vector>:
   0:	eafffffe 	b	0 <undefined_instruction_vector>

Disassembly of section .text.software_interrupt_vector:

00000000 <software_interrupt_vector>:
   0:	e1a0f00e 	mov	pc, lr

Disassembly of section .text.prefetch_abort_vector:

00000000 <prefetch_abort_vector>:
   0:	e1a0f00e 	mov	pc, lr

Disassembly of section .text.data_abort_vector:

00000000 <data_abort_vector>:
   0:	e1a0f00e 	mov	pc, lr

Disassembly of section .text.interrupt_vector_handler:

00000000 <interrupt_vector_handler>:
   0:	e59f00c4 	ldr	r0, [pc, #196]	; cc <interrupt_vector_handler+0xcc>
   4:	e3a01001 	mov	r1, #1
   8:	e5801000 	str	r1, [r0]
   c:	e59f00bc 	ldr	r0, [pc, #188]	; d0 <interrupt_vector_handler+0xd0>
  10:	e5900000 	ldr	r0, [r0]
  14:	e3100020 	tst	r0, #32
  18:	1afffffb 	bne	c <interrupt_vector_handler+0xc>
  1c:	e59f00b0 	ldr	r0, [pc, #176]	; d4 <interrupt_vector_handler+0xd4>
  20:	e3a01049 	mov	r1, #73	; 0x49
  24:	e5801000 	str	r1, [r0]
  28:	e59f00a0 	ldr	r0, [pc, #160]	; d0 <interrupt_vector_handler+0xd0>
  2c:	e5900000 	ldr	r0, [r0]
  30:	e3100020 	tst	r0, #32
  34:	1afffffb 	bne	28 <interrupt_vector_handler+0x28>
  38:	e59f0094 	ldr	r0, [pc, #148]	; d4 <interrupt_vector_handler+0xd4>
  3c:	e3a01052 	mov	r1, #82	; 0x52
  40:	e5801000 	str	r1, [r0]
  44:	e59f0084 	ldr	r0, [pc, #132]	; d0 <interrupt_vector_handler+0xd0>
  48:	e5900000 	ldr	r0, [r0]
  4c:	e3100020 	tst	r0, #32
  50:	1afffffb 	bne	44 <interrupt_vector_handler+0x44>
  54:	e59f0078 	ldr	r0, [pc, #120]	; d4 <interrupt_vector_handler+0xd4>
  58:	e3a01051 	mov	r1, #81	; 0x51
  5c:	e5801000 	str	r1, [r0]
  60:	e59f0068 	ldr	r0, [pc, #104]	; d0 <interrupt_vector_handler+0xd0>
  64:	e5900000 	ldr	r0, [r0]
  68:	e3100020 	tst	r0, #32
  6c:	1afffffb 	bne	60 <interrupt_vector_handler+0x60>
  70:	e59f005c 	ldr	r0, [pc, #92]	; d4 <interrupt_vector_handler+0xd4>
  74:	e3a0103b 	mov	r1, #59	; 0x3b
  78:	e5801000 	str	r1, [r0]
  7c:	e59f0054 	ldr	r0, [pc, #84]	; d8 <interrupt_vector_handler+0xd8>
  80:	e5d01000 	ldrb	r1, [r0]
  84:	e59f2050 	ldr	r2, [pc, #80]	; dc <interrupt_vector_handler+0xdc>
  88:	e5923000 	ldr	r3, [r2]
  8c:	e3510000 	cmp	r1, #0
  90:	e3833701 	orr	r3, r3, #262144	; 0x40000
  94:	e5823000 	str	r3, [r2]
  98:	0a000005 	beq	b4 <interrupt_vector_handler+0xb4>
  9c:	e59f1040 	ldr	r1, [pc, #64]	; e4 <interrupt_vector_handler+0xe4>
  a0:	e3a02801 	mov	r2, #65536	; 0x10000
  a4:	e5812000 	str	r2, [r1]
  a8:	e3a01000 	mov	r1, #0
  ac:	e5c01000 	strb	r1, [r0]
  b0:	e1a0f00e 	mov	pc, lr
  b4:	e59f1024 	ldr	r1, [pc, #36]	; e0 <interrupt_vector_handler+0xe0>
  b8:	e3a02801 	mov	r2, #65536	; 0x10000
  bc:	e5812000 	str	r2, [r1]
  c0:	e3a01001 	mov	r1, #1
  c4:	e5c01000 	strb	r1, [r0]
  c8:	e1a0f00e 	mov	pc, lr
  cc:	2000b40c 	.word	0x2000b40c
  d0:	20201018 	.word	0x20201018
  d4:	20201000 	.word	0x20201000
  d8:	00000000 	.word	0x00000000
  dc:	20200004 	.word	0x20200004
  e0:	20200028 	.word	0x20200028
  e4:	2020001c 	.word	0x2020001c

Disassembly of section .text.rust_begin_unwind:

00000000 <rust_begin_unwind>:
   0:	e59d100c 	ldr	r1, [sp, #12]
   4:	e59d0008 	ldr	r0, [sp, #8]
   8:	e59f2110 	ldr	r2, [pc, #272]	; 120 <rust_begin_unwind+0x120>
   c:	e5922000 	ldr	r2, [r2]
  10:	e3120020 	tst	r2, #32
  14:	1afffffb 	bne	8 <rust_begin_unwind+0x8>
  18:	e59f2104 	ldr	r2, [pc, #260]	; 124 <rust_begin_unwind+0x124>
  1c:	e3a03050 	mov	r3, #80	; 0x50
  20:	e5823000 	str	r3, [r2]
  24:	e59f20f4 	ldr	r2, [pc, #244]	; 120 <rust_begin_unwind+0x120>
  28:	e5922000 	ldr	r2, [r2]
  2c:	e3120020 	tst	r2, #32
  30:	1afffffb 	bne	24 <rust_begin_unwind+0x24>
  34:	e59f20e8 	ldr	r2, [pc, #232]	; 124 <rust_begin_unwind+0x124>
  38:	e3a03041 	mov	r3, #65	; 0x41
  3c:	e5823000 	str	r3, [r2]
  40:	e59f20d8 	ldr	r2, [pc, #216]	; 120 <rust_begin_unwind+0x120>
  44:	e5922000 	ldr	r2, [r2]
  48:	e3120020 	tst	r2, #32
  4c:	1afffffb 	bne	40 <rust_begin_unwind+0x40>
  50:	e59f20cc 	ldr	r2, [pc, #204]	; 124 <rust_begin_unwind+0x124>
  54:	e3a0304e 	mov	r3, #78	; 0x4e
  58:	e5823000 	str	r3, [r2]
  5c:	e59f20bc 	ldr	r2, [pc, #188]	; 120 <rust_begin_unwind+0x120>
  60:	e5922000 	ldr	r2, [r2]
  64:	e3120020 	tst	r2, #32
  68:	1afffffb 	bne	5c <rust_begin_unwind+0x5c>
  6c:	e59f20b0 	ldr	r2, [pc, #176]	; 124 <rust_begin_unwind+0x124>
  70:	e3a03049 	mov	r3, #73	; 0x49
  74:	e5823000 	str	r3, [r2]
  78:	e59f20a0 	ldr	r2, [pc, #160]	; 120 <rust_begin_unwind+0x120>
  7c:	e5922000 	ldr	r2, [r2]
  80:	e3120020 	tst	r2, #32
  84:	1afffffb 	bne	78 <rust_begin_unwind+0x78>
  88:	e59f2094 	ldr	r2, [pc, #148]	; 124 <rust_begin_unwind+0x124>
  8c:	e3a03043 	mov	r3, #67	; 0x43
  90:	e5823000 	str	r3, [r2]
  94:	e59f2084 	ldr	r2, [pc, #132]	; 120 <rust_begin_unwind+0x120>
  98:	e5922000 	ldr	r2, [r2]
  9c:	e3120020 	tst	r2, #32
  a0:	1afffffb 	bne	94 <rust_begin_unwind+0x94>
  a4:	e59f2078 	ldr	r2, [pc, #120]	; 124 <rust_begin_unwind+0x124>
  a8:	e3a03021 	mov	r3, #33	; 0x21
  ac:	e5823000 	str	r3, [r2]
  b0:	e59f2068 	ldr	r2, [pc, #104]	; 120 <rust_begin_unwind+0x120>
  b4:	e5922000 	ldr	r2, [r2]
  b8:	e3120020 	tst	r2, #32
  bc:	1afffffb 	bne	b0 <rust_begin_unwind+0xb0>
  c0:	e59f205c 	ldr	r2, [pc, #92]	; 124 <rust_begin_unwind+0x124>
  c4:	e3a03021 	mov	r3, #33	; 0x21
  c8:	e5823000 	str	r3, [r2]
  cc:	e59f204c 	ldr	r2, [pc, #76]	; 120 <rust_begin_unwind+0x120>
  d0:	e5922000 	ldr	r2, [r2]
  d4:	e3120020 	tst	r2, #32
  d8:	1afffffb 	bne	cc <rust_begin_unwind+0xcc>
  dc:	e59f2040 	ldr	r2, [pc, #64]	; 124 <rust_begin_unwind+0x124>
  e0:	e3a03021 	mov	r3, #33	; 0x21
  e4:	e3510000 	cmp	r1, #0
  e8:	e5823000 	str	r3, [r2]
  ec:	0a00000a 	beq	11c <rust_begin_unwind+0x11c>
  f0:	e0801001 	add	r1, r0, r1
  f4:	e5d02000 	ldrb	r2, [r0]
  f8:	e59f3020 	ldr	r3, [pc, #32]	; 120 <rust_begin_unwind+0x120>
  fc:	e5933000 	ldr	r3, [r3]
 100:	e3130020 	tst	r3, #32
 104:	1afffffb 	bne	f8 <rust_begin_unwind+0xf8>
 108:	e59f3014 	ldr	r3, [pc, #20]	; 124 <rust_begin_unwind+0x124>
 10c:	e2800001 	add	r0, r0, #1
 110:	e1500001 	cmp	r0, r1
 114:	e5832000 	str	r2, [r3]
 118:	1afffff5 	bne	f4 <rust_begin_unwind+0xf4>
 11c:	eafffffe 	b	11c <rust_begin_unwind+0x11c>
 120:	20201018 	.word	0x20201018
 124:	20201000 	.word	0x20201000

Disassembly of section .text.rust_eh_personality:

00000000 <rust_eh_personality>:
   0:	e1a0f00e 	mov	pc, lr

Disassembly of section .text.abort:

00000000 <abort>:
   0:	eafffffe 	b	0 <abort>

Disassembly of section .text.memcpy:

00000000 <memcpy>:
   0:	e3520000 	cmp	r2, #0
   4:	01a0f00e 	moveq	pc, lr
   8:	e1a0c000 	mov	ip, r0
   c:	e4d13001 	ldrb	r3, [r1], #1
  10:	e2522001 	subs	r2, r2, #1
  14:	e4cc3001 	strb	r3, [ip], #1
  18:	1afffffb 	bne	c <memcpy+0xc>
  1c:	e1a0f00e 	mov	pc, lr
