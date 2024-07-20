module top_module(
	input clk,
	input d,
	output reg q);
	
	// Set the initial value of q to 1'b0
	initial
		q = 1'b0;
	
	// Synchronize d with clk
	always @(posedge clk)
		q <= d;
	
endmodule
