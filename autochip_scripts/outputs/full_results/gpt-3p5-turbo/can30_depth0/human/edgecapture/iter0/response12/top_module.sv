module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	reg [31:0] prev_in;

	always @(posedge clk, posedge reset) begin
		if (reset == 1'b1) begin
			out <= 32'b0;
		end else begin
			out <= (in ^ prev_in) & ~in;
		end
		prev_in <= in;
	end
endmodule
