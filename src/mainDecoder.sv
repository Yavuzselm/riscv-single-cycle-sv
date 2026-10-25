module mainDecoder(
    input logic [6:0] op,
    output logic [1:0] AluOp,
    output logic Branch,
    output logic [1:0] ResultSrc,
    output logic MemWrite,
    output logic AluSrc,
    output logic [2:0] ImmSrc,
    output logic RegWrite,
    output logic jal,
    output logic jalr
);

    always_comb begin

        AluOp = 2'b00;
        Branch = 1'b0;
        ResultSrc = 2'b00;
        MemWrite = 1'b0;
        AluSrc = 1'b0;
        ImmSrc = 3'b000;
        RegWrite = 1'b0;
        jal = 1'b0;
        jalr = 1'b0;

        case(op)

            7'b0000011: begin  // load instructions lb/lh/lw/lbu/lhu
                RegWrite = 1'b1;
                AluSrc = 1'b1;
                ResultSrc = 2'b01;
            end

            7'b0010011: begin //immediate arithmetic instructions
                AluOp = 2'b10;
                AluSrc = 1'b1;
                RegWrite = 1'b1;
            end

            7'b0100011: begin //sw
                ImmSrc = 3'b001;
                AluSrc = 1'b1;
                MemWrite = 1'b1;
            end

            7'b0110011: begin  // R type instructions
                RegWrite = 1'b1;
                AluOp = 2'b10;
            end

            7'b1100011: begin  // branch instructions 
                ImmSrc = 3'b010;
                Branch = 1'b1;
                AluOp = 2'b01;
            end

            7'b0110111: begin // lui
                ResultSrc = 2'b11;
                ImmSrc = 3'b11;
                RegWrite = 1'b1;
            end

            7'b1101111: begin //jal
                ResultSrc = 2'b10;
                ImmSrc = 3'b100;
                RegWrite = 1;
                jal = 1'b1;
            end

            7'b1100111: begin //jalr
                ResultSrc = 2'b10;
                AluOp = 2'b00;
                AluSrc = 1'b1;
                ImmSrc = 3'b100;
                RegWrite = 1'b1;
                jalr = 1'b1;
            end
            default: begin
                $error("Alert: Undefined Opcode encountered: %b", op);
            end
        endcase
            
        
    end

endmodule
