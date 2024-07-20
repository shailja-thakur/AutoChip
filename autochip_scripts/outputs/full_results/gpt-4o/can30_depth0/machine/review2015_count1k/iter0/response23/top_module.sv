module top_module(
	input clk,
	input reset,
	output reg [9:0] q);

	// Initial block for simulation purposes.
	initial begin
		q = 10'b0;
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 10'b0; // Reset the counter to 0
		end else begin
			if (q == 10'd999) begin
				q <= 10'b0; // Reset the counter to 0 when it reaches 999
			end else begin
				q <= q + 1; // Increment the counter by 1
			end
		end
	end

endmodule
