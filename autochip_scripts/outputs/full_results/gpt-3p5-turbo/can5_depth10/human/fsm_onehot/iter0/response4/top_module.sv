module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);

	// Output wires
	wire [9:0] next_state;
	wire out1;
	wire out2;

	// State transition logic
	assign next_state[0] = state[0] & ~in;
	assign next_state[1] = state[0] & in;
	assign next_state[2] = state[1] & ~in;
	assign next_state[3] = state[1] & in;
	assign next_state[4] = state[2] & ~in;
	assign next_state[5] = state[2] & in;
	assign next_state[6] = state[3] & ~in;
	assign next_state[7] = state[3] & in;
	assign next_state[8] = state[4] & ~in | state[5] & in;
	assign next_state[9] = state[4] & in | state[5] & ~in;

	// Output logic
	assign out1 = state[7] & ~in;
	assign out2 = state[9] & state[8] & ~in;

endmodule
