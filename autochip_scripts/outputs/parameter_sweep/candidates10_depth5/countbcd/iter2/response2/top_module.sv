module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 16'b0000;
		else if (ena != 3'b111)
			q <= q + 1;
	end

	assign ena = q[15:13] != 3'b111;
	
endmodule
