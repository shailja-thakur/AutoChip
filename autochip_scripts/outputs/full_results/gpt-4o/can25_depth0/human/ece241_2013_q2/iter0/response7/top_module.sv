module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

	// Sum of Products (SOP) form for output out_sop
	assign out_sop = (~a & ~b & c & d)    // 2
				  | ( a & b & c & ~d)    // 7
				  | ( a & b & c & d);     // 15

	// Product of Sums (POS) form for output out_pos
	assign out_pos = ( a | b | c | d)    // 15
				  & ( a | b | ~c | d)    // 7
				  & ( a | ~b | c | d)    // 15
				  & (~a | b | c | d)     // 15
				  & (~a | ~b | ~c | d)   // 15
				  & (~a | ~b | c | ~d)   // 2
				  & (~a | b | ~c | ~d);  // 0

endmodule
