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
    wire is_S    = state[0];
    wire is_S1   = state[1];
    wire is_S11  = state[2];
    wire is_S110 = state[3];
    wire is_B0   = state[4];
    wire is_B1   = state[5];
    wire is_B2   = state[6];
    wire is_B3   = state[7];
    wire is_Count= state[8];
    wire is_Wait = state[9];

    // Assign the outputs
    assign B3_next   = is_B2;
    assign S_next    = (is_S && !d) || (is_S1 && !d) || (is_S110 && !d) || (is_Wait && ack);
    assign S1_next   = is_S && d;
    assign Count_next= (is_B3) || (is_Count && !done_counting);
    assign Wait_next = (is_Count && done_counting) || (is_Wait && !ack);
    assign done      = is_Wait;
    assign counting  = is_Count;
    assign shift_ena = is_B3 || is_B2 || is_B1 || is_B0;

endmodule
