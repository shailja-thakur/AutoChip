//  This Verilog module is a 4-bit counter with a shift register. It has 5 inputs and 1 output. The inputs are a clock (clk), a shift enable (shift_ena), a count enable (count_ena), and data (data). The output is a 4-bit register (q).  The module is triggered by the clock signal (clk). When the clock signal is high, the module will check the two enable signals (shift_ena and count_ena). If the shift_ena signal is high, the module will shift the data input (data) into the 4-bit register (q). If the count_ena signal is high, the module will decrement the 4-bit register (q). If both enable signals are low, the module will not do anything.

module top_module(
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output reg [3:0] q);
