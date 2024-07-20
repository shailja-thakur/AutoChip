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

assign B3_next = state[8] & ack;
assign S_next = (state[9] & (state[8] | d)) | (state[7] & ack);
assign S1_next = (state[8] & ~state[7] & ack) | (state[7] & (state[8] | d));
assign Count_next = (state[7] & state[6] & counting) & ~done_counting;
assign Wait_next = (state[7] & state[6] & counting) & done_counting;
assign done = state[4] & state[5] & state[6] & state[7] & state[8] & state[9];
assign counting = state[3];
assign shift_ena = state[2] | state[1] | state[0];

endmodule
