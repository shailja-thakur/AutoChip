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
    localparam S      = 10'b0000000001;
    localparam S1     = 10'b0000000010;
    localparam S11    = 10'b0000000100;
    localparam S110   = 10'b0000001000;
    localparam B0     = 10'b0000010000;
    localparam B1     = 10'b0000100000;
    localparam B2     = 10'b0001000000;
    localparam B3     = 10'b0010000000;
    localparam Count  = 10'b0100000000;
    localparam Wait   = 10'b1000000000;

    assign done = state[9] == 1;                      // Wait state
    assign counting = state[8] == 1;                  // Count state
    assign shift_ena = (state[7:4] != 4'b0000);       // Any of B0, B1, B2, B3 states

    assign B3_next   = state[6] == 1;                 // B2 state
    assign S_next    = (state[0] & ~d) | 
                       (state[1] & ~d) |
                       (state[3] & ~d) |
                       (state[9] & ack);              // S, S1, S110, Wait states
    assign S1_next   = state[0] & d;                  // S state
    assign Count_next = state[7] == 1 | 
                        (state[8] & ~done_counting);  // B3 state or (Count state and ~done_counting)
    assign Wait_next  = (state[8] & done_counting) |
                        (state[9] & ~ack);            // Count state and done_counting or (Wait state and ~ack)

endmodule
