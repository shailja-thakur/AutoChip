module top_module(
	input a, 
	input b,
	input c,
	output out
);

  // Implement the truth table
  assign out = a & b & (c | !a);

endmodule
