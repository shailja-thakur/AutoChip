module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	// Create an always block sensitive to the positive edge of clk
	always @(posedge clk)
	begin
		// Check if the reset input is active
		if (reset)
			q <= 4'b0; // Reset the counter to 0
		else
			q <= q + 1; // Increment the counter
	end

endmodule
