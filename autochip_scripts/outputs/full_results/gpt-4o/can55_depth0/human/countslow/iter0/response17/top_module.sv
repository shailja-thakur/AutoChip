module top_module(
	input clk,
	input slowena,
	input reset,
	output reg [3:0] q);

	always @(posedge clk) begin
		if (reset) begin
			q <= 4'd0; // reset counter to 0
		end else if (slowena) begin
			if (q == 4'd9) begin
				q <= 4'd0; // reset to 0 after reaching 9
			end else begin
				q <= q + 4'd1; // increment counter
			end
		end
	end

endmodule
