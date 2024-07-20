module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Intermediate wire variables
	wire [99:0] in_wrapped;
	wire [99:0] in_left;
	wire [99:0] in_right;

	// Wrap around input vector
	assign in_wrapped = {in[0], in};

	// Calculate out_both
	assign out_both = in_wrapped[98:0] & in_wrapped[99:1];

	// Calculate out_any
	assign out_any = in | in_left;

	// Calculate out_different
	assign in_left = {in_wrapped[99], in_wrapped[99:1]}; // Shift input vector by 1 to the left
	assign out_different = in ^ in_left;

endmodule
