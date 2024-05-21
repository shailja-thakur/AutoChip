// Create 8 D flip-flops with active high synchronous reset setting the output to zero. All DFFs should be triggered by the positive edge of clk.

module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);
