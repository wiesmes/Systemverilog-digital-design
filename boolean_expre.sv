
//Name: Wiesmes Antwi
//Date: 10/15/2025
//Purpose of Program: Implementing the boolean expression M = A'B(B + C)' using using gate-level SystemVerilog
//*******************************************

// initializing input and output
module boolean_expre(input A,B,C, output M);


//Declare any wires you need for intermediate connections
  
 // Intermediate wires
    wire anot;// A'
    wire mp1; //A'B
  	wire sp1; //B+C
    wire bcnot;// (B + C)'

	// NOT gate for A
  not na_gate(anot, A);// A'

    // AND gate for A'B
  and p1m_gate(mp1, anot, B);// A'B

    // OR gate for (B + C)
  or sp1_gate(sp1, B, C);// B+C

    // NOT gate for (B + C)'
  not bc_gate(bcnot, sp1);//(B+C)'

    // Final AND gate for M = A'B(B + C)'
  and final_gate(M, bcnot, mp1);// M = A'B(B + C)'

endmodule




