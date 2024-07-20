module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);
	
	// Implementing the truth table
	assign out = (a & b & ~c & b) | (a & ~b & ~c & b) | (~a & b & c & b) | (a & b & ~c & ~b);
		
endmodule
