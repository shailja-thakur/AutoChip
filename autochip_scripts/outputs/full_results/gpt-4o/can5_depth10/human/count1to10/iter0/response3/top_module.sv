module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	always @(posedge clk) begin
		if (reset)
			q <= 4'b0001; // Reset the counter to 1
		else begin
			if (q == 4'b1010)
				q <= 4'b0001; // Wrap around to 1 when reaching 10
			else
				q <= q + 1;
		end
	end
endmodule
