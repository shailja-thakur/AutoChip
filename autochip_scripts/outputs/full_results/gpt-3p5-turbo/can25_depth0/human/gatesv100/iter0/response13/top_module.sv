module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Internal wires
	wire [98:0] in_right;
	wire [98:0] in_left;
	wire [98:0] in_wrapped_left;


	// Split input into right and left shifted vectors
	assign in_right = in[98:0];
	assign in_left = in[99:1];

	// Wrap around the vector for the left shifted vector
	assign in_wrapped_left[98:0] = in[99] ? in_left : {in_left[97:0], 1'b0};


	// Calculate 'out_both'
	assign out_both = in_right & in;


	// Calculate 'out_any'
	assign out_any = {in[98], in[98:1]} | in;


	// Calculate 'out_different'
	assign out_different = in != in_wrapped_left;

endmodule
