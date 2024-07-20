module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);
	// Minimum Sum-of-Products (SOP) form for generating output
	assign out_sop = (~a & ~b &  c &  d) | // 2
	                 ( a &  b &  c & ~d) | // 7
	                 ( a &  b &  c &  d);  // 15

	// Minimum Product-of-Sums (POS) form for generating output
	assign out_pos = (a | ~c | ~d) &      // 7,15
	                 (~b | ~c | ~d);      // 2
endmodule
