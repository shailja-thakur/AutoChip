module top_module(
	input clk,
	input reset,
	output reg [9:0] q);

	always @(posedge clk) begin
		if (reset) begin
			q <= 10'd0; // Reset the counter to 0
		end else begin
			if (q == 10'd999) begin
				q <= 10'd0; // If counter reaches 999, reset it to 0
			end else begin
				q <= q + 1; // Otherwise, increment the counter
			end
		end
	end

endmodule
