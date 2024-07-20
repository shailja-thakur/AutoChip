//  This Verilog module implements a state machine with four states, A, B, C, and D. The state machine is triggered by the clock signal, clk, and the input signal, in. The output signal, out, is set to 1 when the state machine is in state D. The state machine is reset to state A when the reset signal, areset, is triggered.   The state machine is implemented using a 2-bit register, state, and a combinational logic block. The combinational logic block is used to determine the next state of the state machine based on the current state and the input signal. The logic is as follows:   If the current state is A, then the next state will be B if the input signal is 1, and A if the input signal is 0.   If the current state is B, then the next state will be B if the input signal is 1, and C if the input signal is 0.   If the current state is C, then the next state will be D if the input signal is 1, and A if the input signal is 0.   If the current state is D, then the next state will be B if the input signal is 1, and C if the input signal is 0.   The state register is updated on the rising edge of the clock signal, clk, and is reset to state A on the rising edge of the reset signal, areset. The output signal, out, is set to 1 when the state machine is in state D.

module top_module (
	input clk,
	input in,
	input areset,
	output out
);
