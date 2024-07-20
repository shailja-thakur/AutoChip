module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	// Always block triggered on the rising edge of the clk signal
	always @(posedge clk) begin
		// Check if reset is asserted
		if (reset) begin
			// Reset the counter to 0
			q <= 0;
		end else begin
			// Increment the counter by 1
			q <= q + 1;
		end
	end

endmodule
