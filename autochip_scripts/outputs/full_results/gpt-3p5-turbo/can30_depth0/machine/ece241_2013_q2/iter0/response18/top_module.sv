module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

	// intermediate wires
	wire sop0, sop1, sop2, pos0, pos1;

	// SOP expression
	assign sop0 = c & d;
	assign sop1 = ~a & ~b & c;
	assign out_sop = sop0 | sop1;

	// POS expression
	assign pos0 = c & (~b | d) & (~a | b);
	assign pos1 = c & (~a | d);
	assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
