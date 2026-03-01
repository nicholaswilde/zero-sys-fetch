# Specification: feature_os_20260301

## Problem Statement
Implement OS detection for sys-fetch, specifically targeting Ubuntu 25.04 x86_64 as demonstrated in the reference output.

## Goals
1.  **OS Identification:** Retrieve OS name and version from system files (e.g., /etc/os-release).
2.  **Architecture Detection:** Identify the CPU architecture (x86_64).
3.  **Assembly Implementation:** Implement in both x86_64 and AArch64 assembly.

## Requirements
- No modification of .S files by the AI agent.
- Must remain dependency-free (no libc).
