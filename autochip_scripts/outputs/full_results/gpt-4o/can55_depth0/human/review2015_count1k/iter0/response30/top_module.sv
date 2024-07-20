module top_module(
	input clk,
	input reset,
	output reg [9:0] q);

	always @(posedge clk) begin
		if (reset) begin
			q <= 10'b0; // Reset to 0 when reset is high
		end
		else begin
			if (q == 10'd999) begin
				q <= 10'b0; // Reset counter back to 0 after counting to 999
			end
			else begin
				q <= q + 1; // Increment counter
			end
		end
	end

endmodule
