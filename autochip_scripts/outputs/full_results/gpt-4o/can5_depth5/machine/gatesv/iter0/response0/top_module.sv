module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:0] out_any,
	output [3:0] out_different
);

	// Bitwise AND operation between bits 2:0 and 3:1 of input vector
	assign out_both = in[2:0] & in[3:1];

	// Bitwise OR operation between bits 2:0 and 3:1 of input vector
	assign out_any = {in[3:1] | in[2:0], in[0]};

	// Bitwise XOR operation between the entire input vector and shifted input vector
	assign out_different = in ^ {in[2:0], in[0]};

endmodule
