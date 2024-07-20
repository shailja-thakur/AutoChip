module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:0] out_any,
	output [3:0] out_different
);
	
	// Compute the bitwise AND for bits 2 through 0 of 'in' and bits 3 through 1 of 'in'
	assign out_both = in[2:0] & in[3:1];

	// Compute the bitwise OR for bits 2 through 0 of 'in' and bits 3 through 1 of 'in'
	assign out_any = { (in[2:0] | in[3:1]), 1'b0 };

	// Compute the bitwise XOR for the full 4-bit vector 'in' and bits 3 through 1 of 'in' with bit 0 as a special case
	assign out_different = in ^ {in[3:1], in[0]};

endmodule
