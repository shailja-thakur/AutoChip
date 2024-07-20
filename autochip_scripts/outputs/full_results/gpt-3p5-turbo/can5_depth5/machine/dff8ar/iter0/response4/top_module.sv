module top_module(
	input clk,
	input [7:0] d,
	input areset,
	output [7:0] q);

	always @(posedge clk or posedge areset) begin
		if (areset)
			q <= 0;
		else
			q <= d;
	end

endmodule
