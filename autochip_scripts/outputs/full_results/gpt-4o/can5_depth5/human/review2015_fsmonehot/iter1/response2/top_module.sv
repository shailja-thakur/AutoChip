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
    // State encoding index
    parameter S_idx = 0;
    parameter S1_idx = 1;
    parameter S11_idx = 2;
    parameter S110_idx = 3;
    parameter B0_idx = 4;
    parameter B1_idx = 5;
    parameter B2_idx = 6;
    parameter B3_idx = 7;
    parameter Count_idx = 8;
    parameter Wait_idx = 9;

    // Next-state logic
    assign S_next = state[S_idx] & ~d | state[S1_idx] & ~d | state[S110_idx] & ~d | state[Wait_idx] & ack;
    assign S1_next = state[S_idx] & d | state[S11_idx] & d;
    assign B3_next = state[B2_idx];
    assign Count_next = state[B3_idx];
    assign Wait_next = state[Count_idx] & done_counting | state[Wait_idx] & ~ack;

    // Output logic
    assign shift_ena = state[B0_idx] | state[B1_idx] | state[B2_idx] | state[B3_idx];
    assign counting = state[Count_idx];
    assign done = state[Wait_idx];
endmodule
