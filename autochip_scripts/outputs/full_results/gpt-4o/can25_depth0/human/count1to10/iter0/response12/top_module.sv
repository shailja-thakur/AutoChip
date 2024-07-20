module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	always @(posedge clk) begin
		if (reset)
			q <= 4'd1; // Reset the counter to 1
		else if (q == 4'd10)
			q <= 4'd1; // If counter reaches 10, reset to 1 again
		else
			q <= q + 1; // Increment the counter
	end
endmodule
