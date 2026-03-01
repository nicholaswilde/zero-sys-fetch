# Product Definition: sys-fetch

## Vision
A hands-on project to master assembly language (x86_64, AArch64, & ARMv7) by developing high-performance, dependency-free CLI tools for Linux system monitoring.

## Core Goals
* **Learning & Mastery:** Deepen understanding of CPU registers, memory management, and low-level system interactions across architectures.
* **Performance & Efficiency:** Leverage pure assembly and native system calls to minimize resource usage and maximize execution speed.
* **Portability & Simplicity:** Create binaries that run natively on headless Linux environments (amd64, arm64, and armhf) without external library requirements (libc-free).

## Targeted Metrics
* **System Load Average:** Direct retrieval from `/proc/loadavg` using efficient file I/O and custom parsing.

## Verification & Reliability
* **Automated Testing:** A non-interactive verification suite ensures build integrity and output correctness across supported architectures.

## Design Constraints & Protocol
* **Source Control:** Only the human developer (user) modifies `.S` or assembly files.
* **Agent Role:** The AI agent acts as a facilitator, providing documentation, managing the build/run lifecycle, and researching system call references and optimization techniques.
* **Stack:** GNU Assembler (`as`), `ld` (GNU Linker), and the Linux x86_64, AArch64, and ARMv7 ABIs.
