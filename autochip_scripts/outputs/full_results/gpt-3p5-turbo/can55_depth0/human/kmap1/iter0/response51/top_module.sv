module top_module(
	input a, 
	input b,
	input c,
	output out
);

// Define the truth table for the output based on the Karnaugh map
assign out = (a & !b) | (b & c);

endmodule
