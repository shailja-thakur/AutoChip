module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

	// Calculate out_sop as Sum-of-Products (SOP)
	wire and1, and2, not_a, not_b;
	assign not_a = ~a;
	assign not_b = ~b;
	assign and1 = c & d;
	assign and2 = not_a & not_b & c;
	assign out_sop = and1 | and2;

	// Calculate intermediate values for out_pos as Product-of-Sums (POS)
	wire pos0, pos1, or1, or2, or3, not_c, not_d;
	assign not_c = ~c;
	assign not_d = ~d;
	assign or1 = not_b | d;
	assign or2 = not_a | b;
	assign or3 = not_a | d;
	assign pos0 = c & or1 & or2;
	assign pos1 = c & or1 & or3;

	// Calculate out_pos using a ternary expression
	assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
