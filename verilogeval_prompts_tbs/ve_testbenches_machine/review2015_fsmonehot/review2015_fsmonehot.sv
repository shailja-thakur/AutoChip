// 	The top module is a state machine. There are 10 states in this state machine, which are S, S1, S11, S110, B0, B1, B2, B3, Count and Wait.
	The done signal is 1 in the state Wait.
	The counting signal is 1 in the state Count.
	The shift_ena signal is 1 if any of the states B3, B2, B1 and B0 is active.
	The output of the top module B3_next is 1 when the state B2 is active.
	The output of the top module S_next is 1 when the state S and d is 0, or the state S1 and d is 0, or the state S110 and d is 0, or the state Wait and ack is 1.
	The output of the top module S1_next is 1 when the state S and d is 1.
	The output of the top module Count_next is 1 when the state B3 is active, or the state Count and done_counting is 0.
	The output of the top module Wait_next is 1 when the state Count and done_counting is 1, or the state Wait and ack is 0.
	

module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output B3_next,
    output S_next,
    output S1_next,
    output Count_next,
    output Wait_next,
    output done,
    output counting,
    output shift_ena
 );
