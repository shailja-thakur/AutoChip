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
  assign B3_next = state[9] & state[8] & state[7] & state[6] & state[5] & state[4] & state[3] & state[2] & state[1] & ~state[0];
  assign S_next = ~d & state[2];
  assign S1_next = d & ~state[3];
  assign Count_next = state[7] & done_counting;
  assign Wait_next = state[7] & ~done_counting;

  // Output logic
  assign shift_ena = state[5] | state[6] | state[7] | state[8] | state[9];
  assign counting = state[7];
  assign done = state[9] & ack;

endmodule
