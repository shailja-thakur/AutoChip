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

// Assign the outputs based on the current state
assign B3_next = (state[4] == 1'b1); // B2 state
assign S_next = ((state[0] == 1'b1 && d == 1'b0) ||
                (state[1] == 1'b1 && d == 1'b0) ||
                (state[2] == 1'b1 && d == 1'b0) ||
                (state[9] == 1'b1 && ack == 1'b1));
assign S1_next = (state[0] == 1'b1 && d == 1'b1);
assign Count_next = ((state[3] == 1'b1) || 
                    (state[8] == 1'b1 && done_counting == 1'b0));
assign Wait_next = ((state[8] == 1'b1 && done_counting == 1'b1) ||
                   (state[9] == 1'b1 && ack == 1'b0));
assign done = (state[9] == 1'b1); // Wait state
assign counting = (state[8] == 1'b1); // Count state
assign shift_ena = (state[3] == 1'b1 || state[2] == 1'b1 || state[1] == 1'b1 || state[0] == 1'b1); // B3, B2, B1, B0 states

endmodule
