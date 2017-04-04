.section ".text.startup"

.global _start
.global enable_interrupts
.global disable_interrupts
.global dmb
.global shutdown

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
.equ    CPSR_MODE_SVCTEM,       0x1F

// See ARM section A2.5 (Program status registers)
.equ    CPSR_IRQ_INHIBIT,       0x80
.equ    CPSR_FIQ_INHIBIT,       0x40
.equ    CPSR_THUMB,             0x20

.equ    LOAD_ADDR,              0x8000

// EXECUTION START
_start:
    b _reset_

_reset_:
    //We are now in Supervisor mode

    // Setup the stack.
  	mov	sp, #0x8000

  	// we're loaded at 0x8000, relocate to _start.
  .relocate:
  	// copy from r3 to r4.
  	mov	r3, #LOAD_ADDR
  	ldr	r4, =kernel_start
  	ldr	r9, =kernel_end
  1:
  	// Load multiple from r3, and store at r4.
  	ldmia	r3!, {r5-r8}
  	stmia	r4!, {r5-r8}

  	// If we're still below file_end, loop.
  	cmp	r4, r9
  	blo	1b

  	// Call kernel_main
  	ldr	r3, =main
  	blx	r3

    // If main does return, shut down
shutdown:
    wfe
    b       shutdown

interrupt_vector:
    /* Correct LR_irq; this is a quirk of how the ARM processor calls the
    * IRQ handler.  */
    sub lr, lr, #4

    /* [Store Return State Decrement Before] */
    /* Store the return state on the SVC mode stack.  This includes
    * SPSR_irq, which is the CPSR from SVC mode before we were interrupted,
    * and LR_irq, which is the address to which we must return to continue
    * execution of the interrupted thread.  */
    srsdb CPSR_MODE_SVR!

    /* [Change Program State Interrupt Disable] */
    /* Change to SVC mode, with IRQs and FIQs still disabled.  */
    cpsid if, CPSR_MODE_SVR

    /* Save on the SVC mode stack any registers that may be clobbered,
    * namely the SVC mode LR and all other caller-save general purpose
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

    /* Restore the above-mentioned registers from the SVC mode stack. */
    pop {r0-r4, r12, lr}

    /* [Return From Exception Increment After] */
    /* Load the original SVC-mode CPSR and PC that were saved on the SVC
    * mode stack.  */
    rfeia sp!

software_interrupt_vector:
    srsdb CPSR_MODE_SVR!
    cpsid if, CPSR_MODE_SVR
    push {r0-r4, r12, lr}
    ldr r0, [lr,#-4]
    and r4, sp, #4
    sub sp, sp, r4
    bl dmb
    bl software_interrupt_vector_handler
    bl dmb
    add sp, sp, r4
    pop {r0-r4, r12, lr}
    rfeia sp!

undefined_instruction_vector:
    srsdb CPSR_MODE_SVR!
    cpsid if, CPSR_MODE_SVR
    push {r0-r4, r12, lr}
    ldr r0, [lr,#-4]
    and r4, sp, #4
    sub sp, sp, r4
    bl dmb
    bl undefined_instruction_vector_handler
    bl dmb
    add sp, sp, r4
    pop {r0-r4, r12, lr}
    rfeia sp!

/*
  Triggers a data memory barrier, all code that comes before this
  is guaranteed to be finished once we return from this function
*/
dmb:
  	.func dmb
  	mov	r12, #0
  	mcr	p15, 0, r12, c7, c10, 5
  	mov 	pc, lr
  	.endfunc

enable_interrupts:
    cpsie   I
    mov     pc, lr

disable_interrupts:
    cpsid   I
    mov     pc, lr


.section ".text.vectors"
.global __vectors__
__vectors__:
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
