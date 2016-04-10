/* Some symbols that are somehow in compiler-rt but not in libgcc */
__aeabi_memcpy = memcpy;
__aeabi_memmove = memmove;
__sync_val_compare_and_swap_4 = abort; /* FIXME This is probably bad.. */

ENTRY(_start)
SECTIONS
{
  . = SEGMENT_START("text-segment", 0x8000);
  kernel_start = .;
  text_start = .;
  .text    :
  {
    *(.text.startup)          /* init.s */
    *(.text .text.*)          /* everything else */
  }
  text_end = .;

  /* Unwinding symbols for gcc */
   PROVIDE_HIDDEN (__exidx_start = .);
  .ARM.exidx   : { *(.ARM.exidx* .gnu.linkonce.armexidx.*) }
   PROVIDE_HIDDEN (__exidx_end = .);
   kernel_end = .;
}
