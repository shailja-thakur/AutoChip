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
assign B3_next = (state[3] == 1'b1); // Output is 1 when state B2 is active
assign S_next = ((state[0] && !d) || (state[1] && !d) || (state[2] && !d) || (state[9] && ack)); // Output is 1 when state S and d is 0, or state S1 and d is 0, or state S110 and d is 0, or state Wait and ack is 1
assign S1_next = (state[1] && d); // Output is 1 when state S and d is 1
assign Count_next = ((state[3] == 1'b1) || (state[8] && !done_counting)); // Output is 1 when state B3 is active, or state Count and done_counting is 0
assign Wait_next = ((state[8] && done_counting) || (state[9] && !ack)); // Output is 1 when state Count and done_counting is 1, or state Wait and ack is 0
assign done = (state[9] == 1'b1); // Done signal is 1 in state Wait
assign counting = (state[8] == 1'b1); // Counting signal is 1 in state Count
assign shift_ena = (state[4] || state[5] || state[6] || state[7]); // Shift enable signal is 1 if any of the states B3, B2, B1 and B0 is active

endmodule
