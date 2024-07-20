module top_module(
	input clk,
	input d,
	output reg q);

	reg q1;

	always @(posedge clk) begin
		q1 <= d;
		q <= q1;
	end

endmodule
