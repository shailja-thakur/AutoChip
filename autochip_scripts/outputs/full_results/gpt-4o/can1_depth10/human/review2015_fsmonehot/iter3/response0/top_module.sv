module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,     // 10-bit one-hot current state
    output B3_next,
    output S_next,
    output S1_next,
    output Count_next,
    output Wait_next,
    output done,
    output counting,
    output shift_ena
);
    // State encoding
    localparam [9:0]
        S     = 10'b0000000001,
        S1    = 10'b0000000010,
        S11   = 10'b0000000100,
        S110  = 10'b0000001000,
        B0    = 10'b0000010000,
        B1    = 10'b0000100000,
        B2    = 10'b0001000000,
        B3    = 10'b0010000000,
        Count = 10'b0100000000,
        Wait  = 10'b1000000000;

    // State transition logic
    assign S_next     = (state[0] & ~d) | (state[1] & ~d) | (state[3] & ~d) | (state[9] & ack);
    assign S1_next    = state[0] & d;
    assign S11_next   = state[1] & d;
    assign S110_next  = state[2] & d;
    assign B0_next    = state[3] & d;
    assign B1_next    = state[4];
    assign B2_next    = state[5];
    assign B3_next    = state[6];
    assign Count_next = state[7] | (state[8] & ~done_counting);
    assign Wait_next  = state[8] & done_counting;

    // Output logic
    assign shift_ena  = state[4] | state[5] | state[6] | state[7];
    assign counting   = state[8];
    assign done       = state[9];

endmodule
