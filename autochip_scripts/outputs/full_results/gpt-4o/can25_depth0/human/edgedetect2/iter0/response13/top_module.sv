module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

	reg [7:0] in_prev;

	always @(posedge clk) begin
		anyedge <= (in & ~in_prev) | (~in & in_prev);
		in_prev <= in;
	end

endmodule
