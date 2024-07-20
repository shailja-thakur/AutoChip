module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

	// Truth table for the given conditions
	// 2, 7, 15 -> logic-1
	// 0, 1, 4, 5, 6, 9, 10, 13, 14 -> logic-0
	// 3, 8, 11, 12 -> cannot occur

	// Sum-of-Products form
	assign out_sop = (a | b) & (~c) & (~d) | (~a) & (~b) & (~c) & d | (~a) & (~b) & c & (~d);

	// Product-of-Sums form
	assign out_pos = (a & b & c & d) | (a & (~b) & (~c) & d) | (a & (~b) & c & (~d));

endmodule
