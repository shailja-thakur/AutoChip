//  The top Verilog module is a state machine that takes in an 8-bit input, in, and a clock signal, clk, and outputs a 24-bit output, out_bytes, and a done signal. The state machine consists of four states: BYTE1, BYTE2, BYTE3, and DONE. The state machine transitions from BYTE1 to BYTE2 if the third bit of the input is 1, from BYTE2 to BYTE3, and from BYTE3 to DONE. If the third bit of the input is 0, the state machine transitions from BYTE1 to BYTE1 and from DONE to BYTE1. The done signal is set to 1 when the state machine is in the DONE state.  The out_bytes output is a 24-bit register that is updated on the rising edge of the clock signal. The 8-bit input is shifted into the register on each clock cycle, and the register is shifted left by 8 bits. The out_bytes output is set to the contents of the register when the done signal is set to 1.

module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);
