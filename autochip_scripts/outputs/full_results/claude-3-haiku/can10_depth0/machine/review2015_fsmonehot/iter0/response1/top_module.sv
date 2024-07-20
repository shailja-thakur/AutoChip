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

    // Decode the current state
    wire S     = state[0];
    wire S1    = state[1];
    wire S11   = state[2];
    wire S110  = state[3];
    wire B0    = state[4];
    wire B1    = state[5];
    wire B2    = state[6];
    wire B3    = state[7];
    wire Count = state[8];
    wire Wait  = state[9];

    // Generate the output signals
    assign B3_next = B2;
    assign S_next = (S && !d) || (S1 && !d) || (S110 && !d) || (Wait && ack);
    assign S1_next = S && d;
    assign Count_next = (B3) || (Count && !done_counting);
    assign Wait_next = (Count && done_counting) || (Wait && !ack);

    assign done = Wait;
    assign counting = Count;
    assign shift_ena = B3 || B2 || B1 || B0;

endmodule
