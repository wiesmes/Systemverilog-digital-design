// Name: Wiesmes Wozawoyemena Antwi
// Project: Theater Control System — Output Logic Testbench
// Purpose: Sweep all eight state encodings and verify HL, V, SL against the
//          state output table
//**************************************************************
`timescale 1ns/100ps

module output_logic_tb;

    reg q2, q2n;
    reg q1, q1n;
    reg q0, q0n;

    wire HL, V, SL;

    output_logic dut(.*);

    initial begin
        $dumpfile("output_logic.vcd");
        $dumpvars(0, output_logic_tb);
    end

    initial begin
        $display(" time | state | HL V SL");
        $monitor("%4t  |  %b%b%b  |  %b %b  %b",
                 $time, q2, q1, q0, HL, V, SL);
    end

    // Drive a state and its complements together
    task apply_state(input [2:0] s);
        begin
            {q2, q1, q0}    =  s;
            {q2n, q1n, q0n} = ~s;
            #2;
        end
    endtask

    initial begin
        apply_state(3'b000);   // S0 idle      -> 0 0 0
        apply_state(3'b001);   // S1 house     -> 1 0 0
        apply_state(3'b010);   // S2 all-off   -> 0 0 0
        apply_state(3'b011);   // S3 play      -> 0 1 1
        apply_state(3'b100);   // S4 music     -> 0 1 0
        apply_state(3'b101);   // S5 speaker   -> 0 0 1
        apply_state(3'b110);   // S6 shutdown  -> 0 0 0
        apply_state(3'b111);   // unused encoding
        #5 $finish;
    end

endmodule
