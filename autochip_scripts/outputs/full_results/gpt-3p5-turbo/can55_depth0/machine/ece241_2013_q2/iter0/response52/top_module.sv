module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

	// Intermediate wires
	wire sop_w1, sop_w2, sop_w3, sop_w4;
	wire pos_w1, pos_w2, pos_w3;
	wire pos0, pos1;

	// SOP expression
	assign sop_w1 = ~(a & b & c);
	assign sop_w2 = c & d;
	assign sop_w3 = sop_w1 | sop_w2;
	assign sop_w4 = sop_w3;

	// POS expression
	assign pos_w1 = c & (~b | d) & (~a | b);
	assign pos_w2 = c & (~a | d);
	assign pos_w3 = (pos0 == pos1) ? pos0 : 1'bx;

	// Output assignments
	assign out_sop = sop_w4;
	assign out_pos = pos_w3;

endmodule
