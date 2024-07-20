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

    // State encoding
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

    // Next-state logic
    assign S_next     = (S & ~d) | (S1 & ~d) | (S110 & ~d) | (Wait & ack);
    assign S1_next    = (S & d) | (S1 & d);
    assign S11_next   = (S1 & d) | (S11 & d);
    assign S110_next  = (S11 & ~d);
    assign B0_next    = (S110 & d);
    assign B1_next    = B0;
    assign B2_next    = B1;
    assign B3_next    = B2;
    assign Count_next = B3 | (Count & ~done_counting);
    assign Wait_next  = Count & done_counting | (Wait & ~ack);

    // Output logic
    assign done      = Wait;
    assign counting  = Count;
    assign shift_ena = B0 | B1 | B2 | B3;

endmodule
