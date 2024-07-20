module top_module(
	input in,
	output out
);
  
  not_gate my_not_gate(
    .in(in),
    .out(out)
  );
  
endmodule
module not_gate(
	input in,
	output out
);
  
  assign out = ~in;
  
endmodule
