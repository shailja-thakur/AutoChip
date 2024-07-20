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
  assign B3_next = (state[9] == 1) ? 1'b1 : 1'b0;
  assign S_next = (state[8] == 1 && d == 0) ? 1'b1 :
                   (state[8] == 1 && d == 1) ? 1'b0 :
                   (state[7] == 1 && d == 1) ? 1'b1 :
                   (state[7] == 1) ? 1'b0 :
                   (state[6] == 1 && d == 0) ? 1'b1 :
                   (state[6] == 1 && d == 1) ? 1'b0 :
                   (state[5] == 1 && d == 0) ? 1'b1 :
                   (state[5] == 1 && d == 1) ? 1'b0 : 1'b0;
  assign S1_next = (state[8] == 1 && d == 1) ? 1'b1 :
                    (state[8] == 1 && d == 0) ? 1'b0 :
                    (state[7] == 1 && d == 0) ? 1'b1 :
                    (state[7] == 1 && d == 1) ? 1'b0 : 1'b0;
  assign Count_next = (state[5] == 1 && counting == 1 && done_counting == 0) ? 1'b1 :
                       (state[5] == 1 && counting == 1 && done_counting == 1) ? 1'b0 : 1'b0;
  assign Wait_next = (state[5] == 1 && counting == 1 && done == 1 && ack == 0) ? 1'b1 :
                      (state[5] == 1 && counting == 1 && done == 1 && ack == 1) ? 1'b0 : 1'b0;

  // Output logic
  assign done = (state[9] == 1) ? 1'b1 : 1'b0;
  assign counting = (state[5] == 1 && counting == 1) ? 1'b1 : 1'b0;
  assign shift_ena = (state[6] == 1 || state[7] == 1 || state[8] == 1 || state[9] == 1) ? 1'b1 : 1'b0;

endmodule
