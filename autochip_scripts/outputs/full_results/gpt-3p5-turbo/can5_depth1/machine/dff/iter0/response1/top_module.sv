module top_module(
	input clk,
	input d,
	output reg q);

	// set initial value of q to 1'hx
	initial
		q = 1'hx;

	// synchronize d with clk
	always @(posedge clk)
		q <= d;
	
endmodule
