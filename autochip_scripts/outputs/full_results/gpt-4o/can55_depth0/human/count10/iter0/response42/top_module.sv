module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	always @(posedge clk) begin
		if (reset) // Synchronous reset
			q <= 4'b0000; // Reset counter to 0
		else if (q == 4'b1001) // If counter is at 9
			q <= 4'b0000; // Reset counter to 0
		else
			q <= q + 1; // Increment counter
	end

endmodule
