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

    // State encoding indices for easier access
    localparam S_INDEX     = 0,
               S1_INDEX    = 1,
               S11_INDEX   = 2,
               S110_INDEX  = 3,
               B0_INDEX    = 4,
               B1_INDEX    = 5,
               B2_INDEX    = 6,
               B3_INDEX    = 7,
               Count_INDEX = 8,
               Wait_INDEX  = 9;

    // Next-state logic
    assign S_next     = (state[S_INDEX] & ~d) | (state[S1_INDEX] & ~d) | (state[S110_INDEX] & ~d) | (state[Wait_INDEX] & ack);
    assign S1_next    = (state[S_INDEX] & d) | (state[S1_INDEX] & d);
    assign B3_next    = state[B2_INDEX];
    assign Count_next = state[B3_INDEX] | (state[Count_INDEX] & ~done_counting);
    assign Wait_next  = (state[Count_INDEX] & done_counting) | (state[Wait_INDEX] & ~ack);

    // Output logic
    assign shift_ena = state[B0_INDEX] | state[B1_INDEX] | state[B2_INDEX] | state[B3_INDEX];
    assign counting  = state[Count_INDEX];
    assign done      = state[Wait_INDEX];

endmodule
