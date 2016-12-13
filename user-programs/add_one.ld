relocate_addr = 0x2500000;

ENTRY(_start)
SECTIONS
{
  . = SEGMENT_START("text-segment", relocate_addr);
  .text    :
  {
    *(.text .text.*)          /* everything else */
  }
  text_end = .;
}
