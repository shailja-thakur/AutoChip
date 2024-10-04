// state A: If s is asserted, next state is B
state B: If w is asserted, next state is S11, otherwise next state is S10
state C: If w is asserted, next state is S11, otherwise next state is S10
state S10: If w is asserted, next state is S21, otherwise next state is S20
state S11: If w is asserted, next state is S22, otherwise next state is S21
state S20: next state is B
state S21: If w is asserted, next state is C, otherwise next state is B
state S22: If w is asserted, next state is B, otherwise next state is C


module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);
