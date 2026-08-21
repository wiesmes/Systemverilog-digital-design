
//Name: Wiesmes Antwi
//Date: 10/20/2025
//Purpose of Program: Full Adder using only AND/OR/NOT gates.The Boolean expression implemented is: S = A'(B'Cin + BCin')+A(BCin + (BCin)')  and Cout = (AB+ Cin(AB'+ B'A)) 
//*******************************************

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

