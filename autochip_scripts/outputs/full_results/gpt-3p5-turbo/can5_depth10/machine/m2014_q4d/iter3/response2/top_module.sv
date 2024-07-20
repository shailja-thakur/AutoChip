module top_module (
	input clk,
	input in,
	output reg out
);

	always @(posedge clk)
		out <= in ^ out;

endmodule
