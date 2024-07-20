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

    wire S;
    wire S1;
    wire S11;
    wire S110;
    wire B0;
    wire B1;
    wire B2;
    wire B3;
    wire Count;
    wire Wait;

    // Next State Logic
    assign S_next = (state[0] && !d) || (state[1] && d);
    assign S1_next = (state[0] && d) || (state[1] && !d && !S11) || (state[2] && !d && S11);
    assign Count_next = state[8] && !done_counting || state[9] && done_counting;
    assign Wait_next = state[9] && !ack || state[8] && ack;

    // Output Logic
    assign done = state[8] && done_counting || state[9] && ack;
    assign counting = state[8] || state[9];
    assign shift_ena = state[4] || state[5] || state[6] || state[7] || state[8];
    assign B3_next = state[7];

endmodule
