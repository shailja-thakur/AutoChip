module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

	reg [7:0] d_last;

	always@(posedge clk)
		d_last <= in;
	
	assign anyedge = (in ^ d_last) ? 1 : 0;

endmodule
