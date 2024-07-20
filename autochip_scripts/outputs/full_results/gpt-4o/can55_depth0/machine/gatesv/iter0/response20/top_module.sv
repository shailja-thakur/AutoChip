module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:0] out_any,
	output [3:0] out_different
);
	// Bitwise AND operation: result of ANDing bits [2:0] with bits [3:1]
	assign out_both = in[2:0] & in[3:1];

	// Bitwise OR operation: result of ORing bits [2:0] with bits [3:1]
	assign out_any = in[2:0] | in[3:1];

	// Bitwise XOR operation: result of XORing the entire vector [3:0]
	assign out_different = in ^ {in[3:1], in[0]};

endmodule
