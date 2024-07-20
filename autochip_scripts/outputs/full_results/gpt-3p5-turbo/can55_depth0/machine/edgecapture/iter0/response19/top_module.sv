module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	reg [31:0] d_last;

	assign out = (reset) ? 0 : (out | (~in & d_last));

	always @(posedge clk)
	begin
		d_last <= in;
	end

endmodule
