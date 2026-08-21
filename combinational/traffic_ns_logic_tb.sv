//Name: Wiesmes Antwi
//Purpose of Program: Testbench for next state logic module

`timescale 1ns/100ps

module ns_tb;

//Inputs to DUT
reg Q3, Q2, Q1, e;

//Outputs from DUT
wire Q3_next, Q2_next, Q1_next;

//Instantiate Device Under Test (DUT)
ns dut(
  .Q3(Q3),
  .Q2(Q2),
  .Q1(Q1),
  .e(e),
  .Q3_next(Q3_next),
  .Q2_next(Q2_next),
  .Q1_next(Q1_next)
);

//Waveform file
initial begin
  $dumpfile("ns.vcd");
  $dumpvars;
end

//Log output
initial begin
  $display(" time |  Q3 Q2 Q1 e | Q3_next | Q2_next | Q1_next ");
  $monitor("%4t  |  %b  %b  %b  %b |    %b    |     %b   |    %b",
           $time, Q3, Q2, Q1, e, Q3_next, Q2_next, Q1_next);
end

//Stimulus block
initial begin

  //Test pattern with e = 0
  e = 0;
  Q3=0; Q2=0; Q1=0; #10;
  Q3=0; Q2=0; Q1=1; #10;
  Q3=0; Q2=1; Q1=0; #10;
  Q3=0; Q2=1; Q1=1; #10;
  Q3=1; Q2=0; Q1=0; #10;
  Q3=1; Q2=0; Q1=1; #10;
  Q3=1; Q2=1; Q1=0; #10;
  Q3=1; Q2=1; Q1=1; #10;

  //Test pattern with e = 1
  e = 1;
  Q3=0; Q2=0; Q1=0; #10;
  Q3=0; Q2=0; Q1=1; #10;
  Q3=0; Q2=1; Q1=0; #10;
  Q3=0; Q2=1; Q1=1; #10;
  Q3=1; Q2=0; Q1=0; #10;
  Q3=1; Q2=0; Q1=1; #10;
  Q3=1; Q2=1; Q1=0; #10;
  Q3=1; Q2=1; Q1=1; #10;

  #10 $finish;

end

endmodule
