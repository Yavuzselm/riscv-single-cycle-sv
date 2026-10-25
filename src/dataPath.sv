module dataPath(
    input logic  clk,
    input logic [1:0] PCSrc,
    input logic  PCrst,
    input logic [1:0] ResultSrc,
    input logic  MemWrite,
    input logic  [3:0] AluControl, 
    input logic  AluSrc,
    input logic  [2:0] ImmSrc,
    input logic  RegWrite,
    input logic  [2:0] dataControl,
    output logic [6:0] op,
    output logic [2:0] funct3,
    output logic funct7_5,
    output logic zero,
    output logic [31:0] dummyPC, formatteddummy, PcPlusdummy
    
);
    logic [31:0] Instr;
    logic [31:0] PC, PCNext, PcPlus4, PCTarget;
    logic [31:0] Result;
    logic [31:0] SrcA, SrcB, Aluresult;
    logic [31:0] WriteData, ReadData, formattedData;
    logic [31:0] ImmExt;

    assign op = Instr[6:0];
    assign funct3 = Instr[14:12];
    assign funct7_5 = Instr[30];
    assign SrcB = AluSrc ? ImmExt : WriteData;

    assign dummyPC = PC;
    assign formatteddummy =formattedData;
    assign PcPlusdummy = PcPlus4;

    imem im(
        .a(PC),
        .rd(Instr)
    );

    regfile rg(
        .clk(clk),
        .we3(RegWrite),
        .a1(Instr[19:15]),
        .a2(Instr[24:20]),
        .a3(Instr[11:7]),
        .wd3(Result),
        .rd1(SrcA),
        .rd2(WriteData)
    );

    Alu AluMain(
        .a(SrcA),
        .b(SrcB),
        .alucontrol(AluControl),
        .result(Aluresult),
        .zero(zero)
    );

    dmem dm(
        .clk(clk),
        .we(MemWrite),
        .a(Aluresult),
        .wd(WriteData),
        .rd(ReadData)
    );

    loadFormatter lf(
        .adressPoint(Aluresult[1:0]),
        .dataControl(dataControl),
        .ReadData(ReadData),
        .formattedData(formattedData)
    );

    extender ext(
        .instr(Instr[31:7]),
        .ImmSrc(ImmSrc),
        .ImmExt(ImmExt)
    );

    adder PC4(
        .a(PC),
        .b(32'd4),
        .result(PcPlus4)
    );

    adder PCT(
        .a(PC),
        .b(ImmExt),
        .result(PCTarget)
    );

    always_comb begin
        case(ResultSrc)

            2'b00: Result = Aluresult;
            2'b01: Result = formattedData;
            2'b10: Result = 32'd0;
            2'b11: Result = ImmExt;
            default: Result = Aluresult;

        endcase

        case(PCSrc)

            2'b00: PCNext = PcPlus4;
            2'b01: PCNext = PCTarget;
            2'b11: PCNext = Aluresult;
            default: PCNext = PcPlus4;
        endcase
    end


    always_ff @(posedge clk) begin
        if(PCrst)
            PC <= 32'd0;
        else 
            PC <= PCNext; 
    end


endmodule
