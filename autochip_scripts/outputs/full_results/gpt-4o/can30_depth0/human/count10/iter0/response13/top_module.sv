module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	always @(posedge clk) begin
		if (reset) begin
			q <= 4'b0000; // reset count to 0
		end
		else begin
			if (q == 4'b1001) begin
				q <= 4'b0000; // when count is 9, reset to 0
			end
			else begin
				q <= q + 1; // otherwise increment the count
			end
		end
	end
endmodule
