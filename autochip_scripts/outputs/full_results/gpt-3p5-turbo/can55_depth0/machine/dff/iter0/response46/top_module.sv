module top_module(
	input clk,
	input d,
	output reg q);

	// Register signal q is initialized to 1'hx
	initial
		q = 1'hx;

	// Always block triggered by the rising edge of clk
	always @(posedge clk)
		q <= d;
			
endmodule
