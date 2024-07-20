module top_module(
	input clk,
	input d,
	output reg q);

	// Register signal q initialization
	initial
		q = 1'b?x;

	// Synchronize data signal d with clock signal clk
	always @(posedge clk)
		q <= d;
endmodule
