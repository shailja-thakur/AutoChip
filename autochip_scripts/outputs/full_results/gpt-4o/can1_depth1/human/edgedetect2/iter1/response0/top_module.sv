module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

	reg [7:0] in_dly;

	always @(posedge clk) begin
		in_dly <= in; // Capture the input on the previous clock cycle
		anyedge <= (in_dly ^ in) & in; // Detect any edge (either 0 to 1 or 1 to 0 transition)
	end
endmodule
