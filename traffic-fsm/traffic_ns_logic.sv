//Name: Wiesmes Antwi
// Program: Implementing the next state equations for the traffic FSM using gate-level SystemVerilog
//*******************************************

module ns(input Q3, Q2, Q1, e, output Q3_next, Q2_next, Q1_next);

//Declaring wires for intermediate connections
  //wires for each not operation
  wire q3not,//for Q3'
       q2not,//for Q2'
       q1not,//for Q1'
       enot;//for e'

//Implement not gates
  not nq3(q3not, Q3);
  not nq2(q2not, Q2);
  not nq1(q1not, Q1);
  not ne (enot,  e);//not gate_name(out, in)

  //wires for product terms for Q3*
  wire q3p1, q3p2;

  //Q3* = e'Q3 + eQ3'
  and q3_term1(q3p1, enot, Q3);
  and q3_term2(q3p2, e, q3not);
  or  q3_final(Q3_next, q3p1, q3p2);

  //wires for product terms for Q2*
  wire q2p1, q2p2, q2p3;

  //Q2* = e'Q2 + Q2Q3' + eQ2'Q3
  and q2_term1(q2p1, enot, Q2);
  and q2_term2(q2p2, Q2, q3not);
  and q2_term3(q2p3, e, q2not, Q3);
  or  q2_final(Q2_next, q2p1, q2p2, q2p3);

  //wires for product terms for Q1*
  wire q1p1, q1p2, q1p3, q1p4;

  //Q1* = Q1Q2' + e'Q1 + Q1Q2Q3' + eQ1'Q2Q3
  and q1_term1(q1p1, Q1, q2not);
  and q1_term2(q1p2, enot, Q1);
  and q1_term3(q1p3, Q1, Q2, q3not);
  and q1_term4(q1p4, e, q1not, Q2, Q3);
  or  q1_final(Q1_next, q1p1, q1p2, q1p3, q1p4);

endmodule
