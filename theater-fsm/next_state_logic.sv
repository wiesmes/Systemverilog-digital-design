// Name: Wiesmes Wozawoyemena Antwi
// Project: Theater Control System — Next State Logic
// Purpose: Minimized next-state equations for the 7-state Moore FSM
//
//   E  = global enable (highest priority; E=0 forces shutdown S6 = 110)
//   P / M / Sp = mutually exclusive mode selects (play / music / speaker)
//   State encoding: S0=000 ... S6=110
//**************************************************************
`timescale 1ns/100ps

module ns(
    input  wire E,              // global enable
    input  wire P,              // play mode select
    input  wire M,              // music mode select
    input  wire Sp,             // speaker mode select
    input  wire q2, q1, q0,     // present state
    output wire q2_next, q1_next, q0_next
);

    // State bit complements
    wire q2n = ~q2;
    wire q1n = ~q1;
    wire q0n = ~q0;

    // Q2* = E' + E( M(Q1Q0'Q2' + Q2Q0'Q1') + Sp(Q0Q2 + Q1Q0'Q2') )
    assign q2_next = ~E
                   | ( E & ( ( M  & ( (q1 & q0n & q2n)
                                    | (q2 & q0n & q1n) ) )
                           | ( Sp & ( (q0 & q2)
                                    | (q1 & q0n & q2n) ) ) ) );

    // Q1* = E' + E( P(Q1' + Q2') + M(Q0 + Q1'Q2') + Sp(Q0Q2' + Q0'Q1') )
    assign q1_next = ~E
                   | ( E & ( ( P  & (q1n | q2n) )
                           | ( M  & ( q0 | (q1n & q2n) ) )
                           | ( Sp & ( (q0 & q2n)
                                    | (q0n & q1n) ) ) ) );

    // Q0* = E( (P'M'Sp')(Q1' + Q2') + P(Q1Q2') + Sp(Q0Q2 + Q1Q0'Q2') )
    //       Shutdown forces Q0 = 0, so there is no E' term.
    assign q0_next = E & ( ( (~P & ~M & ~Sp) & (q1n | q2n) )
                         | ( P  & (q1 & q2n) )
                         | ( Sp & ( (q0 & q2)
                                  | (q1 & q0n & q2n) ) ) );

endmodule
