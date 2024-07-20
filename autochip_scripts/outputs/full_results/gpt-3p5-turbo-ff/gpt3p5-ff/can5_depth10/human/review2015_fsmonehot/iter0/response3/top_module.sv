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

// State transition logic
assign B3_next = state[9] & shift_ena;
assign S_next = state[0] & ~d;
assign S1_next = state[1] & d;
assign Count_next = state[8] & counting & ~done_counting | state[8] & counting & done_counting & ack;
assign Wait_next = state[8] & counting & done_counting & ~ack | state[9] & done;

// Output logic
assign done = state[9];
assign counting = state[7] | state[8] | state[9];
assign shift_ena = state[6] | state[7] | state[8] | state[9];

endmodule
