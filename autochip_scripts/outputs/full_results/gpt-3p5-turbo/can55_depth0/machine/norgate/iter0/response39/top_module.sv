module top_module(
	input a, 
	input b,
	output out
);

  // Define internal wires for intermediate signals
  wire out_and;
  wire out_inv;

  // Implement logic gates
  assign out_and = a & b;
  assign out_inv = ~out_and;

  // Output the final result
  assign out = out_inv;

endmodule
