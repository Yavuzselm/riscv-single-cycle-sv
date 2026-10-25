module regfile(
    input logic clk, we3,
    input logic [4:0] a1, a2, a3,
    input logic [31:0] wd3,
    output logic [31:0] rd1, rd2
);

    logic [31:0] rf [31:0];

    

    always_ff @( posedge clk) begin 
        if(we3 == 1'b1 && a3 != 5'd0)
            rf[a3][31:0] <= wd3;  
    end

    assign rd1 = (a1 == 5'd0) ? 32'd0 : rf[a1];
    assign rd2 = (a2 == 5'd0) ? 32'd0 : rf[a2];

    
endmodule 
