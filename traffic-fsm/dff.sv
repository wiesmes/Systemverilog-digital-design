//Name: Wiesmes Antwi
//Purpose: D flip-flop used as the state register element for the traffic FSM
//Note: no reset port — present state is initialized in simulation only
//*******************************************
`timescale 1ns/100ps

module dff(input clk, d, output q);

    reg qreg;               // stores present-state bit

    initial qreg = 0;       // simulation-only init (no reset in this design)

    always @(posedge clk)
        qreg <= d;

    assign q = qreg;

endmodule
