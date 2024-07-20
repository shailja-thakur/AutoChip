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
    assign done = (state[9] == 1'b1); // state is Wait
    assign counting = (state[8] == 1'b1); // state is Count
    assign shift_ena = (state[7] == 1'b1 || state[6] == 1'b1 || state[5] == 1'b1 || state[4] == 1'b1); // state is B3, B2, B1 or B0

    assign B3_next = (state[6] == 1'b1); // state is B2
    assign S_next = ((state[0] == 1'b1 && d == 1'b0) || (state[1] == 1'b1 && d == 1'b0) || (state[2] == 1'b1 && d == 1'b0) || (state[9] == 1'b1 && ack == 1'b1)); // state is S, S1, S110 or Wait
    assign S1_next = (state[0] == 1'b1 && d == 1'b1); // state is S
    assign Count_next = ((state[7] == 1'b1) || (state[8] == 1'b1 && done_counting == 1'b0)); // state is B3 or Count
    assign Wait_next = ((state[8] == 1'b1 && done_counting == 1'b1) || (state[9] == 1'b1 && ack == 1'b0)); // state is Count or Wait

endmodule
