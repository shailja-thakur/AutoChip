module top_module(
	input a, 
	input b,
	input c,
	output out
);

  // Implement the circuit described by the Karnaugh map
  assign out = (a & ~c) | (b & c);

endmodule
