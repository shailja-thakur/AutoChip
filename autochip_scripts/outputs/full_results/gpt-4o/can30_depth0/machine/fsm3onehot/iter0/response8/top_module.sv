module top_module (
	input in,
	input [3:0] state,
	output [3:0] next_state,
	output out
);

	// Assign the first statement
	assign next_state[0] = in ? 1'b0 : (state[0] | state[2]);

	// Assign the second statement
	assign next_state[1] = in ? (state[0] | state[1] | state[3]) : 1'b0;

	// Assign the third statement
	assign next_state[2] = in ? 1'b0 : (state[1] | state[3]);

	// Assign the forth statement
	assign next_state[3] = in ? state[2] : 1'b0;

	// Assign the out port
	assign out = state[3];

endmodule
