// Name: Wiesmes Antwi
// Purpose: Testbench for Y = A'B'C'D + ABD + B'C

`timescale 1ns/100ps

module boolean_expre_tb;
  
  // Testbench inputs 
  reg a_tb, b_tb, c_tb, d_tb;

  // Output
  wire y_tb;

  // Connecting the testbench signals to the actual design (Device Under Test - DUT)
  boolean_expre dut(.A(a_tb), .B(b_tb), .C(c_tb), .D(d_tb), .Y(y_tb));

  // Initial block to define the starting values
  initial begin
    a_tb = 0; 
    b_tb = 0; 
    c_tb = 0; 
    d_tb = 0;
  end
  
  // Applying all 16 combinations of inputs to test the logic
  initial begin
    #5 a_tb=0; b_tb=0; c_tb=0; d_tb=0;  // 0000
    #5 a_tb=0; b_tb=0; c_tb=0; d_tb=1;  // 0001
    #5 a_tb=0; b_tb=0; c_tb=1; d_tb=0;  // 0010
    #5 a_tb=0; b_tb=0; c_tb=1; d_tb=1;  // 0011
    #5 a_tb=0; b_tb=1; c_tb=0; d_tb=0;  // 0100
    #5 a_tb=0; b_tb=1; c_tb=0; d_tb=1;  // 0101
    #5 a_tb=0; b_tb=1; c_tb=1; d_tb=0;  // 0110
    #5 a_tb=0; b_tb=1; c_tb=1; d_tb=1;  // 0111
    #5 a_tb=1; b_tb=0; c_tb=0; d_tb=0;  // 1000
    #5 a_tb=1; b_tb=0; c_tb=0; d_tb=1;  // 1001
    #5 a_tb=1; b_tb=0; c_tb=1; d_tb=0;  // 1010
    #5 a_tb=1; b_tb=0; c_tb=1; d_tb=1;  // 1011
    #5 a_tb=1; b_tb=1; c_tb=0; d_tb=0;  // 1100
    #5 a_tb=1; b_tb=1; c_tb=0; d_tb=1;  // 1101
    #5 a_tb=1; b_tb=1; c_tb=1; d_tb=0;  // 1110
    #5 a_tb=1; b_tb=1; c_tb=1; d_tb=1;  // 1111
  end

  // waveform setup
  initial begin
    $dumpfile("HW5.vcd");
    $dumpvars;
  end

  // Print a log of inputs and outputs during simulation
  initial begin
    $display("A \t B \t C \t D \t | Y");
    $monitor("%b \t %b \t %b \t %b \t | %b", a_tb, b_tb, c_tb, d_tb, y_tb);
  end

  // Stop the simulation after 100 nanoseconds
  initial #100 $finish;

endmodule
