module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output reg B3_next,  // Output for B3_next
    output reg S_next,   // Output for S_next
    output reg S1_next,  // Output for S1_next
    output reg Count_next,  // Output for Count_next
    output reg Wait_next,  // Output for Wait_next
    output reg done,     // Output for done
    output reg counting,  // Output for counting
    output reg shift_ena  // Output for shift_ena
 );

// State definitions
parameter S = 10'b0000000001;
parameter S1 = 10'b0000000010;
parameter S11 = 10'b0000000011;
parameter S110 = 10'b0000000100;
parameter B0 = 10'b0000000101;
parameter B1 = 10'b0000000110;
parameter B2 = 10'b0000000111;
parameter B3 = 10'b0000001000;
parameter Count = 10'b0000001001;
parameter Wait = 10'b0000001010;

// Output signals equations
assign done = (state == Wait);  // done is 1 in the state Wait
assign counting = (state == Count);  // counting is 1 in the state Count
assign shift_ena = ((state == B3) || (state == B2) || (state == B1) || (state == B0));  // shift_ena is 1 if any of the states B3, B2, B1, or B0 is active
assign S_next = ((state == S && d == 0) || (state == S1 && d == 0) || (state == S110 && d == 0) || (state == Wait && ack == 1));  // S_next is 1 in the specified conditions
assign S1_next = (state == S && d == 1);  // S1_next is 1 when state S and d is 1
assign B3_next = (state == B2);  // B3_next is 1 when state B2 is active
assign Count_next = ((state == B3) || (state == Count && done_counting == 0));  // Count_next is 1 in the specified conditions
assign Wait_next = ((state == Count && done_counting == 1) || (state == Wait && ack == 0));  // Wait_next is 1 in the specified conditions

endmodule
