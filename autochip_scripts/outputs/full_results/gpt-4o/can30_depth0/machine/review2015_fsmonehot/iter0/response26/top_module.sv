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
    parameter S = 10'b0000000001,
              S1 = 10'b0000000010,
              S11 = 10'b0000000100,
              S110 = 10'b0000001000,
              B0 = 10'b0000010000,
              B1 = 10'b0000100000,
              B2 = 10'b0001000000,
              B3 = 10'b0010000000,
              Count = 10'b0100000000,
              Wait = 10'b1000000000;

    // Output done signal when in Wait state
    assign done = state[9];
    
    // Output counting signal when in Count state
    assign counting = state[8];
    
    // Output shift_enable signal when in states B0, B1, B2, B3
    assign shift_ena = state[4] | state[5] | state[6] | state[7];
    
    // Output B3_next when in B2 state
    assign B3_next = state[6];
    
    // Output S_next
    assign S_next = (state[0] & ~d) |
                    (state[1] & ~d) |
                    (state[3] & ~d) |
                    (state[9] & ack);
    
    // Output S1_next when in S state and d is 1
    assign S1_next = state[0] & d;
    
    // Output Count_next
    assign Count_next = state[7] |
                        (state[8] & ~done_counting);
    
    // Output Wait_next
    assign Wait_next = (state[8] & done_counting) |
                       (state[9] & ~ack);

endmodule
