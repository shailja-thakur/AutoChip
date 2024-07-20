module top_module (
	input a,
	input b,
	input sel,
	output reg out
);

	always @ (a or b or sel) begin
		if (sel)
			out = b;
		else
			out = a;
	end
	
endmodule
