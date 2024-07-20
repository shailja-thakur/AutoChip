module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	reg [31:0] temp;

	always @(posedge clk) begin
		if (reset)
			temp <= 0;
		else
			temp <= in;
	end

	always @(posedge clk) begin
		out <= temp & ~in;
	end

endmodule
