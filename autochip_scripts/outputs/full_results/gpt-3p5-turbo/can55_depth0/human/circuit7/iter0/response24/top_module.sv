module top_module (
	input clk,
	input a, 
	output reg q
);

	always @(posedge clk) begin
		if (a == 0)
			q <= q;
		else if (a == 1)
			q <= ~q;
	end

endmodule
