//Name: Wiesmes Antwi
//Purpose: Testbench for the full traffic FSM — drives the enable input
//         and observes state progression and light outputs over time
//*******************************************
`timescale 1ns/100ps

module traffic_tb;

    reg clk, e;
    wire R, G;

    traffic dut(.clk(clk), .e(e), .R(R), .G(G));

    // 10 ns clock period
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("traffic.vcd");
        $dumpvars(0, traffic_tb);
    end

    initial begin
        $display(" time | e | Q3 Q2 Q1 | R G ");
        $monitor("%4t  | %b |  %b  %b  %b | %b %b",
                 $time, e, dut.Q3, dut.Q2, dut.Q1, R, G);
    end

    initial begin
        e = 0;
        #20;                    // hold with enable low — state should not advance
        @(negedge clk) e = 1;   // enable asserted — state machine runs
        #100;
        @(negedge clk) e = 0;   // enable removed — state should freeze
        #40;
        @(negedge clk) e = 1;   // resume
        #60;
        $finish;
    end

endmodule
