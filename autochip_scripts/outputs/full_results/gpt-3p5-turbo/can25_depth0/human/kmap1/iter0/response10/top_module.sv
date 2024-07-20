module top_module(
	input a, 
	input b,
	input c,
	output out
);
  // Implementing the logic based on the Karnaugh map
  assign out = (a & (~b | c));
endmodule
