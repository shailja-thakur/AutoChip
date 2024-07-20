module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

	wire not_a, not_b;
	wire sop0, sop1, pos0, pos1;

	// Calculate NOT of a and b
	assign not_a = ~a;
	assign not_b = ~b;

	// SOP Expression
	assign sop0 = c & d;
	assign sop1 = not_a & not_b & c;
	assign out_sop = sop0 | sop1;

	// POS Expression
	assign pos0 = c & (not_b | d) & (not_a | b);
	assign pos1 = c & (not_a | d) & (not_b | d);
	assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
