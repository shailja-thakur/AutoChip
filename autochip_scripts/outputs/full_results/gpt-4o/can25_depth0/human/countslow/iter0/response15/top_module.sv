module top_module(
	input clk,
	input slowena,
	input reset,
	output reg [3:0] q);

	always @(posedge clk) begin
		if (reset) begin
			q <= 4'b0000;  // Reset the counter to 0
		end else if (slowena) begin
			if (q == 4'b1001) begin
				q <= 4'b0000;  // Wrap around after reaching 9
			end else begin
				q <= q + 1'b1;  // Increment the counter
			end
		end
	end

endmodule
