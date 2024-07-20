module top_module(
	input clk,
	input slowena,
	input reset,
	output reg [3:0] q);

	// Always block triggered on the rising edge of the clock signal
	always @(posedge clk or posedge reset) begin
		// Check the reset signal (asynchronous reset)
		if (reset) begin
			q <= 4'b0000;
		end
		else if (slowena) begin
			// If reset is not asserted, check the slowena signal
			if (q == 4'b1001) begin
				// If the counter is equal to 9, reset it to 0
				q <= 4'b0000;
			end
			else begin
				// Else, increment the counter by 1
				q <= q + 1;
			end
		end
	end

endmodule
