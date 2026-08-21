//Name: Wiesmes Antwi
//Purpose: Implement Y = A'B' + ACD and Z = AB' + CD using 2-to-1 multiplexers
//*******************************************
`timescale 1ns/1ps

module sop_from_mux(input A, B, C, D, EN, output Y, Z);

    // Internal wires
    wire nB;         // B'
    wire CD;         // C · D
    wire Bp_or_CD;   // B' + CD

    not notB(nB, B);
    and cd_gate(CD, C, D);

    // Y = A'B' + ACD  →  A=0: Y = B'   |   A=1: Y = CD
    mux2to1 muxY(.A(nB), .B(CD), .SEL(A), .EN(EN), .Y(Y));

    or or_gate(Bp_or_CD, nB, CD);

    // Z = AB' + CD  →  A=0: Z = CD   |   A=1: Z = B' + CD
    mux2to1 muxZ(.A(CD), .B(Bp_or_CD), .SEL(A), .EN(EN), .Y(Z));

endmodule
