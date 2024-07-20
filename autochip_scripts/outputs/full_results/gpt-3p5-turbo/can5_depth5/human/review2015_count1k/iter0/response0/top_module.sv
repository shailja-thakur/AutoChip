module top_module(
	input clk,
	input reset,
	output reg [9:0] q);

	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 0;
		else if (q < 1000)
			q <= q + 1;
		else
			q <= 0;
	end
endmodule
