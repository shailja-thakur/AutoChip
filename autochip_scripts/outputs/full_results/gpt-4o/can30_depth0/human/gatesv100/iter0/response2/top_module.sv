module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);
	
	// out_both logic: Each bit indicates if both the corresponding input bit and its neighbor to the left are '1'.
	assign out_both = in[99:1] & in[98:0];

	// out_any logic: Each bit indicates if any of the corresponding input bit and its neighbor to the right are '1'.
	assign out_any = in[99:1] | in[98:0];

	// out_different logic: Each bit indicates if the corresponding input bit is different from its neighbor to the left.
	assign out_different[99:1] = in[99:1] ^ in[98:0];
	assign out_different[0] = in[0] ^ in[99]; // Handle wrap-around for in[99] and in[0]

endmodule
