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
assign S_next = state[0] & (~d);
assign S1_next = state[1] & d;
assign Count_next = state[6] & counting & (~done_counting) | state[6] & counting & done_counting;
assign Wait_next = state[7] & done;
   
// Output logic
assign done = state[8] & (~ack);
assign counting = state[6];
assign shift_ena = state[5] | state[4] | state[3] | state[2] | state[1] | state[0];

endmodule
