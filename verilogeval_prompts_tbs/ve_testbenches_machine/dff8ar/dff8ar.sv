//  This Verilog module is a simple 8-bit register. It has four ports: clk, d, areset, and q. The clk port is an input port that is used to control the clock signal. The d port is an 8-bit input port that is used to store the data. The areset port is an input port that is used to reset the register. The q port is an 8-bit output port that is used to output the stored data.  The module has an always block that is triggered on the positive edge of the clock signal and the positive edge of the areset signal. Inside the always block, an if statement is used to check the state of the areset signal. If the areset signal is high, the q output is set to 0. Otherwise, the q output is set to the d input. This allows the register to store the data from the d input when the areset signal is low.

module top_module(
	input clk,
	input [7:0] d,
	input areset,
	output reg [7:0] q);
