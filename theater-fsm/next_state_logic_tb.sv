// Name: Wiesmes Wozawoyemena Antwi
// Project: Theater Control System — Next State Logic Testbench
// Purpose: Sweep all present states under E=0 and E=1, then exercise each
//          mode select to verify mode-dependent transitions
//**************************************************************
`timescale 1ns/100ps

module ns_tb;

    reg q2, q1, q0;             // present state
    reg E, P, M, Sp;            // control inputs

    wire q2_next, q1_next, q0_next;

    ns dut(
        .E(E), .P(P), .M(M), .Sp(Sp),
        .q2(q2), .q1(q1), .q0(q0),
        .q2_next(q2_next), .q1_next(q1_next), .q0_next(q0_next)
    );

    initial begin
        $dumpfile("ns.vcd");
        $dumpvars(0, ns_tb);
    end

    initial begin
        $display(" time | E P M Sp |  ps  |  ns");
        $monitor("%4t  | %b %b %b %b  | %b%b%b  | %b%b%b",
                 $time, E, P, M, Sp, q2, q1, q0,
                 q2_next, q1_next, q0_next);
    end

    task sweep_states;
        begin
            #2 {q2,q1,q0} = 3'b000;
            #2 {q2,q1,q0} = 3'b001;
            #2 {q2,q1,q0} = 3'b010;
            #2 {q2,q1,q0} = 3'b011;
            #2 {q2,q1,q0} = 3'b100;
            #2 {q2,q1,q0} = 3'b101;
            #2 {q2,q1,q0} = 3'b110;
            #2 {q2,q1,q0} = 3'b111;
            #2;
        end
    endtask

    initial begin
        {q2,q1,q0} = 3'b000;
        E = 0; P = 0; M = 0; Sp = 0;

        // Enable low — every state must map to shutdown (110)
        sweep_states;

        // Enable high, no mode selected — default house behavior
        E = 1;
        sweep_states;

        // Each mode select in turn
        P  = 1; sweep_states; P  = 0;
        M  = 1; sweep_states; M  = 0;
        Sp = 1; sweep_states; Sp = 0;

        #10 $finish;
    end

endmodule
