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

    // Internal signals
    wire B3_active;
    wire B2_active;
    wire B1_active;
    wire B0_active;
    wire S_active;
    wire S1_active;
    wire S110_active;
    wire Count_active;
    wire Wait_active;

    // Assign the active signals based on the current state
    assign B3_active = state[7];
    assign B2_active = state[6];
    assign B1_active = state[5];
    assign B0_active = state[4];
    assign S_active = state[3];
    assign S1_active = state[2];
    assign S110_active = state[1];
    assign Count_active = state[0];
    assign Wait_active = ~Count_active;

    // Assign shift_ena based on B3, B2, B1, B0 active signals
    assign shift_ena = B3_active | B2_active | B1_active | B0_active;

    // Assign B3_next output
    assign B3_next = B2_active;

    // Assign S_next output
    assign S_next = ((S_active & ~d) | (S1_active & ~d) | (S110_active & ~d) | (Wait_active & ack));

    // Assign S1_next output
    assign S1_next = S_active & d;

    // Assign Count_next output
    assign Count_next = B3_active | (Count_active & ~done_counting);

    // Assign Wait_next output
    assign Wait_next = (Count_active & done_counting) | (Wait_active & ~ack);

    // Assign done output
    assign done = (state == 10'bWait);

    // Assign counting output
    assign counting = (state == 10'bCount);

endmodule
