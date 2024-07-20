module not_gate(
	input in,
	output out
);

  assign out = ~in;

endmodule
module top_module(
	input in,
	output out
);
  
  // Instantiating NOT gate module
  not_gate u1(
  	.in(in),
  	.out(out)
  );
  
endmodule
