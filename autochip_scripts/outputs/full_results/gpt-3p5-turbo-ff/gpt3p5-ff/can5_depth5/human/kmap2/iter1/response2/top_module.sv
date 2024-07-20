module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);
	// Implement the truth table using assign statements
	assign out = (~a & b & d) | (a & ~b & d) | (~a & b & ~c) | (a & b & c);

endmodule
