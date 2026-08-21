
//Name: WIesmes Antwi
//Purpose of Program: Implementing the boolean expression Y = A'B'C'D + ABD + B'C using gate-level SystemVerilog
//*******************************************

module boolean_expre(input A,B,C,D, output Y);


//Declaring wires for intermediate connections
  //wires for each not operation
  wire anot,// for A'
  bnot,//for B'
  cnot;// for C'

//Implement not gates
  not na(anot, A);
  not nb(bnot, B);
  not nc(cnot, C);// not gate_name(out, in)
  
  //wires for the product terms
  wire yp1, yp2, yp3;
  
  //product terms
  and p1y_gate(yp1, anot, bnot, cnot, D);//A'B'C'D term
  and p2y_gate(yp2, A,B, D);// ABD term
  and p3y_gate(yp3,bnot, C);//B'C term
  
  //sum terms
  or finalY(Y,yp1, yp2, yp3);// Y=A’B’C’D+ABD+B’C
  
  

endmodule



