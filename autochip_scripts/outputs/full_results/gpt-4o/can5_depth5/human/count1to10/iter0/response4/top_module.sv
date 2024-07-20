module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	always @(posedge clk) begin
		if (reset) begin
			q <= 4'd1; // Reset the counter to 1
		end else begin
			if (q == 4'd10) begin
				q <= 4'd1; // Reset to 1 after reaching 10
			end else begin
				q <= q + 1;
			end
		end
	end

endmodule
