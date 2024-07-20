module top_module(
	input clk,
	input d,
	output reg q);

	reg q_current;
	always @(posedge clk) begin
		q_current <= d;
	end

	always @(posedge clk) begin
		q <= q_current;
	end

endmodule
