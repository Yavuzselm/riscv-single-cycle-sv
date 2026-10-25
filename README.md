# Single-Cycle RISC-V (RV32I) Core

A 32-bit single-cycle RISC-V (`RV32I`) processor core written in SystemVerilog, synthesized in Gowin EDA and verified in simulation.

## Modules (`src/`)

- `riscv.sv`: Top-level processor module connecting `controlUnit` and `dataPath`.
- `controlUnit.sv`, `mainDecoder.sv`, `AluDecoder.sv`: Instruction decoding and control signal generation for R-type, I-type, S-type, B-type (`beq`, `bne`, `blt`, `bge`), U-type (`lui`), and J-type (`jal`, `jalr`) instructions.
- `dataPath.sv`: Program counter logic, register file routing, immediate extension, ALU execution, and memory interfacing.
- `Alu.sv` & `adder.sv`: 32-bit arithmetic and logic operations (`add`, `sub`, `and`, `or`, `xor`, `sll`, `srl`, `sra`, `slt`, `sltu`).
- `regfile.sv`: 32x32-bit dual-read, single-write register file (`x0` hardwired to 0).
- `extend.sv` & `loadFormatter.sv`: Immediate sign-extension and byte/halfword/word load formatting (`lb`, `lh`, `lw`, `lbu`, `lhu`).
- `imem.sv` & `dmem.sv`: Instruction and data memory modules initialized via `$readmemh`.
- `tb_riscv.sv` & `riscvtest.txt`: SystemVerilog testbench and hex test program.
