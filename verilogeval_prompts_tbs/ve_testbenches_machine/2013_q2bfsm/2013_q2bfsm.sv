// FSM machine is implemented on this code.
From A state it goes to B and from B state it goes to S0.
From S0, if x is 1 then it goes to S1 and if x is 0 then it stays in S0 itself.
From S1, if x is 1 then it stays in S1 and if x is 0 then it goes to S10.
From S10, if x is 1 then it goes to G1 and if x is 0 then it goes to S0.
From G1, if y is 1 then it goes to P1 and if y is 0 then it goes to G2.
From G2, if y is 1 then it goes to P1 and if y is 0 then it goes to P0.
From P0, it stays in P0.
From P1, it stays in P1.

f is assigned to 1 when the state is B.
g is assigned to 1 when the state is G1 or G2 or P1.


module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);
