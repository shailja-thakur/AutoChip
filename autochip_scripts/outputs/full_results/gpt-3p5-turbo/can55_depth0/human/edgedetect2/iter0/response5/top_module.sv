module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

	reg [7:0] prev;

	always @(posedge clk) begin
		prev <= in;
	end

	always @(posedge clk) begin
		anyedge <= in & ~prev;
	end

endmodule
