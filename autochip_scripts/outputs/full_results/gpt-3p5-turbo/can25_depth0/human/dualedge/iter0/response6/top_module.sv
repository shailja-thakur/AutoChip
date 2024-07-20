module top_module(
	input clk,
	input d,
	output reg q);

	reg q_reg;
	always @(posedge clk) begin
		q_reg <= d;
		q <= q_reg;
	end

endmodule
