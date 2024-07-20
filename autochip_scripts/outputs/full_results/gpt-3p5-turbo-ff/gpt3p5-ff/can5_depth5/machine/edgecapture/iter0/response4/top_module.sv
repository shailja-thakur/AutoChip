module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	reg [31:0] d_last;

	always @(posedge clk) begin
		d_last <= in;
		out <= out | (~in & d_last);
	end

	always @(posedge reset) begin
		if (reset)
			out <= 0;
	end

endmodule
