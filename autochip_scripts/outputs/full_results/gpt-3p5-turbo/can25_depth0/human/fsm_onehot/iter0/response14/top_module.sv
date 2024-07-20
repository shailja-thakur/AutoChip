module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);

	// Output wires
	wire [9:0] next_state;
	wire out1, out2;
	
	// Logic for next state and outputs
	
	// Transition logic for S0
	assign next_state[0] = state[0] & ~in;
	
	// Transition logic for S1
	assign next_state[1] = state[0] & in;
	
	// Transition logic for S2
	assign next_state[2] = state[1] & ~in;
	
	// Transition logic for S3
	assign next_state[3] = state[1] & in;

	// Transition logic for S4
	assign next_state[4] = state[2] & ~in;
	
	// Transition logic for S5
	assign next_state[5] = state[2] & in;
	
	// Transition logic for S6
	assign next_state[6] = state[5] & ~in;
	
	// Transition logic for S7
	assign next_state[7] = state[5] & in;
	
	// Transition logic for S8
	assign next_state[8] = state[8] & in;
	
	// Transition logic for S9
	assign next_state[9] = state[9] & in;
	
	// Output logic
	assign out1 = (state[7] & ~in) | (state[8] & in);
	assign out2 = state[6] & in;
	
endmodule
