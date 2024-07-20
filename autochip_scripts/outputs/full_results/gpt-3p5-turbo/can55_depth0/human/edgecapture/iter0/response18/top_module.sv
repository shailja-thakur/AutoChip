module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	always @(posedge clk, posedge reset) begin
		if (reset)
			out <= 0;
		else begin
			out <= ((out & ~in) | (~out & in));
		end
	end

endmodule
