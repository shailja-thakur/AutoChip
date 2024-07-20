module top_module(
	input a, 
	input b,
	input c,
	output out
);

// Implement the circuit described by the Karnaugh map using an assign statement
// The truth table for the circuit is as follows:
// a | b | c || out
// 0 | 0 | 0 ||   0
// 0 | 0 | 1 ||   1
// 0 | 1 | 0 ||   1
// 0 | 1 | 1 ||   1
// 1 | 0 | 0 ||   1
// 1 | 0 | 1 ||   1
// 1 | 1 | 0 ||   1
// 1 | 1 | 1 ||   1

assign out = a | b | c;

endmodule
