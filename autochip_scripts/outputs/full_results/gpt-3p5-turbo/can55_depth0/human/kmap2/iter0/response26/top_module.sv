module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

	// Intermediate signals
	wire ab, cd;
	
	// Gate-level implementation
	assign ab = a & b;
	assign cd = c & d;
	assign out = (ab & ~cd) | (ab & cd) | (ab & cd) | (a & ~b & c & ~d) | (~a & ~b & c & d);
endmodule
