module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);

	// Output wires
	wire [9:0] next_state_wire;
	wire [9:0] out1_wire;
	wire [9:0] out2_wire;
	
	// State transition logic
	assign next_state_wire[0] = state[0] & (~in);
	assign next_state_wire[1] = state[0] & in;
	assign next_state_wire[2] = state[1] & (~in);
	assign next_state_wire[3] = state[1] & in;
	assign next_state_wire[4] = state[2] & (~in);
	assign next_state_wire[5] = state[2] & in;
	assign next_state_wire[6] = state[3] & (~in);
	assign next_state_wire[7] = state[3] & in;
	assign next_state_wire[8] = state[4] & (~in);
	assign next_state_wire[9] = state[4] & in;

	// Output logic
	assign out1_wire[0] = 0;
	assign out1_wire[1] = 0;
	assign out1_wire[2] = 0;
	assign out1_wire[3] = 0;
	assign out1_wire[4] = 0;
	assign out1_wire[5] = 0;
	assign out1_wire[6] = 0;
	assign out1_wire[7] = 0;
	assign out1_wire[8] = 1;
	assign out1_wire[9] = 1;
	
	assign out2_wire[0] = 0;
	assign out2_wire[1] = 0;
	assign out2_wire[2] = 0;
	assign out2_wire[3] = 0;
	assign out2_wire[4] = 0;
	assign out2_wire[5] = 0;
	assign out2_wire[6] = 1;
	assign out2_wire[7] = 1;
	assign out2_wire[8] = 0;
	assign out2_wire[9] = 0;

	// Output assignments
	assign next_state = next_state_wire;
	assign out1 = out1_wire[state];
	assign out2 = out2_wire[state];
	
endmodule
