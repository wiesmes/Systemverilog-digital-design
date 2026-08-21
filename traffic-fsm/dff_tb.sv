//Name: Wiesmes Antwi
//Purpose: Testbench for the D flip-flop — verifies that q follows d
//         on the rising clock edge and holds between edges
//*******************************************
`timescale 1ns/100ps

module dff_tb;

    reg clk, d;
    wire q;

    dff dut(.clk(clk), .d(d), .q(q));

    // 10 ns clock period
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("dff.vcd");
        $dumpvars(0, dff_tb);
    end

    initial begin
        $display(" time | clk | d | q ");
        $monitor("%4t  |  %b  | %b | %b", $time, clk, d, q);
    end

    initial begin
        d = 0;
        @(negedge clk) d = 1;   // should appear at q on next rising edge
        @(negedge clk) d = 0;
        @(negedge clk) d = 1;
        @(negedge clk) d = 1;   // no change — q should hold
