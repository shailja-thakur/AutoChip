// 
The signal clk is the clock signal and should be a signal that is asserted high for a very short time
and is then deasserted low. This signal is input to the module.
The signal reset is the signal that resets the state of the module and is input to the module.
The signal in is the input to the module and is a 32 bit signal.
The signal out is the output of the module and is a 32 bit signal.
The signal d_last is used to store the previous value of in.

When the clock signal is asserted the input value is stored in the d_last signal and the output value is
modified such that the value of out is assigned the value of out ORed with the NOT of the input
signal ANDed with the previous value of the input.

The output value of out is 0 initially when the reset is asserted.


module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);
