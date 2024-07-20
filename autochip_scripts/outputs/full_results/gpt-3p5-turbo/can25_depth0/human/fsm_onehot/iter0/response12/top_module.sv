module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);

	// Declare intermediary wire signals
	wire [9:0] next_state_inter;
	wire [9:0] out_inter_1;
	wire [9:0] out_inter_2;

	// State transition logic
	assign next_state_inter[0] = (~state[1] & ~state[3] & ~state[5] & ~state[6] & ~state[7]);
	assign next_state_inter[1] = (~state[0] & ~state[2] & ~state[4]);
	assign next_state_inter[2] = (~state[1] & ~state[3]);
	assign next_state_inter[3] = (~state[2] & ~state[4]);
	assign next_state_inter[4] = (~state[3] & ~state[5]);
	assign next_state_inter[5] = (~state[4] & ~state[6]);
	assign next_state_inter[6] = (~state[5] & ~state[7]);
	assign next_state_inter[7] = (~state[6] & ~state[8]);
	assign next_state_inter[8] = (~state[5] & ~state[9]);
	assign next_state_inter[9] = (~state[6] & state[8] & state[9]);

	// Output logic
	assign out_inter_1[0] = 1'b0;
	assign out_inter_1[1] = 1'b0;
	assign out_inter_1[2] = 1'b0;
	assign out_inter_1[3] = 1'b0;
	assign out_inter_1[4] = 1'b0;
	assign out_inter_1[5] = 1'b0;
	assign out_inter_1[6] = 1'b0;
	assign out_inter_1[7] = 1'b0;
	assign out_inter_1[8] = 1'b1;
	assign out_inter_1[9] = 1'b0;

	assign out_inter_2[0] = 1'b0;
	assign out_inter_2[1] = 1'b0;
	assign out_inter_2[2] = 1'b0;
	assign out_inter_2[3] = 1'b0;
	assign out_inter_2[4] = 1'b0;
	assign out_inter_2[5] = 1'b0;
	assign out_inter_2[6] = 1'b0;
	assign out_inter_2[7] = 1'b1;
	assign out_inter_2[8] = 1'b0;
	assign out_inter_2[9] = 1'b0;

	// Assign outputs
	assign next_state = next_state_inter;
	assign out1 = out_inter_1[state];
	assign out2 = out_inter_2[state];

endmodule
