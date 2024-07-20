module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:1] out_any,
	output [3:0] out_different
);

	// Declare internal wires for intermediate signals
	wire [3:0] in_wrapped;
	wire [2:0] in_left;
	wire [3:1] in_right;

	// Create the wrapped input vector
	assign in_wrapped = {in[2:0], in[3]};

	// Create the left shifted input vector
	assign in_left = {in[1:0], in[3]};

	// Create the right shifted input vector
	assign in_right = {in[2:0], in[0]};

	// Calculate out_both
	assign out_both[0] = in[0] & in_wrapped[0];
	assign out_both[1] = in[1] & in_left[1];
	assign out_both[2] = in[2] & in_left[2];

	// Calculate out_any
	assign out_any[1] = in[1] | in_right[1];
	assign out_any[2] = in[2] | in_right[2];
	assign out_any[3] = in[3] | in_right[3];

	// Calculate out_different
	assign out_different[0] = in[0] ^ in_wrapped[0];
	assign out_different[1] = in[1] ^ in_left[1];
	assign out_different[2] = in[2] ^ in_left[2];
	assign out_different[3] = in[3] ^ in_right[3];

endmodule
