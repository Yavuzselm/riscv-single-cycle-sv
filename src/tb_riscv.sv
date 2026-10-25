`timescale 1ns / 1ps

module tb_riscv();

    logic clk;
    logic PCrst;

    // Test edilecek islemci (UUT)
    riscv uut (
        .clk(clk),
        .PCrst(PCrst)
    );

    // 100 MHz Saat Sinyali
    always #5 clk = ~clk;

    initial begin
        // DSim'i kizdirmadan sadece ana sinyalleri kaydediyoruz
        $dumpfile("simulation_output.vcd");
        $dumpvars(0, tb_riscv);

        // Baslangic durumlari
        clk = 0;
        PCrst = 1; // Islemciyi reset durumunda baslatiyoruz
        
        #15;
        PCrst = 0; // Reset sinyalini kaldiriyoruz
        
        #200;
        
        // Terminale otomatik dogrulama ciktisi basiyoruz
        $display("\n--- ISLEMCI TEST SONUCLARI ---");
        $display("x1 (10 olmali)  = %0d", uut.dp.rg.rf[1]);
        $display("x2 (20 olmali)  = %0d", uut.dp.rg.rf[2]);
        $display("x3 (30 olmali)  = %0d", uut.dp.rg.rf[3]);
        $display("x4 (10 olmali)  = %0d", uut.dp.rg.rf[4]);
        $display("x5 (LUI testi)  = %0h", uut.dp.rg.rf[5]); 
        $display("x6 (Load testi) = %0d", uut.dp.rg.rf[6]);
        $display("x7 (Atlanmali)  = %0d (0 degilse beq bozuktur!)", uut.dp.rg.rf[7]);
        $display("x8 (BEQ testi)  = %0d", uut.dp.rg.rf[8]);
        $display("------------------------------\n");
        
        $display("Simulasyon bitti. VCD dosyasi olusturuldu.");
        $finish;
    end

endmodule
