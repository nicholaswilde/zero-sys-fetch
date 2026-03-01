# Linux System Calls Reference

This document provides a reference for the Linux system calls used in the `sys-fetch` project.

## x86_64 Architecture Reference

### Register Map (x86_64)

| Register | Role |
| :--- | :--- |
| `RAX` | System call number / Return value |
| `RDI` | 1st argument |
| `RSI` | 2nd argument |
| `RDX` | 3rd argument |
| `R10` | 4th argument |
| `R8` | 5th argument |
| `R9` | 6th argument |

### System Call Opcodes (x86_64)

- `sys_read`: 0
- `sys_write`: 1
- `sys_open`: 2
- `sys_close`: 3
- `sys_exit`: 60

---

## ARMv7 (32-bit) Architecture Reference

### Register Map (ARMv7)

| Register | Role |
| :--- | :--- |
| `R7` | System call number |
| `R0` | 1st argument / Return value |
| `R1` | 2nd argument |
| `R2` | 3rd argument |
| `R3` | 4th argument |
| `R4` | 5th argument |
| `R5` | 6th argument |

### System Call Opcodes (ARMv7)

- `sys_exit`: 1
- `sys_read`: 3
- `sys_write`: 4
- `sys_open`: 5
- `sys_close`: 6

---

## Shared System Call Arguments

### `sys_read`
Used to read from a file descriptor.
- **Arguments:**
  - `fd`: File descriptor
  - `*buf`: Pointer to buffer
  - `count`: Number of bytes to read
- **Return Value:** Number of bytes read on success; negative error code on failure.

### `sys_write`
Used to write to a file descriptor.
- **Arguments:**
  - `fd`: File descriptor
  - `*buf`: Pointer to buffer
  - `count`: Number of bytes to write
- **Return Value:** Number of bytes written on success; negative error code on failure.

### `sys_open`
Used to open a file.
- **Arguments:**
  - `*filename`: Path to the file
  - `flags`: Access mode (e.g., `O_RDONLY = 0`)
  - `mode`: File permissions if creating
- **Return Value:** New file descriptor on success; negative error code on failure.

### `sys_close`
Used to close a file descriptor.
- **Arguments:**
  - `fd`: File descriptor to close
- **Return Value:** `0` on success; negative error code on failure.

### `sys_exit`
Used to terminate the calling process.
- **Arguments:**
  - `error_code`: Exit status code
- **Return Value:** None (does not return).
