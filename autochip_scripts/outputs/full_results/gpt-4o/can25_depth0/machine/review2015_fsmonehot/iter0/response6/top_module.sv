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

    // State Encoding
    parameter S = 0, S1 = 1, S11 = 2, S110 = 3, B0 = 4, B1 = 5, B2 = 6, 
              B3 = 7, Count = 8, Wait = 9;

    // done signal: 1 in state Wait
    assign done = state[Wait];

    // counting signal: 1 in state Count
    assign counting = state[Count];

    // shift_ena signal: 1 in states B0, B1, B2, B3
    assign shift_ena = state[B0] | state[B1] | state[B2] | state[B3];

    // B3_next output: 1 when state B2 is active
    assign B3_next = state[B2];

    // S_next output: 1 in specific conditions
    assign S_next = (state[S] & ~d) | 
                    (state[S1] & ~d) | 
                    (state[S110] & ~d) | 
                    (state[Wait] & ack);

    // S1_next output: 1 when state S and d is 1
    assign S1_next = state[S] & d;

    // Count_next output: 1 in specific conditions
    assign Count_next = state[B3] | 
                        (state[Count] & ~done_counting);

    // Wait_next output: 1 in specific conditions
    assign Wait_next = (state[Count] & done_counting) | 
                       (state[Wait] & ~ack);

endmodule
