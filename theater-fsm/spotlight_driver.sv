// Name: Wiesmes Wozawoyemena Antwi
// Project: Theater Control System — Spotlight Driver
// Purpose: Decode active-low performer sensors into a 2-bit servo position,
//          defaulting to center whenever the spotlight is disabled
//
//   SLP encoding:  00 = left, 01 = center, 11 = right
//   SLP[1] = SL & ~TR_n        position bit asserted only when enabled
//   SLP[0] = ~SL | TL_n        forced high when disabled -> center
//**************************************************************
`timescale 1ns/100ps

module spotlight_driver (
    input  SL,                  // spotlight enable
    input  TL_n,                // active-low: performer at left
    input  TC_n,                // active-low: performer centered (implicit in equations)
    input  TR_n,                // active-low: performer at right
    output reg [1:0] SLP        // servo position
);

    always @(*) begin
        SLP[1] = SL & ~TR_n;
        SLP[0] = ~SL | TL_n;
    end

endmodule
