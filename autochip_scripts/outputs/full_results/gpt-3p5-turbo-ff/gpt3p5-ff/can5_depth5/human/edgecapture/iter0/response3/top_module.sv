module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	reg [31:0] prev_in;

	always @(posedge clk, posedge reset) begin
		if (reset)
			prev_in <= 0;
		else begin
			prev_in <= in;
			out <= in & ~prev_in;
		end
	end

endmodule
