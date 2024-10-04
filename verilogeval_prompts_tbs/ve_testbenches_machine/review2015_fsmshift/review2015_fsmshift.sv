// The top module contains a 3 bit state register with the following state transition:

B0 -> B1 -> B2 -> B3 -> Done

B0 indicates that it is the first shift cycle.
B1 indicates that it is the second shift cycle.
B2 indicates that it is the third shift cycle.
B3 indicates that it is the fourth shift cycle.
Done indicates that it has completed the fourth shift cycle.

When the reset is 1, it will always go to state B0.
When the reset is 0, and state is not B0, B1, B2, or B3, it is in state Done.
shift_ena will be 1 if state is B0, B1, B2, or B3.



module top_module(
	input clk,
	input reset,
	output shift_ena);
