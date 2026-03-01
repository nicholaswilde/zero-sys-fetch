.global _start

# ----------------------------------------------------
# MACROS (GAS Style)
# ----------------------------------------------------
.macro print str, len
    mov $1, %rax            # sys_write
    mov $1, %rdi            # stdout
    mov \str, %rsi          # Argument 1: Pointer
    mov \len, %rdx          # Argument 2: Length
    syscall
.endm

.data
    load_path: .asciz "/proc/loadavg"    # .asciz automatically adds the null byte!
    
    load_err:  .ascii "Error: Could not open /proc/loadavg\n"
    .equ load_err_len, . - load_err      # The '.' represents the current memory address

    prefix:    .ascii "Load Average: \033[1;36m"
    .equ prefix_len, . - prefix

    sep1:      .ascii "\033[0m (1m) | \033[1;36m"
    .equ sep1_len, . - sep1

    sep2:      .ascii "\033[0m (5m) | \033[1;36m"
    .equ sep2_len, . - sep2

    suffix:    .ascii "\033[0m (15m)\n"
    .equ suffix_len, . - suffix

    host_path: .asciz "/proc/sys/kernel/hostname"
    host_err: .ascii "Error: Could not open /proc/sys/kernel/hostname\n"
    .equ host_err_len, . - host_err      # The '.' represents the current memory address
            
    host_pref: .ascii "Hostname: \033[1;32m"  # Green text
    .equ host_pref_len, . - host_pref

.bss
    .lcomm buffer, 2048     # Allocate 2KB of uninitialized memory
    .lcomm host_buffer, 256  # 256 bytes is plenty for a hostname

.text
_start:
    # ----------------------------------------------------
    # 1. OPEN & READ THE FILE
    # ----------------------------------------------------
    mov $2, %rax            # sys_open (Source comes FIRST in AT&T!)
    mov $load_path, %rdi    # Note the $ for the label address
    mov $0, %rsi            # O_RDONLY
    syscall

    cmp $0, %rax            # Compare 0 to %rax
    jl .load_error      
    mov %rax, %r8           # Save file descriptor
    
    mov $0, %rax            # sys_read
    mov %r8, %rdi         
    mov $buffer, %rsi     
    mov $2048, %rdx         
    syscall             

    mov $3, %rax            # sys_close
    mov %r8, %rdi         
    syscall             

    # ----------------------------------------------------
    # 2. PARSE THE BUFFER (The Memory Addressing Trick)
    # ----------------------------------------------------
    mov $0, %rcx            

.find_1m:
    # AT&T memory offset: base_address(%index_register)
    movb buffer(%rcx), %al  # Move exactly 1 byte (movb) from buffer+rcx into %al
    cmp $0x20, %al          
    je .found_1m
    inc %rcx
    jmp .find_1m

.found_1m:
    mov %rcx, %r9           
    inc %rcx             
    mov $buffer, %r10       
    add %rcx, %r10          
    mov %rcx, %r11        

.find_5m:
    movb buffer(%rcx), %al
    cmp $0x20, %al
    je .found_5m
    inc %rcx
    jmp .find_5m

.found_5m:
    mov %rcx, %r12        
    sub %r11, %r12          
    inc %rcx             
    mov $buffer, %r13     
    add %rcx, %r13        
    mov %rcx, %r14        

.find_15m:
    movb buffer(%rcx), %al
    cmp $0x20, %al
    je .found_15m
    inc %rcx
    jmp .find_15m

.found_15m:
    mov %rcx, %r15        
    sub %r14, %r15          

    # 1. Open /proc/sys/kernel/hostname
    mov $2, %rax            # sys_open
    mov $host_path, %rdi
    mov $0, %rsi            # O_RDONLY
    syscall

    cmp $0, %rax            # Compare 0 to %rax
    jl .host_error

    # 2. Read the file
    mov %rax, %r8           # Save file descriptor
    mov $0, %rax            # sys_read
    mov %r8, %rdi
    mov $host_buffer, %rsi
    mov $256, %rdx
    syscall
    mov %rax, %r9           # Save number of bytes read (length)
    
    # 3. Close the file
    mov $3, %rax            # sys_close
    mov %r8, %rdi
    syscall

    # ----------------------------------------------------
    # 3. PRINT THE OUTPUT
    # ----------------------------------------------------
    print $prefix, $prefix_len
    print $buffer, %r9            
    print $sep1, $sep1_len
    print %r10, %r12              
    print $sep2, $sep2_len
    print %r13, %r15              
    print $suffix, $suffix_len

    # 4. Print Prefix and Hostname
    # (Using your existing print macro)
    print $host_pref, $host_pref_len
    print $host_buffer, %r9

    # ----------------------------------------------------
    # 4. EXITS
    # ----------------------------------------------------
.exit:
    mov $60, %rax           # sys_exit
    mov $0, %rdi            
    syscall             

.load_error:
    print $load_err, $load_err_len
    mov $60, %rax         
    mov $1, %rdi            
    syscall

.host_error:
    print $host_err, $host_err_len
    mov $60, %rax         
    mov $1, %rdi            
    syscall
