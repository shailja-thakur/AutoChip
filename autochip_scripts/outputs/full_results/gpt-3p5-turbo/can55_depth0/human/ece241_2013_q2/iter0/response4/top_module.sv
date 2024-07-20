module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

	//The output out_sop is 1 when the input is 2, 7 or 15
	assign out_sop = (a & ~b & c & d) | (~a & b & ~c & ~d) | (a & ~b & ~c & ~d);

	//The output out_pos is 0 when the input is 0, 1, 4, 5, 6, 9, 10, 13 or 14
	assign out_pos = (~a & ~b & c & ~d) & (~a & b & c & ~d) & (~a & ~b & ~c & ~d) & (~a & b & ~c & d) & (~a & b & c & d) & (a & b & c & ~d) & (a & ~b & c & ~d) & (a & ~b & ~c & d) & (a & b & ~c & ~d);

endmodule
