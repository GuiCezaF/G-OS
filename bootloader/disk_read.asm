read_disk:
  pusha
  push dx

  ; Register  Parameter
  ; ah        Mode (0x02 = read from disk)
  ; al        Number of sectors to read
  ; ch        Cylinder
  ; cl        Sector
  ; dh        Head
  ; dl        Drive
  ; es:bx     Memory address to load into (buffer address pointer)

  mov ah, 0x02                  ; read mode
  mov al, dh                    ; read dh number of sectors
  mov cl, 0x02                  ; start from sector 2 (1 is boot)
  mov ch, 0x00                  ; cylinder
  mov dh, 0x00                  ; head 0

  ; dl = drive number is set as input to read_disk
  ; es:bx = buffer pointer is set as input as well

  int 0x13                      ; BIOS disk interrupt
  jc read_disk_error            ; check carry bit for error

  pop dx                        ; get back original number of sectors to read

  ; BIOS sets 'al' to the number of sectors actually read.
  ; compare it to 'dh' and error out if they are different
  cmp al, dh
  jne sector_count_error
  popa
  ret

read_disk_error:
  jmp read_disk

sector_count_error:
  jmp halt_forever

halt_forever:
  jmp $
