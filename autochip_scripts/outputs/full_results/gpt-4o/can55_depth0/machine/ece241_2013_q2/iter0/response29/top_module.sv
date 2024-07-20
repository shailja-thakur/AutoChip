module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

	// SOP (Sum of Products) expression
	wire sop0 = c & d;
	wire sop1 = (~a) & (~b) & c;
	assign out_sop = sop0 | sop1;

	// POS (Product of Sums) expression
	wire pos0 = c & ((~b) | d) & ((~a) | b);
	wire pos1 = c & ((~b) | d) & ((~a) | d);
	assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
