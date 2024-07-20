module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	reg [31:0] in_last;
	always @(posedge clk) begin
		if (reset) begin
			out <= 0;
			in_last <= 0;
		end else begin
			out <= out | (~in & in_last);
			in_last <= in;
		end
	end

endmodule
