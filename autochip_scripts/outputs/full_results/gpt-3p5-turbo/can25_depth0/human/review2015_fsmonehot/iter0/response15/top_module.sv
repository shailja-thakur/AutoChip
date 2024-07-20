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

    // State transition logic equations
    assign B3_next = (state == 10'b0111111111);
    assign S_next = (state[0] & ~d) | (state[1] & d);
    assign S1_next = (state[0] & ~d) | (state[1] & d);
    assign Count_next = (state == 10'b1000000000) | ((state[0] & ~done_counting) & state[8:0]);
    assign Wait_next = (state == 10'b1000000000) | (state[9] & done);
    
    // Output logic equations
    assign done = state[9] & ~state[8];
    assign counting = state[8];
    assign shift_ena = (state[0] & state[1] & state[2] & state[3] & ~state[4] & ~state[5] & ~state[6] & ~state[7] & ~state[8] & ~state[9]);

endmodule
