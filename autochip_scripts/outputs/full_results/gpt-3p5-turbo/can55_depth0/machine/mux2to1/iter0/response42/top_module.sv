module top_module (
    input a,
    input b,
    input sel,
    output out
);

	// Implement multiplexer logic
	assign out = sel ? b : a;

endmodule
