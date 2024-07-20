module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

	// Calculate intermediate signals
	wire and_cd = c & d;
	wire not_a = ~a;
	wire not_b = ~b;
	wire and_nand = not_a & not_b & c;
	wire or_sop = and_cd | and_nand;
	
	// Assign SOP output
	assign out_sop = or_sop;
	
	// Calculate intermediate signals for POS
	wire pos0 = c & ((~b | d) & (~a | b));
	wire pos1 = c & ((~a | d) & (~a | b));
	
	// Assign POS output
	assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;
	
endmodule
