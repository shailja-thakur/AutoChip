module top_module (
	input a,
	input b,
	input sel,
	output out
);
	always @(a,b,sel)
		begin
			if (sel == 1'b0)
				out = a;
			else if (sel == 1'b1)
				out = b;
		end
endmodule
