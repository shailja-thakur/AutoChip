module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Output: Each bit of out_both indicates whether both the corresponding input bit and its neighbour to the left are '1'
	assign out_both[0] = in[0] & in[99];
	generate
		for (int i=1; i<99; i=i+1) 
			assign out_both[i] = in[i] & in[i-1];
	endgenerate

	// Output: Each bit of out_any indicates whether any of the corresponding input bit and its neighbour to the right are '1'
	generate
		for (int i=0; i<99; i=i+1) 
			assign out_any[i] = in[i] | in[i+1];
	endgenerate
	assign out_any[99] = in[99]; // In[99] has no neighbor to the right, so its value is assigned directly to out_any[99]

	// Output: Each bit of out_different indicates whether the corresponding input bit is different from its neighbour to the left
	generate
		for (int i=0; i<99; i=i+1) 
			assign out_different[i] = (in[i] != in[i-1]);
	endgenerate
	assign out_different[99] = (in[99] != in[0]); // Wrap around: In[99]'s neighbor to the left is in[0]

endmodule
