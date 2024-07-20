module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge);

	reg [7:0] dff_q;

	always @(posedge clk) begin
		dff_q <= in;
		pedge <= dff_q & ~in;
	end

endmodule
