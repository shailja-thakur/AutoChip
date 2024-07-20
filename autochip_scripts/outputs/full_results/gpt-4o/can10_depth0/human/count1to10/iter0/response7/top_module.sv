module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	always @(posedge clk) begin
		if (reset) begin
			q <= 4'b0001; // Reset to 1 when reset is high
		end else begin
			if (q == 4'b1010) begin
				q <= 4'b0001; // Wrap around to 1 when 10 is reached
			end else begin
				q <= q + 1;
			end
		end
	end
endmodule
