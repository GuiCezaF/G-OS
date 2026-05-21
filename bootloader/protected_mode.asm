[bits 16]
enter_protected_mode:
  cli                         ; Disable interrupts
  lgdt [gdt_descriptor]       ; Load GDT descriptor
  mov eax, cr0
  or eax, 0x01                ; Enable protected mode
  mov cr0, eax
  jmp CODE_SEG:protected_mode_init    ; Far jump

[bits 32]
protected_mode_init:
  mov ax, DATA_SEG            ; Update segment register
  mov ds, ax
  mov ss, ax
  mov es, ax
  mov fs, ax
  mov gs, ax

  mov ebp, 0x90000            ; Set up stack
  mov esp, ebp

  call begin_32bit            ; Move back to boot_sector.asm
