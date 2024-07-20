module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:0] out_any,
	output [3:0] out_different
);

	// Bitwise AND operation between in[2:0] and in[3:1]
	assign out_both = in[2:0] & in[3:1];

	// Bitwise OR operation between in[2:0] and in[3:1]
	assign out_any = in[2:0] | in[3:1];

	// Bitwise XOR operation between in and in[3:0] shifted right by 1 with in[0] as an exception
	assign out_different = in ^ {in[3:1], in[0]};

endmodule
