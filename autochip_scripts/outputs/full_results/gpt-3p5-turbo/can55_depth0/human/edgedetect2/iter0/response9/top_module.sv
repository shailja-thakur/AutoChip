module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

	// Create register to store previous input
	reg [7:0] prev_in;

	always @(posedge clk) begin
		// Detect edge for each bit
		for (int i = 0; i < 8; i = i + 1) begin
			// If current bit is different from previous bit, set anyedge bit to 1
			if (in[i] != prev_in[i])
				anyedge[i] <= 1;
			// Store current input in prev_in register for next cycle
			prev_in[i] <= in[i];
		end
	end

	// Reset anyedge to 0 on next cycle after edge detection
	always @(posedge clk) begin
		anyedge<= 0;
	end

endmodule
