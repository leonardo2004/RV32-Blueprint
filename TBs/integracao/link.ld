OUTPUT_ARCH( "riscv" )
ENTRY(_start)

MEMORY
{
  /* 1024 * 4 bytes = 4K depth */
  INST_MEM (rx)  : ORIGIN = 0x00000000, LENGTH = 1K
  DATA_MEM (rwx) : ORIGIN = 0x00000000, LENGTH = 4K
}

SECTIONS
{
  /* Put all executable code into Instruction Memory */
  .text : {
    *(.text._start)
    *(.text .text.*)
  } > INST_MEM

  /* Put initialized global variables into Data Memory */
  .data : {
    *(.data .data.*)
  } > DATA_MEM

  /* Put uninitialized global variables into Data Memory */
  .bss : {
    *(.bss .bss.*)
    *(COMMON)
  } > DATA_MEM

  _end = .;
}
