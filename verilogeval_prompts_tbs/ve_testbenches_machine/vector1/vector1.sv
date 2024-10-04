//  This Verilog module is a simple 16-bit to 8-bit splitter. It takes a 16-bit input signal, "in", and splits it into two 8-bit signals, "out_hi" and "out_lo". The two 8-bit signals are the upper and lower 8 bits of the original 16-bit signal, respectively. The module does not contain any logic, it simply assigns the two 8-bit signals to the 16-bit input signal. This module is useful when splitting a 16-bit signal into two 8-bit signals is necessary.

module top_module (
	input [15:0] in,
	output [7:0] out_hi,
	output [7:0] out_lo
);
