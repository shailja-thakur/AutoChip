module top_module(
	input a, 
	input b,
	input c,
	output out
);

  wire d;

  // Karnaugh map for d
  assign d = (a & ~b & c) | (~a & b & c) | (a & b & c) | (~a & ~b & c);

  // Output
  assign out = d;

endmodule
