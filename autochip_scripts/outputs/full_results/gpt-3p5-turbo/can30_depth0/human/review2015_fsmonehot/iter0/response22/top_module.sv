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
  assign B3_next = state[9] & shift_ena;
  assign S_next = (state[0]) & (d == 0) & (done_counting == 0);
  assign S1_next = (state[1]) & (d == 1);
  assign Count_next = state[7] & counting & (done_counting == 0);
  assign Wait_next = state[8] & done & (ack == 0);

  // Output logic
  assign done = state[8] & (ack == 1);
  assign counting = state[6] | state[7] | state[8];
  assign shift_ena = (state[4] | state[5] | state[6] | state[7] | state[8] | state[9]);

endmodule
