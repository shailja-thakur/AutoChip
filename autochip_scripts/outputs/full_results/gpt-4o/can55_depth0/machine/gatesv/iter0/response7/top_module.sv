module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:0] out_any,
	output [3:0] out_different
);

	assign out_both = in[2:0] & in[3:1]; // Bitwise AND of bits 2:0 and 3:1
	assign out_any = in[2:0] | in[3:1];  // Bitwise OR of bits 2:0 and 3:1
	assign out_different = in ^ {in[2:0], in[0]}; // Bitwise XOR of in and in[3:1], in[0]

endmodule
