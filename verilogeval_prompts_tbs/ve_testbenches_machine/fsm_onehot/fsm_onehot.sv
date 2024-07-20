// 
the top module has a input in, a 10 bit input state, 10bit output next_state, 2 output out1 and out2.

out1 is equal to state[8] or state[9], out2 is equal to state[7] or state[9]
next_state[0] is equal to not(in) and (the or of state[4:0], state[7], state[8], state[9])
next_state[1] is equal to in and the or of state[0], state[8] and state[9]
next_state[2] is equal to in and state[1]
next_state[3] is equal to in and state[2]
next_state[4] is equal to in and state[3]
next_state[5] is equal to in and state[4]
next_state[6] is equal to in and state[5]
next_state[7] is equal to in and the or of state[6] and state[7]
next_state[8] is equal to not(in) and state[5]
next_state[9] is equal to not(in) and state[6]


module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);
