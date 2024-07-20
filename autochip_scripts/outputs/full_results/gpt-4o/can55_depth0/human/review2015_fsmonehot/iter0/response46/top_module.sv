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

    // state assignments for clarity
    localparam S      = 10'b0000000001;
    localparam S1     = 10'b0000000010;
    localparam S11    = 10'b0000000100;
    localparam S110   = 10'b0000001000;
    localparam B0     = 10'b0000010000;
    localparam B1     = 10'b0000100000;
    localparam B2     = 10'b0001000000;
    localparam B3     = 10'b0010000000;
    localparam Count  = 10'b0100000000;
    localparam Wait   = 10'b1000000000;

    // next-state logic
    assign B3_next = state[B2];
    assign S_next = state[S] & ~d | state[S1] & ~d | state[S110] & ~d | state[Wait] & ack;
    assign S1_next = state[S] & d | state[S1] & d;
    assign Count_next = state[B3] | (state[Count] & ~done_counting);
    assign Wait_next = state[Count] & done_counting | state[Wait] & ~ack;

    // output logic
    assign done = state[Wait];
    assign counting = state[Count];
    assign shift_ena = state[B0] | state[B1] | state[B2] | state[B3];

endmodule
