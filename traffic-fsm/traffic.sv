//Name: Wiesmes Antwi
//Purpose: Top-level traffic FSM — next-state logic, D flip-flop state
//         register, and Moore output logic wired together
//*******************************************
`timescale 1ns/100ps

module traffic(input clk, e, output R, G);

    // Present state
    wire Q3, Q2, Q1;

    // Next state
    wire Q3_next, Q2_next, Q1_next;

    // Next-state combinational logic
    ns next_logic(.Q3(Q3), .Q2(Q2), .Q1(Q1), .e(e),
                  .Q3_next(Q3_next), .Q2_next(Q2_next), .Q1_next(Q1_next));

    // State register — one flip-flop per state bit
    dff ff3(.clk(clk), .d(Q3_next), .q(Q3));
    dff ff2(.clk(clk), .d(Q2_next), .q(Q2));
    dff ff1(.clk(clk), .d(Q1_next), .q(Q1));

    // Moore output logic
    lights out_logic(.Q1(Q1), .R(R), .G(G));

endmodule
