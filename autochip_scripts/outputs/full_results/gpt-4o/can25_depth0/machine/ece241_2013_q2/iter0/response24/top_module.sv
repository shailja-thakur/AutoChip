module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

	// SOP expression
	assign out_sop = (c & d) | (~a & ~b & c);

	// Calculate intermediate signals for POS expression
	wire pos0, pos1;
	assign pos0 = c & (~b | d) & (~a | b);
	assign pos1 = c & (~b | d) & (~a | d);

	// POS expression with ternary condition
	assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
