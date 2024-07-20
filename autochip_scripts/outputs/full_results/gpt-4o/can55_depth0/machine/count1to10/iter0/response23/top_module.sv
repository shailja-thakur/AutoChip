module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 4'b0001;  // Set to 1 on reset
		end else begin
			if (q == 4'b1010) begin
				q <= 4'b0001;  // Reset to 1 when q reaches 10
			end else begin
				q <= q + 1;  // Increment q
			end
		end
	end

endmodule
