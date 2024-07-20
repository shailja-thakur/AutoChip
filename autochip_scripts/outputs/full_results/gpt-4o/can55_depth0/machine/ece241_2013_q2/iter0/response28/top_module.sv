module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);
	// Sum-of-Products (SOP) expression
	wire sop_and1 = c & d;
	wire sop_and2 = ~a & ~b & c;
	assign out_sop = sop_and1 | sop_and2;

	// Product-of-Sums (POS) expression
	wire pos0 = (c & (~b | d) & (~a | b));
	wire pos1 = (c & (~b | d) & (~a | d));
	assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;
endmodule
