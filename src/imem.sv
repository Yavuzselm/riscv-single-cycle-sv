module imem(
    input logic [31:0] a,
    output logic [31:0] rd
);

    logic [31:0] ram [63:0];

   initial begin
    // 1. Fill the entire RAM array with 0 (NOP instructions)
    for (int i = 0; i < 64; i++) begin
        ram[i] = 32'h00000000; // 00000000 is a NOP (No Operation) in RISC-V
        end
    
         // 2. Load your 8 instructions from the text file
        $readmemh("riscvtest.txt", ram, 0, 9);
    end


    assign rd = ram[a[7:2]];
endmodule
