module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);
	// Implement the truth table using assign statements
	assign out = ~(a & d) | (b & c & ~d) | (c & d) | (a & ~b);
endmodule
