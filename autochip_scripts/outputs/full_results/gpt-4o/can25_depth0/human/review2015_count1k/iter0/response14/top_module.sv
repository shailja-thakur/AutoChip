module top_module(
	input clk,
	input reset,
	output reg [9:0] q);

	// Always block to model the counter's behavior
	always @(posedge clk) begin
		if (reset) begin
			// Reset the counter to 0
			q <= 0;
		end else begin
			if (q == 10'd999) begin
				// Reset the counter to 0 upon reaching 999
				q <= 0;
			end else begin
				// Otherwise, increment the counter
				q <= q + 1;
			end
		end
	end

endmodule
