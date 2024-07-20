module top_module(
  input a, 
  input b,
  output out
);
	// Implement the NOR gate
	assign out = ~(a | b);
endmodule
