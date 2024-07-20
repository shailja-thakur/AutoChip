module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge);
	
	reg [7:0] in_delay;

	always @(posedge clk) begin
		pedge <= (~in_delay & in);
		in_delay <= in;
	end
endmodule
