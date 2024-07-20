module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:0] out_any,
	output [3:0] out_different
);

	// Assign out_both to the bitwise AND operation between bits 2-0 and bits 3-1 of the input
	assign out_both = in[2:0] & in[3:1];

	// Assign out_any to the bitwise OR operation between bits 2-0 and bits 3-1 of the input
	assign out_any = in[2:0] | in[3:1];

	// XOR operation with exception of bit 0
	assign out_different = in ^ in[3:1];

endmodule
