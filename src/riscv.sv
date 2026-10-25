module riscv(
    input logic PCrst,
    input logic clk,
    output logic dummy1, dummy2 ,dummy3, dummy4,
    output logic [31:0] dummy5, dummy6, dummy7
);

    logic [1:0] PCSrc, ResultSrc;
    logic MemWrite, AluSrc, RegWrite, funct7_5, zero;
    logic [3:0] AluControl;
    logic [2:0] ImmSrc, dataControl, funct3 ;
    logic [6:0] op;

    assign dummy1 = MemWrite;
    assign dummy2 = AluSrc;
    assign dummy3 = RegWrite;
    assign dummy4 = funct7_5;

    dataPath dp(
        .clk(clk),
        .PCSrc(PCSrc),
        .PCrst(PCrst),
        .ResultSrc(ResultSrc),
        .MemWrite(MemWrite),
        .AluControl(AluControl),
        .AluSrc(AluSrc),
        .ImmSrc(ImmSrc),
        .RegWrite(RegWrite),
        .dataControl(dataControl),
        .op(op),
        .funct3(funct3),
        .funct7_5(funct7_5),
        .zero(zero),
        .dummyPC(dummy5),
        .formatteddummy(dummy6),
        .PcPlusdummy(dummy7)
    );  

    controlUnit cu(
        .op(op),
        .funct3(funct3),
        .funct7_5(funct7_5),
        .zero(zero),
        .PCSrc(PCSrc),
        .ResultSrc(ResultSrc),
        .AluControl(AluControl),
        .AluSrc(AluSrc),
        .ImmSrc(ImmSrc),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .dataControl(dataControl)
    );


endmodule
