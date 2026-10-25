# Single-Cycle RISC-V (RV32I) CPU

A 32-bit single-cycle RISC-V (`RV32I`) processor core written in SystemVerilog. Developed targeting the Tang Nano 20K FPGA using Gowin EDA.

## Overview

- **Architecture**: Single-cycle datapath executing one instruction per clock cycle.
- **Instruction Support**: Base integer instructions (`RV32I`), including:
  - Arithmetic and logic (`add`, `sub`, `and`, `or`, `xor`, `sll`, `srl`, `sra`, `slt`, `sltu`)
  - Loads and stores with byte/halfword sign and zero extension (`lb`, `lh`, `lw`, `lbu`, `lhu`, `sw`)
  - Branches and jumps (`beq`, `bne`, `blt`, `bge`, `jal`, `jalr`)
  - Upper immediates (`lui`)
- **Verification**: Verified in simulation using a SystemVerilog testbench (`tb_riscv.sv`) and sample test programs.
