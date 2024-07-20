module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output reg B3_next,
    output reg S_next,
    output reg S1_next,
    output reg Count_next,
    output reg Wait_next,
    output reg done,
    output reg counting,
    output reg shift_ena
 );
 
 // State assignments
 localparam S = 0;    // State S
 localparam S1 = 1;   // State S1
 localparam S11 = 2;  // State S11
 localparam S110 = 3; // State S110
 localparam B0 = 4;   // State B0
 localparam B1 = 5;   // State B1
 localparam B2 = 6;   // State B2
 localparam B3 = 7;   // State B3
 localparam COUNT = 8; // State Count
 localparam WAIT = 9;  // State Wait
 
 // Intermediate variables for next state logic
 reg B3_next_int;
 reg S_next_int;
 reg S1_next_int;
 reg Count_next_int;
 reg Wait_next_int;
 
 always @* begin
    B3_next_int = (state[B2] == 1) ? 1'b1 : 1'b0;
    S_next_int = ((state[S] == 1 && d == 0) || (state[S1] == 1 && d == 0) || (state[S110] == 1 && d == 0) || (state[WAIT] == 1 && ack == 1)) ? 1'b1 : 1'b0;
    S1_next_int = (state[S] == 1 && d == 1) ? 1'b1 : 1'b0;
    Count_next_int = (state[B3] == 1 || (state[COUNT] == 1 && done_counting == 0)) ? 1'b1 : 1'b0;
    Wait_next_int = (state[COUNT] == 1 && done_counting == 1) || (state[WAIT] == 1 && ack == 0) ? 1'b1 : 1'b0;
 end
 
 // Assign next state outputs
 assign B3_next = B3_next_int;
 assign S_next = S_next_int;
 assign S1_next = S1_next_int;
 assign Count_next = Count_next_int;
 assign Wait_next = Wait_next_int;
 
 // Assign done and counting outputs
 assign done = (state[WAIT] == 1) ? 1'b1 : 1'b0;
 assign counting = (state[COUNT] == 1) ? 1'b1 : 1'b0;
 
 // Assign shift_ena output
 assign shift_ena = (state[B3] == 1 || state[B2] == 1 || state[B1] == 1 || state[B0] == 1) ? 1'b1 : 1'b0;
 
 endmodule
