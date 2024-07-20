module top_module (
	input in,
	input [3:0] state,
	output [3:0] next_state,
	output out
);

	// Assign values to the next_state[A] port
	assign next_state[0] = (in == 1'b0) ? (state[0] | state[2]) : 4'b0000;

	// Assign values to the next_state[B] port
	assign next_state[1] = (in == 1'b0) ? 4'b0000 : (state[0] | state[1] | state[3]);

	// Assign values to the next_state[C] port
	assign next_state[2] = (in == 1'b0) ? (state[1] | state[3]) : 4'b0000;

	// Assign values to the next_state[D] port
	assign next_state[3] = (in == 1'b0) ? 4'b0000 : state[2];

	// Assign values to the out port
	assign out = state[3];

endmodule
