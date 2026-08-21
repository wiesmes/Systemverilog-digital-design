//Name: Wiesmes Antwi
//Purpose: Testbench for mux-based implementation of Y = A'B' + ACD and Z = AB' + CD
//*******************************************
`timescale 1ns/1ps

module sop_from_mux_tb;

    reg A_tb=0, B_tb=0, C_tb=0, D_tb=0, EN_tb;
    wire Y_tb, Z_tb;

    sop_from_mux dut(.A(A_tb), .B(B_tb), .C(C_tb), .D(D_tb),
                     .EN(EN_tb), .Y(Y_tb), .Z(Z_tb));

    initial begin
        $dumpfile("sop_from_mux.vcd");
        $dumpvars(0, sop_from_mux_tb);
    end
