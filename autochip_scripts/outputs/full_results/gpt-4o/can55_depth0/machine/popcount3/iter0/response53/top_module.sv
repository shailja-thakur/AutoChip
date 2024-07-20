module top_module (
	input [2:0] in,
	output [1:0] out
);

	// Add the three input bits and assign the result to out
	assign out = in[0] + in[1] + in[2];

endmodule
