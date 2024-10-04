//  This Verilog module is a simple register with an asynchronous reset. It has three inputs, clk, d, and ar, and one output, q. The clk input is the clock signal which is used to synchronize the register. The d input is the data that will be stored in the register. The ar input is the asynchronous reset signal which will reset the register to 0. The q output is the output of the register which will be the value stored in the register.  The module has an always block which is triggered on the rising edge of the clock signal or the asynchronous reset signal. When the asynchronous reset signal is triggered, the output q is set to 0. Otherwise, when the clock signal is triggered, the output q is set to the value of the data input d. This allows the register to store the value of the data input d until the asynchronous reset signal is triggered.

module top_module (
	input clk,
	input d,
	input ar,
	output logic q
);
