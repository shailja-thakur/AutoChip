module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

	reg [7:0] q_temp;

	always @(negedge clk or posedge reset)
		if (reset)
			q_temp <= 8'h34;
		else
			q_temp <= d;
	
	always @(posedge clk)
		q <= q_temp;

endmodule
