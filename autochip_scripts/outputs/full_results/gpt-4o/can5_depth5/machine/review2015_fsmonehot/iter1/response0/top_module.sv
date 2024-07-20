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

    // Define state encoding based on one-hot
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

    // Outputs based on states
    assign done = state[Wait];
    assign counting = state[Count];
    assign shift_ena = state[B3] | state[B2] | state[B1] | state[B0];

    // Next state logic
    assign B3_next = state[B2];
    assign S_next = (state[S] && !d) | (state[S1] && !d) | (state[S110] && !d) | (state[Wait] && ack);
    assign S1_next = state[S] && d;
    assign Count_next = state[B3] | (state[Count] && !done_counting);
    assign Wait_next = (state[Count] && done_counting) | (state[Wait] && !ack);

endmodule
