module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge);

	reg [7:0] pedge_internal;

	always @(posedge clk) begin
		pedge_internal <= pedge_internal | (in & ~{in[7:1], 1'b0});
	end

	always @(posedge clk) begin
		pedge <= pedge_internal;
	end

endmodule
