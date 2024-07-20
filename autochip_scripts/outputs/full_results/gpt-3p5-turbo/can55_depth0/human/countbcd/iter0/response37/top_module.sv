module top_module(
	input clk,
	input reset,
	output reg [3:1] ena,
	output reg [15:0] q);

	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 0;
		else if (ena[1])
			q <= q + 10000;
		else if (ena[2])
			q <= q + 1000;
		else if (ena[3])
			q <= q + 100;
		else
			q <= q + 1;
	end
endmodule
