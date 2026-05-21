ENTRY(_start)

SECTIONS
{
    . = 0x1000;

    .text ALIGN(4) :
    {
        *(.text .text.*)
    }

    .rodata ALIGN(4) :
    {
        *(.rodata .rodata.*)
    }

    .data ALIGN(4) :
    {
        *(.data .data.*)
    }

    .bss ALIGN(4) :
    {
        *(COMMON)
        *(.bss .bss.*)
    }

    /DISCARD/ :
    {
        *(.eh_frame .eh_frame_hdr)
        *(.note .note.*)
        *(.comment)
    }
}
