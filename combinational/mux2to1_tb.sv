//Name: Wiesmes Antwi
//Date: 10/27/2025
//Purpose of Program: Implement a 2-to-1 multiplexer with enable using gate-level AND/OR/NOT
//*******************************************


// Testbench for 2-to-1 mux
module mux2to1_tb;

    // Testbench inputs
    reg A_tb=0, B_tb=0, SEL_tb=0, EN_tb = 1;
    
    // Output
    wire Y_tb;

    // Connect testbench to mux
    mux2to1 dut(.A(A_tb), .B(B_tb), .SEL(SEL_tb), .EN(EN_tb), .Y(Y_tb));

    // Setup waveform dumping
    initial begin
        $dumpfile("mux2to1.vcd");
        $dumpvars(0, mux2to1_tb);
    end

    // Apply all input combinations
    initial begin

        #10 A_tb=0; B_tb=0; SEL_tb=0;
        #10 A_tb=0; B_tb=0; SEL_tb=1;
        #10 A_tb=0; B_tb=1; SEL_tb=0;
        #10 A_tb=0; B_tb=1; SEL_tb=1;
        #10 A_tb=1; B_tb=0; SEL_tb=0;
        #10 A_tb=1; B_tb=0; SEL_tb=1;
        #10 A_tb=1; B_tb=1; SEL_tb=0;
        #10 A_tb=1; B_tb=1; SEL_tb=1;

        // Test enable inactive
        #10 EN_tb = 0;
        #10 A_tb=1; B_tb=0; SEL_tb=0;
        #10 A_tb=0; B_tb=1; SEL_tb=1;

       // #10 $finish;
    end

    // Display results
    initial begin
        $display("EN \t SEL \t A \t B \t | \t Y");
        $monitor("%b \t %b \t %b \t %b \t | \t %b", 
                 EN_tb, SEL_tb, A_tb, B_tb, Y_tb);
    end
  // End simulation after all test cases
    initial #185 $finish;

endmodule
