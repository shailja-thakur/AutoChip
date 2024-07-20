module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge);

	reg [7:0] prev;

	always @(posedge clk) begin
		pedge <= ~prev & in;  // Detect positive edge for each bit
		prev <= in;           // Update previous input
	end
endmodule
