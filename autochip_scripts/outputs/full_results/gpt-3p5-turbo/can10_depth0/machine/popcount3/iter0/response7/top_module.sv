module top (
	input [2:0] in,
	output [1:0] out
);

	// Add logic to calculate the sum of the input bits

	assign out[1] = in[2] ^ in[1] ^ in[0];
	assign out[0] = in[2] & in[1] | in[1] & in[0] | in[2] & in[0];

endmodule
