module top_module (
	input a,
	input b,
	input sel,
	output out
);

// 2-to-1 multiplexer implementation
assign out = sel ? b : a;

endmodule
