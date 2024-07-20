module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:1] out_any,
	output [3:0] out_different
);
	/* Declaration of intermediate signals */
	wire [2:0] in_bits_0_to_2;
	wire [3:1] in_bits_1_to_3;
	
	/* Extracting input bits */
	assign in_bits_0_to_2 = in[2:0];
	assign in_bits_1_to_3 = in[3:1];
	
	/* Bitwise AND operation */
	assign out_both = in_bits_0_to_2 & in_bits_1_to_3;
	
	/* Bitwise OR operation */
	assign out_any = in_bits_0_to_2 | in_bits_1_to_3;
	
	/* Bitwise XOR operation */
	assign out_different = in ^ (in_bits_1_to_3 << 1'b1);
endmodule
