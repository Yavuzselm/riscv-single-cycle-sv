module AluDecoder(
    input logic [2:0] funct3,
    input logic funct7_5,
    input logic op5,
    input logic [1:0] AluOp,
    output logic [3:0] AluControl
);

    logic isSub;
    assign isSub = funct7_5 & op5;

always_comb begin

    AluControl= 4'B000;

    case(AluOp)

        2'b00: begin
            AluControl = 4'b0000;
        end

        2'b01:begin
            case(funct3)

                3'b000: begin // beq (sub) branch taken if zero = 1
                    AluControl = 4'b001;
                end

                3'b001: begin //bne  (sub) branch taken if zero = 0
                    AluControl = 4'b001;
                end

                3'b100: begin //blt  (slt)  branch taken if zero = 0
                    AluControl = 4'b1000;
                end

                3'b101: begin //bge (slt) branch taken if zero = 1
                    AluControl = 4'b1000;
                end

                default: begin
                    AluControl = 4'b0000;
                end

            endcase
        end

        2'b10: begin
            case(funct3)

                3'b000: begin //and -- andi -- sub
                    if(isSub)
                        AluControl = 4'b0001;
                    else
                        AluControl = 4'b0000;
                end

                3'b001: begin //sll -- slli
                    if(funct7_5 == 1'b0)
                        AluControl = 4'b0101;
                end

                3'b010: begin //slt -- slti
                    AluControl = 4'b1000;
                end

                3'b011: begin //sltu -- sltiu
                    AluControl = 4'b1001;
                end

                3'b100: begin //xor -- xori
                    AluControl = 4'b0100;
                end

                3'b101: begin //srl -- srli  -- sra -- srai
                    if(funct7_5 == 1)
                        AluControl = 4'b0111;
                    else if(funct7_5 == 0)
                        AluControl = 4'b0110;
                end

                3'b110: begin // or -- ori
                    AluControl = 4'b011;
                end

                3'b111: begin // and -- andi
                    AluControl = 4'b0010;
                end

                default: begin
                    AluControl = 4'd0;
                end

            endcase
        end
    default: begin
        AluControl = 2'b00;
    end

    endcase
end


endmodule
