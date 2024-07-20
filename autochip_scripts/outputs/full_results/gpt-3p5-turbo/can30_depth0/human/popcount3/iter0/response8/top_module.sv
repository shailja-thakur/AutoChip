module top_module (
	input [2:0] in,
	output [1:0] out
);

	// Intermediate wires to count number of '1's
	wire w1, w2;
	
	// Population count logic for 3-bit input vector
	assign w1 = in[0] & in[1];
	assign w2 = w1 & in[2];
	assign out[0] = w1 ^ in[2];
	assign out[1] = w1 & in[2];

endmodule
