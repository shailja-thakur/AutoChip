module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

	// Generate SOP output
	assign out_sop = (c & d) | (~a & ~b & c);
	
	// Intermediate wires for POS calculation
	wire pos0;
	wire pos1;
	
	// Generate POS intermediate values
	assign pos0 = c & (~b | d) & (~a | b);
	assign pos1 = c & (~a | d);
	
	// Generate POS output
	assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
