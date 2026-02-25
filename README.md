# amd64-sys-fetch

**`amd64-sys-fetch`** is a fast, dependency-free CLI tool designed for headless Linux environments. Bypassing standard libraries entirely, this project interacts directly with the Linux kernel using x86_64 system calls to extract and display real-time system metrics. 

By reading directly from virtual files like `/proc/loadavg` and parsing the data in pure NASM assembly, this tool provides a hyper-optimized way to monitor server health without the overhead of heavy scripts or subshells.

## Key Features
* **Pure Assembly:** Written strictly in x86_64 assembly using NASM, giving absolute control over memory and 64-bit CPU registers.
* **Zero Dependencies:** Runs natively without the C standard library (libc) or any external package requirements.
* **Direct Kernel I/O:** Utilizes native Linux system calls (via the `syscall` instruction) for all file operations and terminal output.
* **Low Overhead:** Executes instantly, making it a perfectly lightweight monitoring tool for Debian servers.
