module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

// Truth table: out_sop = SOP(a,b,c,d) and out_pos = POS(a,b,c,d)
// 2 = 0 0 1 0, 7 = 0 1 1 1, 15 = 1 1 1 1
// 0 = 0 0 0 0, 1 = 0 0 0 1, 4 = 0 1 0 0, 5 = 0 1 0 1, 6 = 0 1 1 0, 9 = 1 0 0 1, 10 = 1 0 1 0, 13 = 1 1 0 1, 14 = 1 1 1 0

and #(4) u1 (out_sop, a, b, c, d);
or #(4) u2 (out_pos, a, b, c, d);

endmodule
