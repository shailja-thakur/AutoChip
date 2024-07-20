module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge);

	reg [7:0] prev_in;

	always @(posedge clk) begin
		// Detect positive edge for each bit
		pedge <= (in & ~prev_in);
		// Store current input for next cycle comparison
		prev_in <= in;
	end
endmodule
