# Product Guidelines: sys-fetch

## Development Principles
* **Assembly-First:** The primary goal is learning assembly (x86_64 & AArch64). High-level abstractions are discouraged.
* **Direct I/O:** Use native Linux system calls (`syscall` on amd64, `svc` on arm64) instead of library functions.
* **Minimalist Architecture:** Prioritize linear execution and explicit register management.

## Project Structure & Conventions
* **Source:** All `.S` files reside in architecture-specific subdirectories under `src/` (e.g., `src/x86_64/`, `src/aarch64/`).
* **Build Artifacts:** Compiled objects (`.o`) and final binaries are generated within architecture-specific subdirectories under `bin/` (e.g., `bin/x86_64/`, `bin/aarch64/`).
* **Code Style:** Use GNU Assembler-compatible syntax and follow consistent indentation for labels, instructions, and operands.

## Documentation Standards
* **Detailed Comments:** Every block of assembly should be thoroughly commented to explain register usage, logic, and intended side effects.
* **Reference Tracking:** Maintain a list of used system calls (e.g., in `docs/syscalls.md`) including their opcode, register map, and return values.

## UX/CLI Principles
* **Speed:** The tool must execute and exit within milliseconds.
* **Clean Output:** Display only the requested metrics by default, without unnecessary text or banners.
