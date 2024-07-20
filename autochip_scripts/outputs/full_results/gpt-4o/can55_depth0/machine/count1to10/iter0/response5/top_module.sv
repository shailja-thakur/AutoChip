module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	// Always block triggered on the rising edge of the clock
	always @(posedge clk) begin
		if (reset) begin
			// If reset is active, set q to 1
			q <= 4'd1;
		end else begin
			// If reset is not active, increment q
			if (q == 4'd10)
				// If q reaches 10, reset it to 1
				q <= 4'd1;
			else
				// Otherwise, increment q by 1
				q <= q + 4'd1;
		end
	end
endmodule
