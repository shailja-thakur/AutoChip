module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output B3_next,
    output S_next,
    output S1_next,
    output Count_next,
    output Wait_next,
    output done,
    output counting,
    output shift_ena
 );

// State transitions
assign B3_next = state[0] & shift_ena;
assign S_next = (state[0] & ~state[1] & ~d) | (state[1] & ~state[2] & d) | (state[3] & ~state[6]);
assign S1_next = (state[0] & ~state[2] & d) | (state[1] & ~state[3] & ~d) | (state[2] & ~state[4]);
assign Count_next = (state[6] & ~state[9] & done_counting) | (state[6] & ~state[7] & ~done_counting);
assign Wait_next = (state[9] & ~state[0] & ack) | (state[9] & ~state[8] & ~ack);

// Output logic
assign done = state[8] & ~state[9];
assign counting = state[5] | state[6] | state[7] | state[8] | state[9];
assign shift_ena = state[4] | state[5] | state[6] | state[7] | state[8] | state[9];

endmodule
