module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Examine each bit and its neighbor to the left
	assign out_both[0] = in[0] & in[99];
	assign out_both[1:98] = in[1:98] & in[0:97];
	
	// Examine each bit and its neighbor to the right
	assign out_any[1:99] = in[0:98] | in[1:99];
	assign out_any[0] = in[0];
	
	// Examine each bit and its neighbor to the left, accounting for wrapping around
	assign out_different[0:97] = in[0:97] != in[1:98];
	assign out_different[98] = in[98] != in[99];
	assign out_different[99] = in[99] != in[0];

endmodule
