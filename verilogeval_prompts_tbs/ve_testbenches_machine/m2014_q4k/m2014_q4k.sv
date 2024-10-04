//  This Verilog module is a 4-bit shift register. It has four ports: a clock input (clk), a reset input (resetn), an input (in) and an output (out). The clock input is used to synchronize the shift register, the reset input is used to reset the register to all zeros, the input is used to load data into the register and the output is used to read data from the register.  The module contains a 4-bit register (sr) which is used to store the data. The register is updated on the positive edge of the clock signal. When the resetn signal is low, the register is reset to all zeros. When the resetn signal is high, the register is shifted left by one bit and the input is loaded into the least significant bit. The output is taken from the most significant bit of the register.

module top_module (
	input clk,
	input resetn,
	input in,
	output out
);
