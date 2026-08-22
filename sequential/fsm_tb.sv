// Name: Wiesmes Wozawoyemena Antwi
// Purpose: Testbench for the 3-state behavioral FSM — verifies reset,
//          forward progression on W=1, and backward progression on W=0
//**************************************************************
`timescale 1ns/100ps

module fsm_tb;

    reg clk, reset, W;
    wire [1:0] state_out;

    fsm dut(.clk(clk), .reset(reset), .W(W), .state_out(state_out));

    // 10 ns clock
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("fsm.vcd");
        $dumpvars(0, fsm_tb);
    end

    initial begin
        $display(" time | reset | W | state");
        $monitor("%4t  |   %b   | %b |  %b",
                 $time, reset, W, state_out);
    end

    initial begin
        // Assert reset — state should force to A (00)
        reset = 1; W = 0;
        #12 reset = 0;

        // W held high: A -> B -> C, then hold at C
        @(negedge clk) W = 1;
        repeat (4) @(negedge clk);

        // W held low: C -> B -> A, then hold at A
        W = 0;
        repeat (4) @(negedge clk);

        // Reset asserted mid-sequence — should jump to A immediately
        W = 1;
        repeat (2) @(negedge clk);
        reset = 1;
        #3 reset = 0;

        repeat (3) @(negedge clk);
        $finish;
    end

endmodule
