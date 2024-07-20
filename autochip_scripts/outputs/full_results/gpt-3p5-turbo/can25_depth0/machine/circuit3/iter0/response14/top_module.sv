module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	// Declare intermediate signals
	wire ab, cd;

	// Implement OR gates
	or(ab, a, b);
	or(cd, c, d);

	// Implement AND gate
	and(q, ab, cd);
endmodule
