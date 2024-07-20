module top_module (
	input a,
	input b,
	input sel,
	output out
);

	// multiplexer logic
	assign out = (sel) ? b : a;
  
endmodule
