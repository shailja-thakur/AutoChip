module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

// Implementing the truth table given by the Karnaugh map.
assign out = !a & !c | a & b | b & d | !b & !d;

endmodule
