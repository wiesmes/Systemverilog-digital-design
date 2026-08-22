// Name: Wiesmes Wozawoyemena Antwi
// Project: Theater Control System — Top-Level FSM
// Purpose: Integrate the state register, next-state logic, Moore output
//          logic, and spotlight driver into the complete controller
//
//   7-state Moore machine, 3-bit binary encoding, asynchronous reset to S0.
//   E has highest priority: E=0 forces shutdown (S6). Mode changes route
//   through the all-off blackout state (S2).
//**************************************************************
`timescale 1ns/100ps

module fsm_top(
    input        clk,
    input        reset,         // async, active-high -> S0
    input        E,             // global enable
    input        P, M, Sp,      // mutually exclusive mode selects
    input        TL_n, TC_n, TR_n,   // active-low performer sensors
    output       HL,            // house lighting
    output       V,             // visualization display
    output       SL,            // spotlight enable
    output [1:0] SLP            // spotlight servo position
);

    // Present state
    reg  q2, q1, q0;
    wire q2_next, q1_next, q0_next;

    // Complements supplied to the output logic
    wire q2n = ~q2;
    wire q1n = ~q1;
    wire q0n = ~q0;

    // State register — asynchronous reset to S0 = 000
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q2 <= 1'b0;
            q1 <= 1'b0;
            q0 <= 1'b0;
        end
        else begin
            q2 <= q2_next;
            q1 <= q1_next;
            q0 <= q0_next;
        end
    end

    // Next-state combinational logic
    ns next_state_logic(
        .E(E), .P(P), .M(M), .Sp(Sp),
        .q2(q2), .q1(q1), .q0(q0),
        .q2_next(q2_next), .q1_next(q1_next), .q0_next(q0_next)
    );

    // Moore output logic
    output_logic out_logic(
        .q2(q2), .q2n(q2n),
        .q1(q1), .q1n(q1n),
        .q0(q0), .q0n(q0n),
        .HL(HL), .V(V), .SL(SL)
    );

    // Spotlight position decode
    spotlight_driver sp_driver(
        .SL(SL),
        .TL_n(TL_n), .TC_n(TC_n), .TR_n(TR_n),
        .SLP(SLP)
    );

endmodule
