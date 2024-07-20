module top_module (
	input a,
	input b,
	input sel,
	output out
);
	always @* begin
		if (sel == 1'b0) // if sel is 0
			out = a; // output is a
		else
			out = b; // otherwise, output is b
	end
endmodule
