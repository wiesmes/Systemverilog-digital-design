//Name: Wiesmes Antwi
//Purpose: 2-to-4 NAND decoder with enable (active low outputs)

module nand_dec_2_to_4 (  // ← Renamed to match functionality
  input  A, B, E,        // E = enable (active high)
  output Y0, Y1, Y2, Y3  // Active low outputs
);

  // Local inversions using NAND as NOT
  wire nA, nB;
  nand invA(nA, A, A);   // nA = ~A
  nand invB(nB, B, B);   // nB = ~B

  // Active low decoded outputs
  nand y0_gate(Y0, E, nA, nB); // Y0 = ~(E & ~A & ~B)
  nand y1_gate(Y1, E, nA,  B); // Y1 = ~(E & ~A &  B)
  nand y2_gate(Y2, E,  A, nB); // Y2 = ~(E &  A & ~B)
  nand y3_gate(Y3, E,  A,  B); // Y3 = ~(E &  A &  B)

endmodule
