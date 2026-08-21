//Name: Wiesmes Antwi
//Purpose of Program: Testbench for 4-bit ripple carry adder using FA modules// 4-bit Ripple Carry Adder using FA modules

module fa(input A,B,C, output S, Cout);


//wires needed for intermediate connections for S
  
 // Intermediate wires for A xor B
  wire anot, bnot, cnot;// A', B', C'
  wire bnot_c, b_cnot, bc, bnot_cnot;// B'C, BC', BC, B'C'
  wire ss1, ss2;// B xor C, (B xor C)'
  wire sp1, sp2; // A'BxorC , A(BxorC)'
  wire fp1; //A xor B xor C
  
  //not gates
  not(anot, A);// A'
  not(bnot, B);// B'
  not(cnot, C);//C'
  
  
  //and gates
  and(bnot_c, bnot, C);//B'C
  and(b_cnot, B, cnot);//BC'
  and(bc, B, C);//BC
  and(bnot_cnot,bnot, cnot);//B'C'
  
  //or gates
  or(ss1,bnot_c, b_cnot);//  B xor C  = B'C + BC'
  or(ss2, bc, bnot_cnot);// (B xor C)' = (B'C + BC')'

  //final and gates
  and(sp1, anot, ss1);// A'B xor C
  and(sp2, A, ss2);//A(B xor C)'
  
  //Final expression
  or(S, sp1, sp2);//A xor B xor C
  
//Boolean expresion for Cout = (AB+ Cin(AB'+ B'A)) 
// wire for A xor B 
  wire a_bnot, anot_b, axorb;//AB', A'B, AB
  
  //wire for Cout = (AB+ Cin(AB'+ B'A)) 
  wire ab, c_axorb, fc2;// AB, C(AB'+ B'A),(AB+ C(AB'+ B'A))
  
  //gates for A xor B 
  and (a_bnot, A, bnot);// AB'
  and (anot_b, anot, B);//A'B
  or(axorb, a_bnot, anot_b);//AB' + A'B
  
  //gates for Cout = (AB+ C(AB'+ B'A)) 
  and(ab, A, B);// AB
  and(c_axorb, C, axorb);//C(AB'+ A'B)
  
  or(Cout, ab, c_axorb);// AB + C(AB'+ A'B)

endmodule




module ripple4bit(
    input  [3:0] A,     // 4-bit input A
    input  [3:0] B,     // 4-bit input B
    output [4:0] S      // 5-bit sum output (includes final carry)
);

  // Internal carry wires
  wire C0, C1, C2;

  // 4 Full Adders chained together
  fa FA0 (.A(A[0]), .B(B[0]), .C(1'b0), .S(S[0]), .Cout(C0)); // Cin = 0 for first FA  hence i bit binary of 0
  fa FA1 (.A(A[1]), .B(B[1]), .C(C0),   .S(S[1]), .Cout(C1));// Cin is the carry form FA0
  fa FA2 (.A(A[2]), .B(B[2]), .C(C1),   .S(S[2]), .Cout(C2));// Cin is the carry from FA1
  fa FA3 (.A(A[3]), .B(B[3]), .C(C2),   .S(S[3]), .Cout(S[4]));// Cin is the carry from FA2


endmodule
