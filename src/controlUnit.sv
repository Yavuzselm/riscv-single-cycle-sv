module controlUnit(
    input logic [6:0] op,
    input logic [2:0] funct3,
    input logic funct7_5,
    input logic zero,
    output logic [1:0] PCSrc,
    output logic [1:0] ResultSrc,
    output logic [3:0] AluControl,
    output logic AluSrc,
    output logic [2:0] ImmSrc,
    output logic RegWrite,
    output logic MemWrite,
    output logic [2:0] dataControl
);

    logic Branch;
    logic takeBranch;
    logic [1:0] AluOp;
    logic jal, jalr;

    assign takeBranch = funct3[0] ^ zero;
    assign dataControl = funct3;
    assign PCSrc[0] = (Branch & takeBranch) | jal;
    assign PCSrc[1] = jalr;

    mainDecoder mD(
        .op(op),
        .AluOp(AluOp),
        .Branch(Branch),
        .ResultSrc(ResultSrc),
        .MemWrite(MemWrite),
        .AluSrc(AluSrc),
        .ImmSrc(ImmSrc),
        .RegWrite(RegWrite),
        .jal(jal),
        .jalr(jalr)
    );

    AluDecoder aD(
        .funct3(funct3),
        .funct7_5(funct7_5),
        .AluOp(AluOp),
        .AluControl(AluControl),
        .op5(op[5])
    );

endmodule
