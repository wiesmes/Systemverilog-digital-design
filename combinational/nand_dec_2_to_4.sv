//Name: Wiesmes Antwi
//Purpose of Program: 2-to-4 decoder using only NAND gates (gate-level SystemVerilog)
//*******************************************

// nand_dec_2_to_1.sv
// 2-to-4 NAND-based decoder with active-low outputs

`timescale 1ns/1ps
module nand_dec_2_to_1 (
    input  wire a,    // MSB
    input  wire b,    // LSB
    input  wire en,   // active-high enable
    output wire d0,   // active-low outputs: d0 corresponds to a=0,b=0
    output wire d1,   // a=0,b=1
    output wire d2,   // a=1,b=0
    output wire d3    // a=1,b=1
);

    // create A' and B' using NAND inverters: x' = nand(x,x)
    wire na, nb;
    nand (na, a, a); // na = ~a
    nand (nb, b, b); // nb = ~b

    // For active-low outputs: d0 = ~(en & na & nb)  -> nand(en, na, nb)
    // d1 = ~(en & na & b)
    // d2 = ~(en & a  & nb)
    // d3 = ~(en & a  & b)
    nand (d0, en, na, nb);
    nand (d1, en, na, b);
    nand (d2, en, a,  nb);
    nand (d3, en, a,  b);

endmodule
