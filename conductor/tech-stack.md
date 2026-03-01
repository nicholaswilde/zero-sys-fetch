# Tech Stack: sys-fetch

## Programming Language
* **Assembly (x86_64, aarch64, & armv7):** Chosen for low-level control, high performance, and learning goals.
* **Assembler:** [GNU Assembler](https://sourceware.org/binutils/docs/as/) (`as`), for its standard integration with the GNU toolchain.

## Operating System & System Interface
* **OS:** Linux (64-bit and 32-bit).
* **Interface:** Direct Linux system calls (via `syscall` on x86_64 and `svc` on aarch64/armv7).
* **Architecture:** 
    - **amd64:** Intel/AMD 64-bit instruction set (x64).
    - **arm64:** ARM 64-bit instruction set (AArch64).
    - **armhf:** ARM 32-bit instruction set (ARMv7) with hard-float.

## Build & Tooling
* **Linker:** GNU Linker (`ld`) for creating executable ELF64 and ELF32 binaries.
* **Task Automation:** [Taskfile](https://taskfile.dev/) (Task) for managing build and execution workflows.
* **Debugger:** `gdb` (GNU Debugger) for verifying register states and memory layout.

## Testing & Verification
* **Verification Scripts:** [Bash](https://www.gnu.org/software/bash/) for writing non-interactive verification scripts.
* **Test Runner:** Task is used to orchestrate the build-test lifecycle.
