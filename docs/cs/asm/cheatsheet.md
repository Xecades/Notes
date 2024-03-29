# ASM Cheatsheet

Mainly for Intel 8086 assembly.

## Registers

### General Purpose Registers

#### Data Registers

 - **AX** (**AH** + **AL**): Accumulator
 - **BX** (**BH** + **BL**): Base
 - **CX** (**CH** + **CL**): Count
 - **DX** (**DH** + **DL**): Data

> Later processors have 32-bit and 64-bit versions of these registers, named **EAX**, **EBX**, **ECX**, **EDX** (i386 and later) and **RAX**, **RBX**, **RCX**, **RDX** (x64 and later).

#### Index Registers

 - **SI**: Source Index
 - **DI**: Destination Index

#### Pointer Registers

  - **SP**: Stack Pointer
  - **BP**: Base Pointer

---

### Segment Registers

 - **CS**: Code Segment
 - **DS**: Data Segment
 - **SS**: Stack Segment
 - **ES**: Extra Segment

---

### Control Registers

 - **IP**: Instruction Pointer
 - **FL**: Flags Register

