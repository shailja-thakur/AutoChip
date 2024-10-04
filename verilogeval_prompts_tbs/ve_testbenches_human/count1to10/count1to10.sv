// Make a decade counter that counts 1 through 10, inclusive. The reset input is active high synchronous, and should reset the counter to 1.

module top_module(
	input clk,
	input reset,
	output reg [3:0] q);
