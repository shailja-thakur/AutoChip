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
    localparam S     = 10'b0000000001;
    localparam S1    = 10'b0000000010;
    localparam S11   = 10'b0000000100;
    localparam S110  = 10'b0000001000;
    localparam B0    = 10'b0000010000;
    localparam B1    = 10'b0000100000;
    localparam B2    = 10'b0001000000;
    localparam B3    = 10'b0010000000;
    localparam Count = 10'b0100000000;
    localparam Wait  = 10'b1000000000;

    // Next state logic
    assign S_next      = state[0] & ~d | state[2] & ~d | state[8] & ack; // S or S1 or Wait → S
    assign S1_next     = state[0] & d | state[1] & d;                    // S or S1 → S1
    assign S11_next    = state[1] & d | state[2] & d;                    // S1 or S11 → S11
    assign S110_next   = state[3] & d;                                   // S11 → S110
    assign B0_next     = state[3] & d;                                   // S110 → B0
    assign B1_next     = state[4];                                       // B0 → B1
    assign B2_next     = state[5];                                       // B1 → B2
    assign B3_next     = state[6];                                       // B2 → B3
    assign Count_next  = state[7];                                       // B3 → Count
    assign Count_next  = state[8] & ~done_counting;                      // Count → Count
    assign Wait_next   = state[8] & done_counting | state[9] & ~ack;    // Count → Wait or Wait → Wait
    assign S_eval_next = state[9] & ack;                                 // Wait → S

    // Output logic
    assign shift_ena = state[4] | state[5] | state[6] | state[7];  // B0, B1, B2, B3 states
    assign counting  = state[8];                                    // Count state
    assign done      = state[9];                                    // Wait state

endmodule
