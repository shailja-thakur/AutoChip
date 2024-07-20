module top_module(
	input clk,
	input reset,
	output reg [9:0] q);

	reg [9:0] next_q;
	
	always @(posedge clk) begin
		if (reset)
			next_q <= 0;
		else if (q == 9'd999)
			next_q <= 0;
		else
			next_q <= q + 1;
	end

	always @(posedge clk) begin
		if (reset)
			q <= 0;
		else
			q <= next_q;
	end

endmodule
