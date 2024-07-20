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
 
 // State transition logic
 assign B3_next = state[9] & (shift_ena || ~ack);
 assign S_next  = state[8] & ~d;
 assign S1_next = state[7] & d;
 assign Count_next = state[6] & counting;
 assign Wait_next = state[5] & done;
 
 // Output logic
 assign done = state[5] & ack;
 assign counting = state[6] & ~done_counting;
 assign shift_ena = state[9] & (~d | state[8]);
endmodule
