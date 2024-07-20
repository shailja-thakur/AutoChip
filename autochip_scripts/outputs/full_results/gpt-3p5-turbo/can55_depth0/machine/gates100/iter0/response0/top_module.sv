module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

  // Perform AND operation on input vector and assign result to out_and output port
  assign out_and = &in;
  
  // Perform OR operation on input vector and assign result to out_or output port
  assign out_or = |in;
  
  // Perform XOR operation on input vector and assign result to out_xor output port
  assign out_xor = ^in;
  
endmodule
