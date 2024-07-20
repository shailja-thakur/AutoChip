module top_module (
	input [2:0] in,
	output [1:0] out
);
	// Calculate the sum of the three input bits and assign it to the output
	assign out = in[2] + in[1] + in[0];
endmodule
