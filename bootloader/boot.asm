BITS 16                       ; Define 16-bit assembly
ORG 0x7c00                    ; Define code origin adress, BIOS load boot sector in adress 0x7C00 


main:
; CLI = Clear Interrupt Flag.
; SP  = Stack Pointer
; STI = Set Interrupt Flag
; JZ  = Jump if Zero.
  cli                         ; Disable interupts temporarily
  mov sp, 0x7C00              ; Initialize stack pointer 
  sti                         ; Restore interruptions

  mov si, msg                 ; Move string msg to SI 
  call .print                  ; Save return adress in stack and jump to print

.halth:
  jmp .halth                  ; ininity loop


.print:
  lodsb                      ; Reads the byte pointed to by SI, Places it in AL and Increments SI
  ; Checking end of string, perform a logical AND operation
  ; but without keeping track of the result.
  test al, al

  jz .done                    ; If AL == 0, the string has ended, so it jumps to .done

  mov ah, 0x0E                ; Setting up BIOS printing, Select BIOS function: teletype output
  int 0x10                    ; BIOS call

  jmp .print                   ; continue loop


.done:
  ret                         ; load adress saved in stack and return after call

msg db 'Hello World from bootloader!', 0

; Fill the rest of the sector with zeros until you reach 510 bytes.
; The boot sector needs to have exactly 512 bytes 
times 510-($-$$) db 0         

; This is the BOOT signature
; The BIOS looks for exactly those 2 bytes at the end of the sector.
dw 0AA55h

