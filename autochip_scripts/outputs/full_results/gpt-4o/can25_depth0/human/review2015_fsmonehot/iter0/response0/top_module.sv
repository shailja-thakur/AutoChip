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
    parameter S     = 10'b0000000001;
    parameter S1    = 10'b0000000010;
    parameter S11   = 10'b0000000100;
    parameter S110  = 10'b0000001000;
    parameter B0    = 10'b0000010000;
    parameter B1    = 10'b0000100000;
    parameter B2    = 10'b0001000000;
    parameter B3    = 10'b0010000000;
    parameter Count = 10'b0100000000;
    parameter Wait  = 10'b1000000000;
    
    // Next state logic
    assign S_next     = state[0] & ~d | state[1] & ~d | state[8] & ack;
    assign S1_next    = state[0] & d | state[1] &  d;
    assign S11_next   = state[2] &  d | state[3] &  d;
    assign S110_next  = state[2] & ~d;
    assign B0_next    = state[3] &  d;
    assign B1_next    = state[4];
    assign B2_next    = state[5];
    assign B3_next    = state[6];
    assign Count_next = state[7];
    assign Wait_next  = state[8] & done_counting;
    
    // Output logic
    assign shift_ena = state[4] | state[5] | state[6] | state[7];
    assign counting  = state[8] & ~done_counting;
    assign done      = state[9] & ~ack;
    
endmodule
