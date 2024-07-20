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

// Assign the output signals based on the current state
assign B3_next = (state[3] == 1'b1); // B2 is active
assign S_next = ((state[0] == 1'b1 && d == 1'b0) || // S and d is 0
                 (state[1] == 1'b1 && d == 1'b0) || // S1 and d is 0
                 (state[2] == 1'b1 && d == 1'b0) || // S110 and d is 0
                 (state[9] == 1'b1 && ack == 1'b1)); // Wait and ack is 1
assign S1_next = (state[0] == 1'b1 && d == 1'b1); // S and d is 1
assign Count_next = ((state[3] == 1'b1) || // B3 is active
                    (state[8] == 1'b1 && done_counting == 1'b0)); // Count and done_counting is 0
assign Wait_next = ((state[8] == 1'b1 && done_counting == 1'b1) || // Count and done_counting is 1
                   (state[9] == 1'b1 && ack == 1'b0)); // Wait and ack is 0
assign done = (state[9] == 1'b1); // Wait state is active
assign counting = (state[8] == 1'b1); // Count state is active
assign shift_ena = (state[7] == 1'b1 || // B3 is active
                   state[6] == 1'b1 || // B2 is active
                   state[5] == 1'b1 || // B1 is active
                   state[4] == 1'b1); // B0 is active

endmodule
