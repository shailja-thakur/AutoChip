module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

	reg [7:0] prev_in;

	always @(posedge clk) begin
		anyedge <= (prev_in ^ in) & ~prev_in & in; // Detecting rising edges
		prev_in <= in; // Updating previous input
	end

endmodule
