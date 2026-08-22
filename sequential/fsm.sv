// Name: Wiesmes Wozawoyemena Antwi
// Purpose: 3-state Moore FSM in behavioral style — parameterized state
//          encoding, case-based next-state logic, asynchronous reset
//
//   A --W=1--> B --W=1--> C --W=1--> C (holds)
//   C --W=0--> B --W=0--> A --W=0--> A (holds)
//   Output reflects the present state.
//**************************************************************
`timescale 1ns/100ps

module fsm(
    input        clk,
    input        reset,             // async, active-high -> state A
    input        W,
    output reg [1:0] state_out
);

    parameter A = 2'b00,
              B = 2'b01,
              C = 2'b10;

    reg [1:0] ps, ns;               // present state, next state

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            ps <= A;
        else
            ps <= ns;
    end

    // Next-state combinational logic
    always @(*) begin
        case (ps)
            A:       ns = W ? B : A;
            B:       ns = W ? C : A;
            C:       ns = W ? C : B;
            default: ns = A;
        endcase
    end

    // Moore output — depends only on present state
    always @(*) begin
        state_out = ps;
    end

endmodule
