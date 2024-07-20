module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

	// Minimum Sum-Of-Products (SOP) for out_sop
	assign out_sop = (~a & ~b & c & ~d) |   // 2: 0010
	                 (a & b & c & ~d)  |   // 7: 0111
	                 (a & b & c & d);      // 15: 1111

	// Minimum Product-Of-Sums (POS) for out_pos
	assign out_pos = (a | b | ~c | d) &     // cover all cases except (2, 7, 15)
	                 (a | ~b | ~c | ~d) &
	                 (~a | ~b | c | ~d);

endmodule
