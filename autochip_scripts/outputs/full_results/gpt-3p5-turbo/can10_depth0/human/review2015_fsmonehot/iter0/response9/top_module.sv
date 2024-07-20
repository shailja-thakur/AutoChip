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

    assign B3_next = (state[9] & state[8] & ~d) | (state[9] & ~state[8] & state[7] & d) | (state[9] & ~state[8] & ~state[7] & d);
    assign S_next = (~state[9] & ~state[8] & ~state[7] & ~state[6] & ~state[5] & d) | (state[9] & ~state[8] & ~state[7] & state[6] & state[5] & d);
    assign S1_next = (~state[9] & ~state[8] & ~state[7] & state[6] & ~state[5] & d) | (state[9] & ~state[8] & ~state[7] & state[6] & state[5] & d);
    assign Count_next = (state[9] & state[8] & ~state[7] & ~state[6] & ~state[5] & d) | (state[9] & state[8] & state[7] & ~state[6] & ~state[5] & d);
    assign Wait_next = (state[9] & state[8] & state[7] & ~state[6] & ~state[5] & d) | (state[9] & state[8] & state[7] & ~state[6] & state[5] & d);
    
    assign done = state[8] & state[7] & ~state[6] & state[5] & state[4] & state[3] & state[2] & state[1] & state[0] & ~done_counting & ~ack;
    assign counting = state[6] & ~state[5] & ~state[4] & ~state[3] & ~state[2] & ~state[1] & ~state[0] & ~done_counting;
    assign shift_ena = state[5];
 
endmodule
