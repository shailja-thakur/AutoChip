module top_module (
	input a,
	input b,
	input sel,
	output out
);

	always @(a or b or sel) begin
		if (sel == 1'b1)
			out = b;
		else
			out = a;
	end

endmodule
