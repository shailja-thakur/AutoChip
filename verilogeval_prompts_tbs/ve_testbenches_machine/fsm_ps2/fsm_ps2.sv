//  This top module is a state machine that takes in an 8-bit input and outputs a done signal when the third bit of the input is 1. The module has four states: BYTE1, BYTE2, BYTE3 and DONE. The state machine is clocked by the clk signal and reset by the reset signal.  The state machine starts in the BYTE1 state. In this state, the module checks the third bit of the input. If it is 0, the state machine remains in the BYTE1 state. If it is 1, the state machine transitions to the BYTE2 state.  In the BYTE2 state, the state machine transitions to the BYTE3 state. In the BYTE3 state, the state machine transitions to the DONE state.  In the DONE state, the module checks the third bit of the input again. If it is 0, the state machine transitions back to the BYTE1 state. If it is 1, the state machine transitions back to the BYTE2 state.  The done signal is asserted when the state machine is in the DONE state.

module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);
