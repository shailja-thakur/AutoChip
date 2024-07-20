module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);

	// State transition logic
	always @* begin
		case(state)
			10'b0000000001: next_state = 10'b0000000001;   // S0 -> S0 (0)
			10'b0000000001: next_state = 10'b0000000010;   // S0 -> S1 (1)
			10'b0000000010: next_state = 10'b0000000001;   // S1 -> S0 (0)
			10'b0000000010: next_state = 10'b0000000100;   // S1 -> S2 (1)
			10'b0000000100: next_state = 10'b0000000001;   // S2 -> S0 (0)
			10'b0000000100: next_state = 10'b0000001000;   // S2 -> S3 (1)
			10'b0000001000: next_state = 10'b0000000001;   // S3 -> S0 (0)
			10'b0000001000: next_state = 10'b0000010000;   // S3 -> S4 (1)
			10'b0000010000: next_state = 10'b0000000001;   // S4 -> S0 (0)
			10'b0000010000: next_state = 10'b0000100000;   // S4 -> S5 (1)
			10'b0000100000: next_state = 10'b0001000000;   // S5 -> S8 (0)
			10'b0000100000: next_state = 10'b0010000000;   // S5 -> S6 (1)
			10'b0010000000: next_state = 10'b0010100000;   // S6 -> S9 (0)
			10'b0010000000: next_state = 10'b0001000000;   // S6 -> S7 (1)
			10'b0001000000: next_state = 10'b0000000001;   // S7 -> S0 (0)
			10'b0001000000: next_state = 10'b0001000000;   // S7 -> S7 (1)
			10'b0001000000: next_state = 10'b0100000000;   // S8 -> S0 (0)
			10'b0001000000: next_state = 10'b0000000010;   // S8 -> S1 (1)
			10'b0010100000: next_state = 10'b0100000000;   // S9 -> S0 (0)
			10'b0010100000: next_state = 10'b0000000010;   // S9 -> S1 (1)
			default: next_state = 10'b0000000000;
		endcase
	end


	// Output logic
	assign out1 = (state[0] | state[2] | state[3] | state[5] | state[6] | state[7]);
	assign out2 = (state[7]);

endmodule
