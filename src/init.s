
//  Part of the Raspberry-Pi Bare Metal Tutorials
//  Copyright (c) 2013, Brian Sidebotham
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice,
//      this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice,
//      this list of conditions and the following disclaimer in the
//      documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//  POSSIBILITY OF SUCH DAMAGE.


.section ".text.startup"

.global _start
.global _get_stack_pointer
.global _exception_table
.global _enable_interrupts

// From the ARM ARM (Architecture Reference Manual). Make sure you get the
// ARMv5 documentation which includes the ARMv6 documentation which is the
// correct processor type for the Broadcom BCM2835. The ARMv6-M manuals
// available on the ARM website are for Cortex-M parts only and are very
// different.
//
// See ARM section A2.2 (Processor Modes)

.equ    CPSR_MODE_USER,         0x10
.equ    CPSR_MODE_FIQ,          0x11
.equ    CPSR_MODE_IRQ,          0x12
.equ    CPSR_MODE_SVR,          0x13
.equ    CPSR_MODE_ABORT,        0x17
.equ    CPSR_MODE_UNDEFINED,    0x1B
.equ    CPSR_MODE_SYSTEM,       0x1F

// See ARM section A2.5 (Program status registers)
.equ    CPSR_IRQ_INHIBIT,       0x80
.equ    CPSR_FIQ_INHIBIT,       0x40
.equ    CPSR_THUMB,             0x20

_start:
    ldr pc, _reset_h
    ldr pc, _undefined_instruction_vector_h
    ldr pc, _software_interrupt_vector_h
    ldr pc, _prefetch_abort_vector_h
    ldr pc, _data_abort_vector_h
    ldr pc, _unused_handler_h
    ldr pc, _interrupt_vector_h
    ldr pc, _fast_interrupt_vector_h

    _reset_h:                           .word   _reset_
    _undefined_instruction_vector_h:    .word   undefined_instruction_vector
    _software_interrupt_vector_h:       .word   software_interrupt_vector
    _prefetch_abort_vector_h:           .word   prefetch_abort_vector
    _data_abort_vector_h:               .word   data_abort_vector
    _unused_handler_h:                  .word   _reset_
    _interrupt_vector_h:                .word   interrupt_vector
    _fast_interrupt_vector_h:           .word   fast_interrupt_vector

_reset_:
    // We enter execution in supervisor mode. For more information on
    // processor modes see ARM Section A2.2 (Processor Modes)

    mov     r0, #0x8000
    mov     r1, #0x0000
    ldmia   r0!,{r2, r3, r4, r5, r6, r7, r8, r9}
    stmia   r1!,{r2, r3, r4, r5, r6, r7, r8, r9}
    ldmia   r0!,{r2, r3, r4, r5, r6, r7, r8, r9}
    stmia   r1!,{r2, r3, r4, r5, r6, r7, r8, r9}

    // We're going to use interrupt mode, so setup the interrupt mode
    // stack pointer which differs to the application stack pointer:
    mov r0, #(CPSR_MODE_IRQ | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r0
    mov sp, #(63 * 1024 * 1024)

    // Switch back to supervisor mode (our application mode) and
    // set the stack pointer towards the end of RAM. Remember that the
    // stack works its way down memory, our heap will work it's way
    // up memory toward the application stack.
    mov r0, #(CPSR_MODE_SVR | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT )
    msr cpsr_c, r0

    // Set the stack pointer at some point in RAM that won't harm us
    // It's different from the IRQ stack pointer above and no matter
    // what the GPU/CPU memory split, 64MB is available to the CPU
    // Keep it within the limits and also keep it aligned to a 32-bit
    // boundary!
    mov     sp, #(64 * 1024 * 1024)

    // The c-startup function which we never return from. This function will
    // initialise the ro data section (most things that have the const
    // declaration) and initialise the bss section variables to 0 (generally
    // known as automatics). It'll then call main, which should never return.
    bl      main

    // If main does return for some reason, just catch it and stay here.
_inf_loop:
    b       _inf_loop

interrupt_vector:
    /* Correct LR_irq; this is a quirk of how the ARM processor calls the
    * IRQ handler.  */
    sub lr, lr, #4

    /* [Store Return State Decrement Before] */
    /* Store the return state on the SYS mode stack.  This includes
    * SPSR_irq, which is the CPSR from SYS mode before we were interrupted,
    * and LR_irq, which is the address to which we must return to continue
    * execution of the interrupted thread.  */
    srsdb 0x1F!

    /* [Change Program State Interrupt Disable] */
    /* Change to SYS mode, with IRQs and FIQs still disabled.  */
    cpsid if, 0x1F

    /* Save on the SYS mode stack any registers that may be clobbered,
    * namely the SYS mode LR and all other caller-save general purpose
    * registers.  Also save r4 so we can use it to store the amount we
    * decremented the stack pointer by to align it to an 8-byte boundary
    * (see comment below).  */
    push {r0-r4, r12, lr}

    /* According to the document "Procedure Call Standard for the ARM
    * Architecture", the stack pointer is 4-byte aligned at all times, but
    * it must be 8-byte aligned when calling an externally visible
    * function.  This is important because this code is reached from an IRQ
    * and therefore the stack currently may only be 4-byte aligned.  If
    * this is the case, the stack must be padded to an 8-byte boundary
    * before calling dispatch().  */
    and r4, sp, #4
    sub sp, sp, r4

    /* Execute a data memory barrier, as per the BCM2835 documentation.  */
    bl dmb

    /* Call the Rust interrupt dispatching code. */
    bl interrupt_vector_handler

    /* Execute a data memory barrier, as per the BCM2835 documentation.  */
    bl dmb

    /* Restore the original stack alignment (see note about 8-byte alignment
    * above).  */
    add sp, sp, r4

    /* Restore the above-mentioned registers from the SYS mode stack. */
    pop {r0-r4, r12, lr}

    /* [Return From Exception Increment After] */
    /* Load the original SYS-mode CPSR and PC that were saved on the SYS
    * mode stack.  */
    rfeia sp!

dmb:
  	.func dmb
  	mov	r12, #0
  	mcr	p15, 0, r12, c7, c10, 5
  	mov 	pc, lr
  	.endfunc


_get_stack_pointer:
    // Return the stack pointer value
    str     sp, [sp]
    ldr     r0, [sp]

    // Return from the function
    mov     pc, lr


_enable_interrupts:
    mrs     r0, cpsr
    bic     r0, r0, #0x80
    msr     cpsr_c, r0

    mov     pc, lr
