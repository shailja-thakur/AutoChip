module top_module(
	input a, 
	input b,
	input c,
	output out
);
  // Perform OR operation on inputs a, b, and c
  assign out = a | b | c; // Use bitwise OR operator for OR operation
endmodule
