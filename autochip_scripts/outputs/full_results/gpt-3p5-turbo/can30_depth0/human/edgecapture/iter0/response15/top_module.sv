module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	reg [31:0] capture_reg;

	always @(posedge clk or posedge reset) begin
		if (reset)
			capture_reg <= 0;
		else begin
			capture_reg <= in & ~in;
		end
	end

	assign out = capture_reg;
endmodule
