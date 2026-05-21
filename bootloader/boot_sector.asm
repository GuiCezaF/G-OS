[bits 16]
[org 0x7c00]

; Load the kernel at this physical address.
KERNEL_LOAD_ADDRESS equ 0x1000

%ifndef KERNEL_SECTORS
%define KERNEL_SECTORS 2
%endif

cli
xor ax, ax
mov ds, ax
mov es, ax
mov ss, ax
mov sp, 0x9000

; BIOS places the boot drive number in DL.
mov [boot_drive], dl

call load_kernel
call enter_protected_mode

jmp $

%include "disk_read.asm"
%include "gdt.asm"
%include "protected_mode.asm"

[bits 16]
load_kernel:
    mov bx, KERNEL_LOAD_ADDRESS
    mov dh, KERNEL_SECTORS
    mov dl, [boot_drive]
    xor ax, ax
    mov es, ax
    call read_disk
    ret

[bits 32]
begin_32bit:
    mov eax, KERNEL_LOAD_ADDRESS
    jmp eax
    jmp $

boot_drive db 0

times 510-($-$$) db 0
dw 0AA55h
