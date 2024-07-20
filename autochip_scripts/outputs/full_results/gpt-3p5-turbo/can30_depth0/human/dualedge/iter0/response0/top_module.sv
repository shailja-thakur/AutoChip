module top_module(
	input clk,
	input d,
	output reg q);

	reg q_prev;

	initial begin
		q_prev = 1'b0;
	end

	always @(posedge clk) begin
		q_prev <= q;
	end

	always @(negedge clk) begin
		q <= d & ~q_prev;
	end

endmodule
