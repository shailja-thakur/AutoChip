// Build a counter that counts from 0 to 999, inclusive, with a period of 1000 cycles. The reset input is active high synchronous, and should reset the counter to 0.

module top_module(
	input clk,
	input reset,
	output reg [9:0] q);