module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	// Internal signals
	reg [31:0] state;

	// Reset condition
	always @(posedge clk) begin
		if (reset) begin
			state <= 32'h1;
			q <= 32'h1;
		end else begin
			// Feedback taps XOR
			state <= state ^ (state >> 1) ^ (state >> 2) ^ (state >> 10) ^ (state >> 31);
			q <= state;
		end
	end

endmodule
