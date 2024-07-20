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
    // State definitions
    localparam S = 0;
    localparam S1 = 1;
    localparam S11 = 2;
    localparam S110 = 3;
    localparam B0 = 4;
    localparam B1 = 5;
    localparam B2 = 6;
    localparam B3 = 7;
    localparam Count = 8;
    localparam Wait = 9;

    // Next-State Logic
    assign S_next = state[S] & ~d | state[S1] & ~d | state[S110] & ~d | state[Wait] & ack;
    assign S1_next = state[S] & d | state[S11] & ~d;
    assign B3_next = state[B2];
    assign Count_next = state[B3];
    assign Wait_next = state[Count] & done_counting | state[Wait] & ~ack;

    // Corrected Next-State Logic
    assign S11_next = state[S1] & d | state[S11] & d;
    assign S110_next = state[S11] & ~d;
    assign B0_next = state[S110] & d;
    assign B1_next = state[B0];
    assign B2_next = state[B1];

    // Output Logic
    assign done = state[Wait];
    assign counting = state[Count];
    assign shift_ena = state[B0] | state[B1] | state[B2] | state[B3];
endmodule
