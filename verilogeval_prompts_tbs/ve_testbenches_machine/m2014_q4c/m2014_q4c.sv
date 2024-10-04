//  This Verilog module is a simple register that is used to store data. It has three inputs: a clock (clk), a data input (d), and a reset (r). It also has one output, q, which is the output of the register.   The module is triggered on the rising edge of the clock. When the reset is active, the output of the register is set to 0. Otherwise, the output is set to the value of the data input. This allows the register to store the data input until the reset is activated.

module top_module (
	input clk,
	input d,
	input r,
	output logic q
);
