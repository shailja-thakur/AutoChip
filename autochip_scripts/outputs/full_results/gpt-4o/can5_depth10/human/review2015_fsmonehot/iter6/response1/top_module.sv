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
    localparam [9:0] S = 10'b0000000001;
    localparam [9:0] S1 = 10'b0000000010;
    localparam [9:0] S11 = 10'b0000000100;
    localparam [9:0] S110 = 10'b0000001000;
    localparam [9:0] B0 = 10'b0000010000;
    localparam [9:0] B1 = 10'b0000100000;
    localparam [9:0] B2 = 10'b0001000000;
    localparam [9:0] B3 = 10'b0010000000;
    localparam [9:0] Count = 10'b0100000000;
    localparam [9:0] Wait = 10'b1000000000;

    // Next-State Logic
    assign S_next = (state[S[9:0]] & ~d) | (state[S1[9:0]] & ~d) | (state[S110[9:0]] & ~d) | (state[Wait[9:0]] & ack);
    assign S1_next = (state[S[9:0]] & d) | (state[S1[9:0]] & d) | (state[S11[9:0]] & d);
    assign B3_next = state[B2[9:0]];
    assign Count_next = state[B3[9:0]];
    assign Wait_next = (state[Count[9:0]] & done_counting) | (state[Wait[9:0]] & ~ack);

    // Transition for state S110
    wire S110_next = (state[S11[9:0]] & ~d) | (state[S110[9:0]] & d);

    // Transition for state B0
    wire B0_next = (state[S110[9:0]] & d) | state[B0[9:0]];

    // Transition for state B1
    wire B1_next = state[B0[9:0]];

    // Transition for state B2
    wire B2_next = state[B1[9:0]];

    // Output logic
    assign done = state[Wait[9:0]];
    assign counting = state[Count[9:0]];
    assign shift_ena = state[B0[9:0]] | state[B1[9:0]] | state[B2[9:0]] | state[B3[9:0]];

endmodule
