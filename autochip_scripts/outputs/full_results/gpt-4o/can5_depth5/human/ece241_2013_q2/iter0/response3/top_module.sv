module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

    // Minimum Sum-Of-Products (SOP) form
    assign out_sop = (~a & ~b & c & d) |  // 7  -> 0111
                     ( a & b & c & d)  |  // 15 -> 1111
                     (~a & b & ~c & b);   // 2  -> 0010

    // Minimum Product-Of-Sums (POS) form
    assign out_pos = (a |  b |  c | ~d) &  // 0, 1,  4, 5, 6, 9, 10, 13, 14 cases
                     (a |  b | ~c |  d) & 
                     (a | ~b | ~c | ~d) &
			         (~a |  b | ~c | ~d) &
			         (~a | ~b |  c |  d);

endmodule
