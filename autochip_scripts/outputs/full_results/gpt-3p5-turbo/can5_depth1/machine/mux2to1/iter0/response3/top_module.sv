module top_module (
	input a,
	input b,
	input sel,
	output out
);
	reg out;
	always @ (a, b, sel) begin
		if (sel == 1)
			out = b;
		else
			out = a;
	end
endmodule
