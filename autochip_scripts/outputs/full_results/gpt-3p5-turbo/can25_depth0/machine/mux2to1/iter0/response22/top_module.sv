module top_module (
	input a,
	input b,
	input sel,
	output out
);
	// Implementation of the multiplexer logic
	always @ (a, b, sel)
	begin
		if (sel == 1'b1)
			out = b;
		else
			out = a;
	end
endmodule
