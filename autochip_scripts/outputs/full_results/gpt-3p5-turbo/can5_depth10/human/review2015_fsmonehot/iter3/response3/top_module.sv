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

assign B3_next = (state[6] & shift_ena) ? 1'b1 : 1'b0;
assign S_next = (state[0] & ~d | state[1] & d) ? 1'b1 : 1'b0;
assign S1_next = (state[1] & ~d | state[2] & d) ? 1'b1 : 1'b0;
assign Count_next = (state[7] & counting & ~done_counting | state[10] & done_counting) ? 1'b1 : 1'b0;
assign Wait_next = (state[8] & state[9] & ~ack | state[11] & ack) ? 1'b1 : 1'b0;
assign done = (state[9] & ack | state[12] & ~done_counting) ? 1'b1 : 1'b0;
assign counting = state[10]; 
assign shift_ena = state[6] | state[7] | state[8] | state[9] | state[10] | state[11] | state[12];

endmodule
