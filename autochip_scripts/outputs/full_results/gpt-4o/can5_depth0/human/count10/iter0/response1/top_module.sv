module top_module(
	input clk,
	input reset,
	output reg [3:0] q);
	
	// Initial state
	initial q = 4'd0;
	
	always @(posedge clk) begin
		if (reset) begin
			q <= 4'd0; // Reset to 0
		end else begin
			if (q == 4'd9) begin
				q <= 4'd0; // Wrap around to 0 after reaching 9
			end else begin
				q <= q + 4'd1; // Increment counter
			end
		end
	end
endmodule
