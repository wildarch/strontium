/* Some symbols that are somehow in compiler-rt but not in libgcc */
__aeabi_memcpy = memcpy;
__aeabi_memmove = memmove;
__sync_val_compare_and_swap_4 = abort; /* FIXME This is probably bad.. */

relocate_addr = 0x2000000;

ENTRY(_start)
SECTIONS
{
  . = SEGMENT_START("text-segment", relocate_addr);
  kernel_start = .;
  text_start = .;
  .text    :
  {
    *(.text.startup)          /* init.s */

    vectors_start = .;
    KEEP(*(.text.vectors))
    vectors_end = .;

    *(.text .text.*)          /* everything else */
  }
  text_end = .;

  /* Unwinding symbols for gcc */
   PROVIDE_HIDDEN (__exidx_start = .);
  .ARM.exidx   : { *(.ARM.exidx* .gnu.linkonce.armexidx.*) }
   PROVIDE_HIDDEN (__exidx_end = .);
   kernel_end = .;

   the_end = .;
}
