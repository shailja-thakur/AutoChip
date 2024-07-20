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

// State definitions
localparam [9:0] S = 10'b0000000001;   // State S
localparam [9:0] S1 = 10'b0000000010;  // State S1
localparam [9:0] S11 = 10'b0000000100; // State S11
localparam [9:0] S110 = 10'b0000001000; // State S110
localparam [9:0] B0 = 10'b0000010000;  // State B0
localparam [9:0] B1 = 10'b0000100000;  // State B1
localparam [9:0] B2 = 10'b0001000000;  // State B2
localparam [9:0] B3 = 10'b0010000000;  // State B3
localparam [9:0] Count = 10'b0100000000;  // State Count
localparam [9:0] Wait = 10'b1000000000;   // State Wait

// State assignment logic
always @(state) begin
    B3_next = (state == B2);  // Output B3_next is 1 when state B2 is active.
    S_next = ((state == S && d == 0) || (state == S1 && d == 0) || (state == S110 && d == 0) || (state == Wait && ack == 1));  // Output S_next is 1 under certain conditions.
    S1_next = (state == S && d == 1); // Output S1_next is 1 when state S and d is 1.
    Count_next = (state == B3 || (state == Count && done_counting == 0)); // Output Count_next is 1 under certain conditions.
    Wait_next = ((state == Count && done_counting == 1) || (state == Wait && ack == 0)); // Output Wait_next is 1 under certain conditions.
end

// Output signals
assign done = (state == Wait);  // Output done is 1 when state Wait is active.
assign counting = (state == Count);  // Output counting is 1 when state Count is active.
assign shift_ena = (state[B3] || state[B2] || state[B1] || state[B0]);  // Output shift_ena is 1 if any of the states B3, B2, B1 and B0 is active.

endmodule
