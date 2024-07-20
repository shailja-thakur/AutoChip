module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);
	
	reg [31:0] previous;

	always @(posedge clk or posedge reset) begin
		if (reset)
			previous <= 0;
		else begin
			previous <= in;
			out <= (in ^ previous) & ~in;
		end
	end
	
endmodule
