module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

	// Minimum Sum-of-Products (SOP) form
	assign out_sop = (~a & ~b & c & ~d) |   // for input 2   (0010)
	                 (~a & b & c & d)   |   // for input 7   (0111)
	                 (a & b & c & d);       // for input 15  (1111)

	// Minimum Product-of-Sums (POS) form
	assign out_pos = (a | b | ~c | d) &     // !(0,0,1,0) == (1,1,0,1)
	                 (a | ~b | ~c | ~d) &   // !(0,1,1,1) == (1,0,0,0)
	                 (~a | ~b | ~c | ~d);   // !(1,1,1,1) == (0,0,0,0)
	
endmodule
