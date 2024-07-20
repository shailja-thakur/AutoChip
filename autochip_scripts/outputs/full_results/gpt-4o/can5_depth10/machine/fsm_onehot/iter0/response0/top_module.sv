module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2
);
    
    // Assign outputs out1 and out2 based on the given conditions
    assign out1 = state[8] | state[9];
    assign out2 = state[7] | state[9];

    // Assign next_state[0] based on the given condition
    assign next_state[0] = ~in & (state[4] | state[3] | state[2] | state[1] | state[0] | state[7] | state[8] | state[9]);

    // Assign next_state[1] based on the given condition
    assign next_state[1] = in & (state[0] | state[8] | state[9]);

    // Assign next_state[2] based on the given condition
    assign next_state[2] = in & state[1];

    // Assign next_state[3] based on the given condition
    assign next_state[3] = in & state[2];

    // Assign next_state[4] based on the given condition
    assign next_state[4] = in & state[3];

    // Assign next_state[5] based on the given condition
    assign next_state[5] = in & state[4];

    // Assign next_state[6] based on the given condition
    assign next_state[6] = in & state[5];

    // Assign next_state[7] based on the given condition
    assign next_state[7] = in & (state[6] | state[7]);

    // Assign next_state[8] based on the given condition
    assign next_state[8] = ~in & state[5];

    // Assign next_state[9] based on the given condition
    assign next_state[9] = ~in & state[6];

endmodule
