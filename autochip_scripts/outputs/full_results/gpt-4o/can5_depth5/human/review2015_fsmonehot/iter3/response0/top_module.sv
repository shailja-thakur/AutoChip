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

    // Next-state logic
    // S_next: (S) stays in S if d=0, or goes to S1 if d=1
    //         (S1) goes to S if d=0
    //         (S110) goes to S if d=0, or goes to B0 if d=1
    //         (Wait) goes to S if ack=1
    assign S_next = (state[0] & ~d) | (state[1] & ~d) | (state[3] & ~d) | (state[9] & ack);

    // S1_next: (S) goes to S1 if d=1
    //          (S1) stays in S1 if d=1
    assign S1_next = (state[0] & d) | (state[1] & d);

    // B3_next: (B2) -> B3
    assign B3_next = state[6];

    // Count_next: (B3) -> Count
    assign Count_next = state[7];

    // Wait_next: (Count) -> Count if !done_counting
    //            (Count) -> Wait if done_counting
    //            (Wait) stays in Wait if ack=0
    assign Wait_next = (state[8] & done_counting) | (state[9] & ~ack);

    // Output logic
    assign shift_ena = state[4] | state[5] | state[6] | state[7];
    assign counting = state[8];
    assign done = state[9];

endmodule
