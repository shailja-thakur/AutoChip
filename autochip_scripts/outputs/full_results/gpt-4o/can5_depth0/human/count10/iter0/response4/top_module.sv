module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	// Initial block to initialize the counter
	initial begin
		q = 4'b0000;
	end

	always @(posedge clk) begin
		if (reset) begin
			q <= 4'b0000; // Reset the counter to 0
		end else begin
			if (q == 4'b1001) begin
				q <= 4'b0000; // Wrap around if the counter is 9
			end else begin
				q <= q + 1; // Increment the counter
			end
		end
	end
endmodule
