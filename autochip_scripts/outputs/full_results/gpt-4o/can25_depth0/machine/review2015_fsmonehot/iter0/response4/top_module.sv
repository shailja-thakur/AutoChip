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
    localparam S = 10'b0000000001;
    localparam S1 = 10'b0000000010;
    localparam S11 = 10'b0000000100;
    localparam S110 = 10'b0000001000;
    localparam B0 = 10'b0000010000;
    localparam B1 = 10'b0000100000;
    localparam B2 = 10'b0001000000;
    localparam B3 = 10'b0010000000;
    localparam Count = 10'b0100000000;
    localparam Wait = 10'b1000000000;
    
    // Output logic
    assign done = state[9];  // done signal is 1 in the state Wait
    assign counting = state[8];  // counting signal is 1 in the state Count
    assign shift_ena = state[3] | state[4] | state[5] | state[6];  // shift_ena is 1 if any of the states B3, B2, B1 and B0 is active

    assign B3_next = state[6];  // B2 is active
    assign S_next = (state[0] & ~d) | (state[1] & ~d) | (state[3] & ~d) | (state[9] & ack);  // S or S1 or S110 or Wait states with given conditions
    assign S1_next = state[0] & d;  // S state and d is 1
    assign Count_next = state[6] | (state[8] & ~done_counting);  // B3 state or Count and done_counting is 0
    assign Wait_next = (state[8] & done_counting) | (state[9] & ~ack);  // Count and done_counting is 1, or Wait and ack is 0

endmodule
