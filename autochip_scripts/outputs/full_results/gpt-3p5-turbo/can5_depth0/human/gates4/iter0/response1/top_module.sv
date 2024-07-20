module top_module (
	input [3:0] in,
	output reg out_and,
	output reg out_or,
	output reg out_xor
);
	// AND gate
	assign out_and = in[0] & in[1] & in[2] & in[3];

	// OR gate
	assign out_or = in[0] | in[1] | in[2] | in[3];

	// XOR gate
	assign out_xor = in[0] ^ in[1] ^ in[2] ^ in[3];

endmodule
