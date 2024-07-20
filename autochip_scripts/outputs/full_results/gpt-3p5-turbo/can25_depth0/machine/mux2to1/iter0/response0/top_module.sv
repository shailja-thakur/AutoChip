module top_module (
	input a,
	input b,
	input sel,
	output out
);

	// Multiplexer logic
	always @(a, b, sel)
		if (sel)
			out = b;
		else
			out = a;

endmodule
