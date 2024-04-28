; Bootloader loads this code at memory address 07C0h

start:
	mov ax, 07C0h
	mov ds, ax							; Setup data segment. all data loads are offset to this
	
	mov si, title_string
	call print_string
	
	mov si, message_string
	call print_string
	
	call load_kernel_from_disk
	jmp 0900h:0000						; jump to memory location where kernel was loaded
	
load_kernel_from_disk:
	mov ax, 0900h
	mov es, ax							; memory segment to load data from disk
	
	mov ah, 02h							; service # - read sectors and load into memory address ES:BX
	mov al, 01h							; # of sectors to load
	mov ch, 0h							; track #
	mov cl, 02h							; sector #
	mov dh, 0h							; head #
	mov dl, 80h							; disk type: 00h = floppy, 80h = hdd
	mov bx, 0h							; memory offset to load to (uses segment loaded into ES)
	int 13h								; BIOS hdd service - see https://en.wikipedia.org/wiki/INT_13H
	
	jc kernel_load_error				; if carry set then error loading data, error code is stored in AX

    ret
    
kernel_load_error:
	mov si, load_error_string
	call print_string
	
	jmp $								; infinite loop
	
print_string:
	mov ah, 0Eh							; service # - print character

print_char:
	lodsb								; SI holds the address of the next char - load char to AL and inc SI
	
	cmp al, 0
	je printing_finished				; hit the end of string marker
	
	int 10h								; BIOS video service - see https://en.wikipedia.org/wiki/INT_10H
	
	jmp print_char						; repest until printed entire string

printing_finished:
    mov al, 10d							; Print new line
    int 10h
    
    ; Reading current cursor position
    mov ah, 03h							; service # - read cursor position
	mov bh, 0							; page #
	int 10h
	
    ; Move the cursor to the beginning
	mov ah, 02h							; service # - set cursor posn
	mov dl, 0							; set column # to 0
	int 10h

	ret

title_string        db  'The Bootloader of BrownOS kernel!', 0
message_string      db  'The kernel is loading...', 0
load_error_string   db  'The kernel cannot be loaded', 0

times 510-($-$$) db 0					; fill bytes between the end of the load_error_string to the last 2 bytes of this 512 byte code segment with 0

dw 0xAA55								; boot loader magic code
