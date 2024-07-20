module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

	reg [7:0] in_prev;

	always @(posedge clk) begin
		// Detect edges and set output one cycle later
		anyedge <= (in & ~in_prev);
		// Save current input for next cycle comparison
		in_prev <= in;
	end

endmodule
