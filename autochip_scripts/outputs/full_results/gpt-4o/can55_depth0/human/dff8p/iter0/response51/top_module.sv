module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

	initial q = 8'h34; // Initialize q to 0x34

	always @(negedge clk) begin
		if (reset)
			q <= 8'h34; // Reset to 0x34
		else
			q <= d; // Assign input d to q
	end
endmodule
