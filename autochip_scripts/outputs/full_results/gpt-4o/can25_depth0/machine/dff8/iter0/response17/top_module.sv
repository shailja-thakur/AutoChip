module top_module(
	input clk,
	input [7:0] d,
	output reg [7:0] q);

	// Initial block to set the default value of q
	initial
		q = 8'h00;

	// Always block to store and output data on the rising edge of the clock
	always @(posedge clk)
		q <= d;

endmodule
