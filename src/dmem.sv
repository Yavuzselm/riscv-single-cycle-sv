module dmem(
    input logic clk , we,
    input logic [31:0] a, wd,
    output logic [31:0] rd
);

    logic [31:0] ram [63:0];
    
    always_ff @(posedge clk) begin
        if(we == 1'b1)
            ram[a[7:2]] <= wd;
    end

    assign rd = ram[a[7:2]];
endmodule
