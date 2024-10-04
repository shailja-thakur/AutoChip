//  This Verilog module is a 4-bit register. The module has 6 inputs and 1 output. The inputs are a clock (clk), an asynchronous reset (areset), a load signal (load), an enable signal (ena), and a 4-bit data input (data). The output is a 4-bit register (q).  The module is always sensitive to the rising edge of the clock and the asynchronous reset. When the asynchronous reset is active, the output register is set to 0. When the load signal is active, the data input is loaded into the output register. When the enable signal is active, the output register is shifted left by 1 bit. When none of the signals are active, the output register remains unchanged.

module top_module(
	input clk,
	input areset,
	input load,
	input ena,
	input [3:0] data,
	output reg [3:0] q);
