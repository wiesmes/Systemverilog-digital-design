//Name: Wiesmes Antwi
//Assignment: ECE 033 Homework 10_2 TB
//Purpose of Program: Testbench for output logic module
//*******************************************

`timescale 1ns/100ps

module lights_tb;

//input to DUT
reg Q1;

//outputs from DUT
wire R, G;

//Instantiate Device Under Test (DUT)
lights dut(
  .Q1(Q1),
  .R(R),
  .G(G)
);

//Waveform file
initial begin
  $dumpfile("lights.vcd");
  $dumpvars;
end

//Log output
initial begin
  $display(" time | Q1  | R | G ");
  $monitor("%4t  |  %b  | %b | %b", 
           $time, Q1, R, G);
end

//Stimulus block
initial begin
  Q1 = 0; #10;
  Q1 = 1; #10;
  Q1 = 0; #10;
  #10 $finish;
end

endmodule
