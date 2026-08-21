
//Name: Wiesmes Antwi
//Purpose of Program:Testbench to simulate boolean_expreS = A'(B'Cin + BCin')+A(BCin + (BCin)')  and Cout = (AB+ Cin(AB'+ B'A)) .

//*******************************************

//standardize the time units
`timescale 1ns/100ps
// format is timescale/precision



module fa_tb;

// Testbench inputs 
reg a_tb, b_tb, c_tb;

// Output
wire S_tb, Cout_tb;

// Connecting the testbench signals to the actual design (Device Under Test - DUT)
  fa dut(.A(a_tb), .B(b_tb), .C(c_tb),  .S(S_tb), .Cout(Cout_tb));
 

initial begin //this block is to initialize the inputs
  a_tb =0; b_tb =0; c_tb =0;
end


initial//block that controls testing
begin

// Applying all 8 combinations of inputs to test the logic

  #5 a_tb=0; b_tb=0; c_tb=0;  //row 0
  #5 a_tb=0; b_tb=0; c_tb=1;  //row 1
  #5 a_tb=0; b_tb=1; c_tb=0;  //row 2
  #5 a_tb=0; b_tb=1; c_tb=1;  //row 3
  #5 a_tb=1; b_tb=0; c_tb=0;  //row 4
  #5 a_tb=1; b_tb=0; c_tb=1;  //row 5
  #5 a_tb=1; b_tb=1; c_tb=0;  //row 6
  #5 a_tb=1; b_tb=1; c_tb=1;  //row 7


end
  
  //waveform setup
  initial
    begin
      $dumpfile("HW6.vcd");
      $dumpvars;
    end
  
//// Print a log of inputs and outputs during simulation

initial begin 
 
  $display("A \t B \t C \t | S \t Cout");

//setting up the variable coordination with the log output
  $monitor("%b \t %b \t %b \t | %b \t %b", a_tb, b_tb, c_tb, S_tb, Cout_tb);
	
end
  // Stop the simulation after 100 nanoseconds
initial #100 $finish;

endmodule
