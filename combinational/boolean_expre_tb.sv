//Name: Wiesmes Antwi
//Date: 10/15/2025
//Purpose of Program: This Homework question simulates and synthesizes the given logic circuit using gate-level style SystemVerilog. The Boolean expression implemented is: M = A'B(B + C)'
//*******************************************

//standardize the time units
`timescale 1ns/100ps
// format is timescale/precision



module boolean_expre_tb;

// Testbench inputs
reg a_tb, b_tb, c_tb;

// Output
wire m_tb;

// Connecting the testbench signals to the actual design (Device Under Test - DUT)
  boolean_expre dut(.A(a_tb), .B(b_tb), .C(c_tb), .M(m_tb));
 

initial begin //this block is to initialize the inputs
  a_tb =0; b_tb =0; c_tb =0;

end


initial//block that controls testing
begin

  #5 a_tb=0; b_tb=0; c_tb=0; //row 0
  #5 a_tb=0; b_tb=0; c_tb=1; //row 1
  #5 a_tb=0; b_tb=1; c_tb=0; //row 2
  #5 a_tb=0; b_tb=1; c_tb=1; //row 3
  #5 a_tb=1; b_tb=0; c_tb=0; //row 4
  #5 a_tb=1; b_tb=0; c_tb=1; //row 5
  #5 a_tb=1; b_tb=1; c_tb=0; //row 6
  #5 a_tb=1; b_tb=1; c_tb=1; //row 7


end
  
  //Code for making the waveform
  initial
    begin
      $dumpfile("HW5_2.vcd");
      $dumpvars;
    end
  

initial begin //This is the block that is setup to make the log output

  $display("A \t B \t C \t | M \t");

//setting up the variable coordination with the log output
  $monitor("%b \t %b \t %b \t | \t %b", a_tb, b_tb, c_tb, m_tb);
	
end

  initial #100 $finish;// end simulation 
endmodule
