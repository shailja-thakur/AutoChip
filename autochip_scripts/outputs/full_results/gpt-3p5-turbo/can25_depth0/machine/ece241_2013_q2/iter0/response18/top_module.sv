module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

	// Wire declarations
	wire s0, s1, p0, p1;

	// SOP expression for out_sop
	assign s0 = c & d;
	assign s1 = (~a & ~b & c);
	assign out_sop = s0 | s1;

	// POS expression for out_pos
	assign p0 = c & (~b | d) & (~a | b);
	assign p1 = c & (~a | d);
	assign out_pos = (p0 == p1) ? p0 : 1'bx;

endmodule
