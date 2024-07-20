module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

	// Generate out_sop using the described Sum-of-Products (SOP) expression
	assign out_sop = (c & d) | (~a & ~b & c);
	
	// Wires for intermediate expressions
	wire pos0, pos1;
	
	// Generate pos0 and pos1 using the described Product-of-Sums (POS) expressions
	assign pos0 = (c & ((~b | d) & (~a | b)));
	assign pos1 = (c & ((~b | d) & (~a | d)));
	
	// Generate out_pos based on the described condition
	assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
