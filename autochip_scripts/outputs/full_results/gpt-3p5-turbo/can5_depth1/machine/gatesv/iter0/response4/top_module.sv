module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:0] out_any,
	output [3:0] out_different
);

	// Assign the output for the bitwise AND operation (out_both)
	assign out_both = in[2:0] & in[3:1];
	
	// Assign the output for the bitwise OR operation (out_any)
	assign out_any = in[2:0] | in[3:1];
	
	// Assign the output for the bitwise XOR operation (out_different)
	assign out_different = in ^ {in[3:1], in[0]};
	
endmodule
