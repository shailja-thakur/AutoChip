module top_module(
	input wire clk,
	input wire d,
	output reg q);

	reg q_reg;
	always @(posedge clk) begin
		if (d) begin
			q_reg <= ~q_reg;
		end
	end

	always @(posedge clk) begin
		q <= q_reg;
	end

endmodule
