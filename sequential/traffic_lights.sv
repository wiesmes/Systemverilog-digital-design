//Name: Wiesmes Antwi
//Purpose of Program: Implementing the output logic equations for the traffic FSM
//*******************************************

module lights(input Q1, output R, G);

//Declaring wires for intermediate connections
  //wire for Q1'
  wire q1not;//for Q1'

//Implement not gates
  not nq1(q1not, Q1);

//output equations
  //R = Q1'
  assign R = q1not;

  //G = Q1
  assign G = Q1;

endmodule
