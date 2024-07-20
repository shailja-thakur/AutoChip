module top_module (
	input a,
	input b,
	input sel,
	output out
);
	// Multiplexer logic
	assign out = sel ? b : a;
  
endmodule
