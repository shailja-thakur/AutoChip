module top_module (
	input in,
	input [3:0] state,
	output reg [3:0] next_state,
	output out
);

	// Assign statement 1
	assign next_state[0] = (in == 1'b0) ? (state[0] || state[2]) : 1'b0;

	// Assign statement 2
	assign next_state[1] = (in == 1'b0) ? 1'b0 : (state[0] || state[1] || state[3]);

	// Assign statement 3
	assign next_state[2] = (in == 1'b0) ? (state[1] || state[3]) : 1'b0;

	// Assign statement 4
	assign next_state[3] = (in == 1'b0) ? 1'b0 : state[2];

	// Output assignment
	assign out = state[3];

endmodule
