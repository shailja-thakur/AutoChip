module top_module (
	input a,
	input b,
	input sel,
	output out
);

	// Implementation of the multiplexer logic
	always @(a, b, sel)
	begin
		if (sel == 1'b0)
			out = a;
		else
			out = b;
	end
endmodule
