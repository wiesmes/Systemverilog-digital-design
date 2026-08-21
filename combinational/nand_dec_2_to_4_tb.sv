// nand_dec_2_to_4_tb.sv
`timescale 1ns/1ps
module tb_dec;
    reg a, b, en;
    wire d0, d1, d2, d3;

    nand_dec_2_to_1 uut (.a(a), .b(b), .en(en), .d0(d0), .d1(d1), .d2(d2), .d3(d3));

    integer i;
    initial begin
        $dumpfile("nand_dec.vcd");
        $dumpvars(0, tb_dec);
        en = 0;
        #5;
        en = 1; // enable decoder
        for (i = 0; i < 4; i = i + 1) begin
            {a,b} = i;
            #5;
        end
        #5;
        $display("Decoder test complete");
        $finish;
    end
endmodule
