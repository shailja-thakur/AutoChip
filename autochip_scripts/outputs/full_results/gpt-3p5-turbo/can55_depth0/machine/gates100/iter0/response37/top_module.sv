module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

  // perform AND operation
  assign out_and = &in;

  // perform OR operation
  assign out_or = |in;

  // perform XOR operation
  assign out_xor = ^in;

endmodule
