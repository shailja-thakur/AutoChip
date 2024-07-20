module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);

	// Combinational Logic for State Transition and Output Logic
	
	// State Transition Logic
	
	// S0 (0, 0) --0--> S0
	assign next_state[0] = state[0] & ~in;
	
	// S0 (0, 0) --1--> S1
	assign next_state[0] = state[0] & in;
	assign next_state[1] = state[0] & in;
	
	// S1 (0, 0) --0--> S0
	assign next_state[1] = state[1] & ~in;
	
	// S1 (0, 0) --1--> S2
	assign next_state[1] = state[1] & in;
	assign next_state[2] = state[1] & in;
	
	// S2 (0, 0) --0--> S0
	assign next_state[2] = state[2] & ~in;
	
	// S2 (0, 0) --1--> S3
	assign next_state[2] = state[2] & in;
	assign next_state[3] = state[2] & in;
	
	// S3 (0, 0) --0--> S0
	assign next_state[3] = state[3] & ~in;
	
	// S3 (0, 0) --1--> S4
	assign next_state[3] = state[3] & in;
	assign next_state[4] = state[3] & in;
	
	// S4 (0, 0) --0--> S0
	assign next_state[4] = state[4] & ~in;
	
	// S4 (0, 0) --1--> S5
	assign next_state[4] = state[4] & in;
	assign next_state[5] = state[4] & in;
	
	// S5 (0, 0) --0--> S8
	assign next_state[5] = state[5] & ~in;
	assign next_state[8] = state[5] & ~in;
	
	// S5 (0, 0) --1--> S6
	assign next_state[5] = state[5] & in;
	assign next_state[6] = state[5] & in;
	
	// S6 (0, 0) --0--> S9
	assign next_state[6] = state[6] & ~in;
	assign next_state[9] = state[6] & ~in;
	
	// S6 (0, 0) --1--> S7
	assign next_state[6] = state[6] & in;
	assign next_state[7] = state[6] & in;
	
	// S7 (0, 1) --0--> S0
	assign next_state[7] = state[7] & ~in;
	assign next_state[0] = state[7] & ~in;
	
	// S7 (0, 1) --1--> S7
	assign next_state[7] = state[7] & in;
	
	// S8 (1, 0) --0--> S0
	assign next_state[8] = state[8] & ~in;
	assign next_state[0] = state[8] & ~in;
	
	// S8 (1, 0) --1--> S1
	assign next_state[8] = state[8] & in;
	assign next_state[1] = state[8] & in;
	
	// S9 (1, 1) --0--> S0
	assign next_state[9] = state[9] & ~in;
	assign next_state[0] = state[9] & ~in;
	
	// S9 (1, 1) --1--> S1
	assign next_state[9] = state[9] & in;
	assign next_state[1] = state[9] & in;
	
	
	// Output Logic
	
	// S0 (0, 0) -> (out1, out2) = (0, 0)
	assign out1 = 1'b0;
	assign out2 = 1'b0;
	
	// S1 (0, 0) -> (out1, out2) = (0, 0)
	assign out1 = state[1];
	assign out2 = state[1];
	
	// S2 (0, 0) -> (out1, out2) = (0, 0)
	assign out1 = 1'b0;
	assign out2 = 1'b0;
	
	// S3 (0, 0) -> (out1, out2) = (0, 0)
	assign out1 = 1'b0;
	assign out2 = 1'b0;
	
	// S4 (0, 0) -> (out1, out2) = (0, 0)
	assign out1 = 1'b0;
	assign out2 = 1'b0;
	
	// S5 (0, 0) -> (out1, out2) = (0, 0)
	assign out1 = 1'b0;
	assign out2 = 1'b0;
	
	// S6 (0, 0) -> (out1, out2) = (0, 0)
	assign out1 = 1'b0;
	assign out2 = 1'b0;
	
	// S7 (0, 1) -> (out1, out2) = (0, 1)
	assign out1 = 1'b0;
	assign out2 = 1'b1;
	
	// S8 (1, 0) -> (out1, out2) = (1, 0)
	assign out1 = 1'b1;
	assign out2 = 1'b0;
	
	// S9 (1, 1) -> (out1, out2) = (1, 1)
	assign out1 = 1'b1;
	assign out2 = 1'b1;
	
endmodule
