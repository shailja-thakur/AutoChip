// The reset input initializes the state to A. The top module has a clock, a reset, an input, and an output. The input x is the current input and the output z is the output of the module. The output is high when the state is D or E. The internal state is represented by 3 bits, so there are 8 states. The case statement describes the state transition when x is high or low. If the state is A and x is low, then the next state is also A. If the state is A and x is high, then the next state is B. If the state is B and x is low, then the next state is B. If the state is B and x is high, then the next state is E. If the state is C and x is low, then the next state is C. If the state is C and x is high, then the next state is B. If the state is D and x is low, then the next state is B. If the state is D and x is high, then the next state is C. If the state is E and x is low, then the next state is D. If the state is E and x is high, then the next state is E.


module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);
