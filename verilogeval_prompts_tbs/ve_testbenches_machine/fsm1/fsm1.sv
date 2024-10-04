//  The top module is a simple state machine that has two states, A and B. The state transitions are determined by the input signal 'in'. When the state is A, if 'in' is high, the next state is A, otherwise the next state is B. When the state is B, if 'in' is high, the next state is B, otherwise the next state is A. The state is updated on the rising edge of the clock signal 'clk' and reset to state B on the rising edge of the reset signal 'areset'. The output 'out' is high when the state is B and low otherwise.

module top_module (
	input clk,
	input in,
	input areset,
	output out
);
