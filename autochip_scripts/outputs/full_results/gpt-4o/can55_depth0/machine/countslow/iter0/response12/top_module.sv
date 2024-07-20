module top_module(
	input clk,
	input slowena,
	input reset,
	output reg [3:0] q);

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 4'b0000; // Reset to 0
		end else if (slowena) begin
			if (q == 4'b1001) begin // If q is 9
				q <= 4'b0000; // Reset to 0
			end else begin
				q <= q + 1; // Increment by 1
			end
		end
	end

endmodule
