module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

// Implement the truth table from the Karnaugh map

// Output for input (00)
assign out = a & b;

// Output for input (01)
assign out = a & ~b;

// Output for input (10)
assign out = a & b & ~c;

// Output for input (11)
assign out = a | b | c;

endmodule
