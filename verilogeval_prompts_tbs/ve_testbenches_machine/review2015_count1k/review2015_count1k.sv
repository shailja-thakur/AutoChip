//  This Verilog module is a simple counter that counts from 0 to 999. It has three ports, an input clock (clk), an input reset, and an output register (q). The output register is 10 bits wide, allowing it to count up to 999.   The module is always triggered on the positive edge of the clock. When the reset input is active, the output register is reset to 0. Otherwise, the output register is incremented by 1. When the output register reaches 999, it is reset to 0 and the counting cycle begins again.

module top_module(
	input clk,
	input reset,
	output reg [9:0] q);
