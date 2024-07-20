module top_module(
	input clk,
	input slowena,
	input reset,
	output reg [3:0] q);

	// Initialize the counter to 0
	initial begin
	    q = 4'b0000;
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 4'b0000;
		end else if (slowena) begin
			if (q == 4'b1001) begin
				q <= 4'b0000;
			end else begin
				q <= q + 1;
			end
		end
		// If slowena is not asserted,
		// counter does not change its value
	end

endmodule
