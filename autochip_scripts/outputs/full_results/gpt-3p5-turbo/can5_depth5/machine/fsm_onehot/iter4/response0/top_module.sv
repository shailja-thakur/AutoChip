module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);
	wire [9:0] next_state_temp;
	assign out1 = state[8] | state[9];
	assign out2 = state[7] | state[9];

	assign next_state_temp[0] = ~in & (state[4:0] | state[7] | state[8] | state[9]);
	assign next_state_temp[1] = in & (state[0] | state[8] | state[9]);
	assign next_state_temp[2] = in & state[1];
	assign next_state_temp[3] = in & state[2];
	assign next_state_temp[4] = in & state[3];
	assign next_state_temp[5] = in & state[4];
	assign next_state_temp[6] = in & state[5];
	assign next_state_temp[7] = in & (state[6] | state[7]);
	assign next_state_temp[8] = ~in & state[5];
	assign next_state_temp[9] = ~in & state[6];

	always @(posedge clk) begin
		next_state <= next_state_temp;
	end

endmodule
