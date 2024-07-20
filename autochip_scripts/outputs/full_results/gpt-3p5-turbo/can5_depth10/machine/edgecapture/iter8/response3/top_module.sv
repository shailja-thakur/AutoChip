module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	reg [31:0] in_last;

	always @(posedge clk) begin
		if (reset) begin
			in_last <= 0;
			out <= 0;
		end else begin
			in_last <= in;
			out <= out | (~in & in_last);
		end
	end

endmodule
