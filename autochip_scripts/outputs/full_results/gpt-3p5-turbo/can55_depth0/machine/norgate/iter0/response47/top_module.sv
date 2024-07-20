module top_module(
  input a,
  input b,
  output out
);
	// Logic for output signal
	assign out = ~(a | b);
endmodule
