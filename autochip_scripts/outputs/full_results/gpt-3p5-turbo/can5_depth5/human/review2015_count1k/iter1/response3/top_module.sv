module top_module(
	input clk,
	input reset,
	output reg [9:0] q);

	reg [9:0] next_q;

	always @(posedge clk or posedge reset) begin
		if (reset)
			next_q <= 0;
		else if (q == 999)
			next_q <= 0;
		else
			next_q <= q + 1;
	end

	always @(posedge clk)
		q <= next_q;

endmodule
