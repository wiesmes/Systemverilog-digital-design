// Name: Wiesmes Wozawoyemena Antwi
// Project: Theater Control System — Moore Output Logic
// Purpose: Drive house lighting, visualization, and spotlight enable from the
//          present state, using K-map minimized equations
//
//   State encoding: S0=000 idle, S1=001 house, S2=010 all-off, S3=011 play,
//                   S4=100 music, S5=101 speaker, S6=110 shutdown
//
//   Both polarities of each state bit are supplied as inputs, matching the
//   gate-level structure the equations were derived for.
//**************************************************************
`timescale 1ns/100ps

module output_logic(
    input  q2, q2n,
    input  q1, q1n,
    input  q0, q0n,
    output HL,          // house lighting
    output V,           // visualization display
    output SL           // spotlight enable
);

    // HL = Q2'Q1'Q0            — house mode only
    assign HL = q2n & q1n & q0;

    // V  = Q2Q1'Q0' + Q1Q0     — music and play
    assign V  = (q2 & q1n & q0n) | (q1 & q0);

    // SL = Q1Q0 + Q2Q0         — play and speaker
    assign SL = (q1 & q0) | (q2 & q0);

endmodule
