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

    // B3_next = B3 & (d == 1'b1)
    assign B3_next = state[8] & d;

    // S_next = (S & (d == 1'b0)) | (S110 & (d == 1'b0)) | Wait & ack
    assign S_next = (state[0] & ~d) | (state[7] & ~d) | (state[9] & ack);

    // S1_next = (S1 & (d == 1'b0)) | (S11 & (d == 1'b0))
    assign S1_next = (state[1] & ~d) | (state[2] & ~d);

    // Count_next = Count & ~done_counting
    assign Count_next = state[8] & ~done_counting;

    // Wait_next = (Wait & (ack == 1'b0)) | (Count & done_counting)
    assign Wait_next = (state[9] & ~ack) | (state[8] & done_counting);

    // done = Wait
    assign done = state[9];

    // counting = Count
    assign counting = state[8];

    // shift_ena = B0 | B1 | B2 | B3
    assign shift_ena = state[4] | state[5] | state[6] | state[7];

endmodule
