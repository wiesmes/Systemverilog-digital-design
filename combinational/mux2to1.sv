//Name: Wiesmes Antwi
//Date: 10/27/2025
//Purpose of Program: Implement a 2-to-1 multiplexer with enable using gate-level SystemVerilog
//*******************************************

`timescale 1ns/1ps

//2-to-1 multiplexer module with enable
module mux2to1(input A, B, SEL, EN, output Y);
  
    // Internal wires for gate connections
    wire nSEL;      // NOT SEL
    wire and0;      // A · SEL'
    wire and1;      // B · SEL
    wire or_out;    // (A · SEL') + (B · SEL)

    // NOT gate for SEL inversion
    not sel_not(nSEL, SEL);          // SEL'

    // AND gates for input selection
    and and0_gate(and0, A, nSEL);    // A · SEL'
    and and1_gate(and1, B, SEL);     // B · SEL

    // OR gate for mux output
    or or_gate(or_out, and0, and1);  // (A · SEL') + (B · SEL)

    // Final AND gate for enable control
    and en_gate(Y, or_out, EN);      // Y = [(A · SEL') + (B · SEL)] · EN
    
endmodule

