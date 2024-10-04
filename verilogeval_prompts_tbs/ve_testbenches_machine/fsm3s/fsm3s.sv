// This project is a FSM that has 4 states.
It has 3 inputs, clk, in and reset.
It has 1 output, out.
The 4 states are A, B, C, D and the initial state is A.
When the state is A, if the in is 1, the state changes to B,
otherwise the state remains to be A.
When the state is B, if the in is 1, the state changes to B,
otherwise the state changes to C.
When the state is C, if the in is 1, the state changes to D,
otherwise the state changes to A.
When the state is D, if the in is 1, the state changes to B,
otherwise the state changes to C.
When the reset is 1, the state changes to A.
The out is 1 when the state is D.


module top_module (
	input clk,
	input in,
	input reset,
	output out
);
