module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);
	
	assign out_and = &in;
	assign out_or = |in;
	
	// XOR gate implementation
	assign out_xor = in[0]; // Initialize with the first input
	generate
		for (i=1; i<100; i=i+1) begin: XOR_LOOP
			assign out_xor = out_xor ^ in[i];
		end
	endgenerate
	
endmodule
