// Name: Wiesmes Wozawoyemena Antwi
// Project: Theater Control System — Spotlight Driver Testbench
// Purpose: Verify spotlight position decoding and the centered-when-disabled
//          override, using active-low performer sensors
//**************************************************************
`timescale 1ns/100ps

module spotlight_driver_tb;

    // Inputs
    reg SL;                     // spotlight enable
    reg TL_n, TC_n, TR_n;       // active-low performer sensors

    // Output
    wire [1:0] SLP;             // 00 = left, 01 = center, 11 = right

    // DUT — wildcard connection matches ports to same-named signals
    spotlight_driver dut(.*);

    initial begin
        $dumpfile("spotlight_driver.vcd");
        $dumpvars(0, spotlight_driver_tb);
    end

    initial begin
        $display(" time | SL | TL_n TC_n TR_n || SLP");
        $monitor("%4t  |  %b |  %b    %b    %b   ||  %b",
                 $time, SL, TL_n, TC_n, TR_n, SLP);
    end

    initial begin
        // ---- Spotlight disabled: output must hold center regardless of sensors
        SL = 0;  TL_n = 1; TC_n = 1; TR_n = 1;  #2;
                 TL_n = 0; TC_n = 1; TR_n = 1;  #2;
                 TL_n = 1; TC_n = 0; TR_n = 1;  #2;
                 TL_n = 1; TC_n = 1; TR_n = 0;  #2;
                 TL_n = 1; TC_n = 1; TR_n = 1;  #2;

        // ---- Spotlight enabled: position follows the asserted sensor
        SL = 1;  TL_n = 0; TC_n = 1; TR_n = 1;  #2;   // left   -> 00
                 TL_n = 1; TC_n = 0; TR_n = 1;  #2;   // center -> 01
                 TL_n = 1; TC_n = 1; TR_n = 0;  #2;   // right  -> 11
                 TL_n = 1; TC_n = 1; TR_n = 1;  #2;   // idle   -> center

        #5 $finish;
    end

endmodule
