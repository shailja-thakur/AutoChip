module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);
	
	// Bit-wise AND operation to generate out_both
	assign out_both = in[98:0] & in[99:1];
	
	// Bit-wise OR operation to generate out_any
	assign out_any = in[99:0] | in[99:1];
	
	// Bit-wise XOR operation to generate out_different
	assign out_different = {in[0] ^ in[99], in[99:1] ^ in[98:0]};
	
endmodule
