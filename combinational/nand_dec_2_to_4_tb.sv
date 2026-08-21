//Name: Wiesmes Antwi
//Purpose of Program: Testbench for 2 to 4 NAND decoder
//*******************************************

`timescale 1ns/100ps

module nand_dec_2_to_4_tb;  // <-- updated name

  reg  A_tb, B_tb, E_tb;
  wire Y0_tb, Y1_tb, Y2_tb, Y3_tb;

  // Instantiate the DUT (Device Under Test)
  nand_dec_2_to_4 dut(
      .A(A_tb), .B(B_tb), .E(E_tb),
      .Y0(Y0_tb), .Y1(Y1_tb), .Y2(Y2_tb), .Y3(Y3_tb)
  );

  // Initialize inputs
  initial begin
    A_tb = 0; B_tb = 0; E_tb = 0;
  end

  // Apply test vectors
  always begin
    // E = 0 rows
    #5 A_tb=0; B_tb=0; E_tb=0;
    #5 A_tb=0; B_tb=1; E_tb=0;
    #5 A_tb=1; B_tb=0; E_tb=0;
    #5
