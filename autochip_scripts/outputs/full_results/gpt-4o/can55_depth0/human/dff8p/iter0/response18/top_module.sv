module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

	// Initial value for reset
	initial q = 8'h34;

	always @(negedge clk) begin
		if (reset)
			q <= 8'h34;
		else
			q <= d;
	end

endmodule
