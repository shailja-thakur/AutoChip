module top (
	input [2:0] in,
	output [1:0] out
);

	// Logic to calculate the sum of the input bits
	assign out[0] = in[0] ^ in[1] ^ in[2];
	assign out[1] = (in[0] & in[1]) | (in[0] & in[2]) | (in[1] & in[2]);

endmodule
