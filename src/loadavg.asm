global _start

section .data
    ; The file path must be null-terminated (the ', 0' at the end)
    filepath db '/proc/loadavg', 0  

section .bss
    ; Reserve 64 bytes of empty space in memory for our buffer
    buffer resb 64                  

section .text
_start:
    ; ----------------------------------------------------
    ; 1. OPEN THE FILE (sys_open)
    ; ----------------------------------------------------
    mov rax, 2          ; Syscall number 2 is sys_open
    mov rdi, filepath   ; Argument 1: Pointer to the file path string
    mov rsi, 0          ; Argument 2: Flags (0 = O_RDONLY)
    syscall             ; Call the Linux kernel

    ; The kernel returns the file descriptor in rax. 
    ; Let's save it to r8 so we don't lose it.
    mov r8, rax         

    ; ----------------------------------------------------
    ; 2. READ THE FILE (sys_read)
    ; ----------------------------------------------------
    mov rax, 0          ; Syscall number 0 is sys_read
    mov rdi, r8         ; Argument 1: The file descriptor we saved
    mov rsi, buffer     ; Argument 2: Pointer to our empty buffer
    mov rdx, 64         ; Argument 3: Maximum number of bytes to read
    syscall             

    ; The kernel returns the actual number of bytes read in rax.
    ; Let's save it to r9 so we know exactly how much to print.
    mov r9, rax         

    ; ----------------------------------------------------
    ; 3. WRITE TO THE TERMINAL (sys_write)
    ; ----------------------------------------------------
    mov rax, 1          ; Syscall number 1 is sys_write
    mov rdi, 1          ; Argument 1: File descriptor 1 (Standard Output)
    mov rsi, buffer     ; Argument 2: Pointer to the buffer containing our text
    mov rdx, r9         ; Argument 3: The exact number of bytes we just read
    syscall             

    ; ----------------------------------------------------
    ; 4. CLOSE THE FILE (sys_close)
    ; ----------------------------------------------------
    mov rax, 3          ; Syscall number 3 is sys_close
    mov rdi, r8         ; Argument 1: The file descriptor we saved earlier
    syscall             

    ; ----------------------------------------------------
    ; 5. EXIT THE PROGRAM (sys_exit)
    ; ----------------------------------------------------
    mov rax, 60         ; Syscall number 60 is sys_exit
    mov rdi, 0          ; Argument 1: Exit code (0 = success)
    syscall
