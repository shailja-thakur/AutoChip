module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Declare intermediate signal
	wire [99:0] in_shifted;

	// Create the shifted input
	assign in_shifted = {in[0], in[99:1]}; // Modified this line

	// Compute out_both
	assign out_both = in[98:0] & in_shifted[98:0];

	// Compute out_any
	assign out_any = in_shifted[99:0] | in[0]; // Modified this line

	// Compute out_different
	assign out_different = in ^ in_shifted;

endmodule
