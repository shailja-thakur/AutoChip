module top_module(
	input clk,
	input d,
	output reg q);

	reg q1, q2;
	always @(posedge clk) begin
		q1 <= d;
		q2 <= q1;
		q <= q2;
	end
endmodule
