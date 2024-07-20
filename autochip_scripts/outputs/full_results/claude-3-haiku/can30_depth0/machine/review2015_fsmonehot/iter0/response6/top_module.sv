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

assign B3_next = (state[4] == 1'b1); // When state B2 is active
assign S_next = (state[0] & ~d) | (state[1] & ~d) | (state[2] & ~d) | (state[9] & ack);
assign S1_next = (state[0] & d);
assign Count_next = (state[3] == 1'b1) | (state[8] & ~done_counting);
assign Wait_next = (state[8] & done_counting) | (state[9] & ~ack);
assign done = (state[9] == 1'b1);
assign counting = (state[8] == 1'b1);
assign shift_ena = (state[3] == 1'b1) | (state[2] == 1'b1) | (state[1] == 1'b1) | (state[0] == 1'b1);

endmodule
