module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	// Internal wire for the counter output
	wire [3:0] next_q;

	// Synchronous reset
	always @(posedge clk) begin
		if (reset)
			q <= 4'b0000;
		else
			q <= next_q;
	end

	// Decade counter logic
	always @(posedge clk) begin
		if (reset)
			next_q <= 4'b0000;
		else if (q == 4'b1001)
			next_q <= 4'b0000;
		else
			next_q <= q + 1;
	end

endmodule
