module top_module (
	input a,
	input b,
	input sel,
	output out
);

	// Implementation of the multiplexer
	// Assigns the output based on the value of sel
	always @ (*) begin
		if (sel == 1'b1)
			out = b;
		else
			out = a;
	end

endmodule
