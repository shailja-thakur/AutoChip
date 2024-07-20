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
assign S_next = (state[0] & ~d) ? 1'b1 : 1'b0;
assign S1_next = (state[1] & d) ? 1'b1 : 1'b0;
assign Count_next = (state[8] & counting & ~done_counting) ? 1'b1 : 1'b0;
assign Wait_next = (state[9] & ~ack) ? 1'b1 : 1'b0;
assign done = (state[9] & ack) ? 1'b1 : 1'b0;
assign counting = state[8]; 
assign shift_ena = (state[6] | state[7] | state[8] | state[9]) ? 1'b1 : 1'b0;

endmodule
