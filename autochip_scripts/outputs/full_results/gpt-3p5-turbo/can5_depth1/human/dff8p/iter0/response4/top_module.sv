module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

	reg [7:0] q_reg;
	always @(posedge clk or negedge reset) begin
		if (!reset) begin
			q_reg <= 8'h34;
		end else begin
			q_reg <= d;
		end
	end

	always @(negedge clk) begin
		q <= q_reg;
	end
endmodule
