module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);
	// Implement the correct truth table using assign statements
	assign out = ~(a & c & d) | (a & b & ~c) | (a & d);
endmodule
