module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);
	// Implement truth table
	assign out = (a & b & d) | (a & ~b & d) | (~a & b & ~c & ~d) | (a & b & ~c & ~d);
endmodule
