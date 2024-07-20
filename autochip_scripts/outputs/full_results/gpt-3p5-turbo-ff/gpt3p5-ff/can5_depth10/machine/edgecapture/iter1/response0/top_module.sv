module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	reg [31:0] d_last;

	always @(posedge clk or negedge reset) begin
		if (!reset)
			d_last <= in;
	end

	always @(posedge clk) begin
		if (reset)
			out <= 0;
		else
			out <= out | (~in & d_last);
	end

endmodule
