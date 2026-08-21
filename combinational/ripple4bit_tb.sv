//Name: Wiesmes Antwi
//Purpose of Program: Testbench for 4-bit ripple carry adder using FA modules

`timescale 1ns/100ps

module ripple4bit_tb;

// Inputs: 2 four-bit numbers
reg [3:0] a_tb, b_tb;

// Output: 5-bit sum (S[3:0] is sum, S[4] is final carry)
wire [4:0] sum_tb;

// Instantiate Device Under Test (DUT)
ripple4bit dut (
  .A(a_tb),
  .B(b_tb),
  .S(sum_tb)
);

initial begin 
  a_tb = 4'b0000; 
  b_tb = 4'b0000; 
end

// Test different input combinations
initial begin
  #5 a_tb=4'b0000; b_tb=4'b0000;
  #5 a_tb=4'b0001; b_tb=4'b0001;
  #5 a_tb=4'b0011; b_tb=4'b0001;
  #5 a_tb=4'b0101; b_tb=4'b0011;
  #5 a_tb=4'b0111; b_tb=4'b0111;
  #5 a_tb=4'b1111; b_tb=4'b0001;
  #5 a_tb=4'b1111; b_tb=4'b1111;
  #5 a_tb=4'b1010; b_tb=4'b0101;
end

// Waveform file
initial begin
  $dumpfile("ripple4bit.vcd");
  $dumpvars;
end

// Log output
initial begin 
  $display(" A      B     |  Sum[4:0] ");
  $monitor("%b   %b   |   %b", a_tb, b_tb, sum_tb);
end

initial #100 $finish;// finish

endmodule
