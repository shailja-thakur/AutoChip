module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);

	// Declare wire variables for the logic equations
	wire [9:0] next_state_temp;
	wire out1_temp;
	wire out2_temp;
	
	// State transition logic
	assign next_state_temp[0] = (in & state[0]) | (in & state[1]) | (~in & state[7]);
	assign next_state_temp[1] = (in & state[2]) | (in & state[8]) | (~in & state[9]);
	assign next_state_temp[2] = (in & state[3]) | (~in & state[0]);
	assign next_state_temp[3] = (in & state[4]) | (~in & state[1]);
	assign next_state_temp[4] = (in & state[5]) | (~in & state[2]);
	assign next_state_temp[5] = (in & state[6]) | (~in & state[3]);
	assign next_state_temp[6] = (~in & state[4]);
	assign next_state_temp[7] = (~in & state[5]) | (in & state[7]);
	assign next_state_temp[8] = (~in & state[6]) | (in & state[9]);
	assign next_state_temp[9] = (in & state[5]);
	
	// Output logic
	assign out1_temp = (state[7] & ~in) | (state[8] & in);
	assign out2_temp = (state[9] & ~in);
	
	// Assign output signals
	assign next_state = next_state_temp;
	assign out1 = out1_temp;
	assign out2 = out2_temp;

endmodule
