module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge);
	
	reg [7:0] last_in;
	
	always @(posedge clk) begin
		last_in <= in;
	end
	
	always @(posedge clk) begin
		pedge <= in & ~last_in;
	end
endmodule
