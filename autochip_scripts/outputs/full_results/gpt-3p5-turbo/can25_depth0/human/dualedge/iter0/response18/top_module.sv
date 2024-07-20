module top_module(
	input clk,
	input d,
	output reg q);

	reg q_d1;
	always @(posedge clk) begin
		q_d1 <= d;
	end

	always @(posedge clk) begin
		q <= q_d1;
	end

	always @(negedge clk) begin
		q <= d;
	end

endmodule
