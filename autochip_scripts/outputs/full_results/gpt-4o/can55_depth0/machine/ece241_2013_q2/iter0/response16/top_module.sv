module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);
	// Wire declarations
	wire sop_part1, sop_part2;
	wire pos0, pos1;

	// SOP calculation
	assign sop_part1 = c & d;
	assign sop_part2 = ~a & ~b & c;
	assign out_sop = sop_part1 | sop_part2;

	// POS calculation
	assign pos0 = c & (~b | d) & (~a | b);
	assign pos1 = c & (~b | d) & (~a | d);
	assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
