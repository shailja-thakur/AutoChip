module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	always @(posedge clk) begin
		// If reset is active, set q to 1
		if (reset)
			q <= 1;
		else begin
			// Increment q by 1
			q <= q + 1;
			
			// Check if q reaches 10 (1010 in binary), reset to 1
			if (q == 4'b1010)
				q <= 1;
		end
	end

endmodule
