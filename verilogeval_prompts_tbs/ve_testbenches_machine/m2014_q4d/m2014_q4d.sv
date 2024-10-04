//  This module is a simple toggle flip-flop. It takes an input signal (in) and a clock signal (clk) and produces an output signal (out). The output signal is initially set to 0.   When the clock signal (clk) transitions from low to high (posedge), the output signal (out) is set to the logical XOR of the input signal (in) and the previous output signal (out). This means that the output signal (out) will toggle (change from 0 to 1 or from 1 to 0) every time the clock signal (clk) transitions from low to high.

module top_module (
	input clk,
	input in,
	output logic out
);
