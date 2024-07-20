module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	// Initialize the counter q to 0
	initial begin
		q = 4'b0000;
	end

	// Always block triggered on the rising edge of the clock signal
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 4'b0000;  // Reset the counter to 0
		end else begin
			q <= q + 1;  // Increment the counter
		end
	end

endmodule
