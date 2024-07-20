module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:1] out_any,
	output [3:0] out_different
);

	// Define intermediate wire vectors
	wire w1, w2, w3;

	// Determine if both input bit and its left neighbour are '1'
	assign w1 = in[2] & in[3];
	assign w2 = in[1] & in[2];
	assign w3 = in[0] & in[1];

	// Assign values to out_both
	assign out_both[2] = w1;
	assign out_both[1] = w2;
	assign out_both[0] = w3;

	// Determine if any of the input bit and its right neighbour are '1'
	assign w1 = in[2] | in[1];
	assign w2 = in[1] | in[0];
	assign w3 = in[0] | in[3];

	// Assign values to out_any
	assign out_any[2] = w1;
	assign out_any[1] = w2;
	assign out_any[0] = w3;

	// Determine if input bit is different from its left neighbour (wrapping around)
	assign w1 = in[2] ^ in[3];
	assign w2 = in[1] ^ in[2];
	assign w3 = in[0] ^ in[3];

	// Assign values to out_different
	assign out_different[2] = w1;
	assign out_different[1] = w2;
	assign out_different[0] = w3;

endmodule
