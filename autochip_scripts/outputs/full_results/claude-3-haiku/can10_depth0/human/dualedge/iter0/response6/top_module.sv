module top_module(
	input clk,
	input d,
	output reg q);

	reg d_reg;

	always @(posedge clk) begin
		d_reg <= d;
		q <= d_reg;
	end

endmodule
