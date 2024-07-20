module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);

	// State transition logic
	always @*
	begin
		if (state[0] && !in)
			next_state = 10'b000000001;
		else if (state[1] && !in)
			next_state = 10'b000000010;
		else if (state[2] && !in)
			next_state = 10'b000000100;
		else if (state[3] && !in)
			next_state = 10'b000001000;
		else if (state[4] && !in)
			next_state = 10'b000010000;
		else if (state[5] && !in)
			next_state = 10'b000100000;
		else if (state[6] && !in)
			next_state = 10'b001000000;
		else if (state[7] && !in)
			next_state = 10'b010000000;
		else if (state[8] && !in)
			next_state = 10'b100000001;
		else if (state[9] && !in)
			next_state = 10'b000000010;
		else if (state[0] && in)
			next_state = 10'b000000010;
		else if (state[1] && in)
			next_state = 10'b000000100;
		else if (state[2] && in)
			next_state = 10'b000001000;
		else if (state[3] && in)
			next_state = 10'b000010000;
		else if (state[4] && in)
			next_state = 10'b000100000;
		else if (state[5] && in)
			next_state = 10'b001000000;
		else if (state[6] && in)
			next_state = 10'b010000000;
		else if (state[7] && in)
			next_state = 10'b100000000;
		else if (state[8] && in)
			next_state = 10'b000000001;
		else if (state[9] && in)
			next_state = 10'b000000010;
		else
			next_state = 10'b000000000;
	end

	// Output logic
	assign out1 = (state[7] && !state[0]) ? 1'b1 : 1'b0;
	assign out2 = (state[9] && !state[7]) ? 1'b1 : 1'b0;

endmodule
