module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

	always @(negedge clk) begin
		if (reset)
			q <= 8'h34; // Hexadecimal for 0x34
		else
			q <= d;
	end

endmodule
