module top_module(
	input clk,
	input d,
	output reg q);

	reg q_1, q_2;

	always @(posedge clk) begin
		q_1 <= d;
	end

	always @(negedge clk) begin
		q_2 <= q_1;
		q <= q_2;
	end
endmodule
