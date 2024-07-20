module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	reg [3:0] next_q;

	always @(posedge clk) begin
		if (reset)
			next_q <= 0;
		else if (q == 15)
			next_q <= 0;
		else
			next_q <= q + 1;
	end

	always @(posedge clk) begin
		q <= next_q;
	end

endmodule
