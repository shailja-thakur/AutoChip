module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	reg [31:0] in_old;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			out <= 0;
		end else begin
			out <= out | (~in & in_old);
			in_old <= in;
		end
	end

endmodule
