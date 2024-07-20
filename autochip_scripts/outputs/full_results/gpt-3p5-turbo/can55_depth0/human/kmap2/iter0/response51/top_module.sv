module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);
	
	// Implement the truth table specified by the Karnaugh map
	assign out = (~a & ~b & c) || (~a & b & ~d) || (b & c & d) || (a & ~b & ~d);
	
endmodule
