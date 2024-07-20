module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge);

	reg [7:0] d_last;

	always @(posedge clk) begin
		// Calculate rising edges
		pedge <= in & ~d_last;
		// Store the current value of the input signal
		d_last <= in;
	end
endmodule
