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

    // State encoding
    localparam S     = 10'b0000000001,
               S1    = 10'b0000000010,
               S11   = 10'b0000000100,
               S110  = 10'b0000001000,
               B0    = 10'b0000010000,
               B1    = 10'b0000100000,
               B2    = 10'b0001000000,
               B3    = 10'b0010000000,
               Count = 10'b0100000000,
               Wait  = 10'b1000000000;

    // Next-state logic
    assign S_next     = state[S] & ~d | state[S1] & ~d | state[S110] & ~d | state[Wait] & ack;
    assign S1_next    = state[S] & d | state[S1] & d;
    assign B3_next    = state[B2];
    assign Count_next = state[B3] | (state[Count] & ~done_counting);
    assign Wait_next  = state[Count] & done_counting | state[Wait] & ~ack;

    // Output logic
    assign shift_ena = state[B0] | state[B1] | state[B2] | state[B3];
    assign counting  = state[Count];
    assign done      = state[Wait];

endmodule
