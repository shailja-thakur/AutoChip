module top_module (
	input in,
	input [9:0] state,
	output reg [9:0] next_state,
	output reg out1,
	output reg out2);

	always @(*) begin
		// Initialize next_state and outputs
		next_state = 10'b0000000000;
		out1 = 0;
		out2 = 0;

		case (1'b1)  // when set one of the state bits is set
			state[0]: begin
				if (in) next_state = 10'b0000000010;  // S1
				else next_state = 10'b0000000001;     // S0
			end
			state[1]: begin
				if (in) next_state = 10'b0000000100;  // S2
				else next_state = 10'b0000000001;     // S0
			end
			state[2]: begin
				if (in) next_state = 10'b0000001000;  // S3
				else next_state = 10'b0000000001;     // S0
			end
			state[3]: begin
				if (in) next_state = 10'b0000010000;  // S4
				else next_state = 10'b0000000001;     // S0
			end
			state[4]: begin
				if (in) next_state = 10'b0000100000;  // S5
				else next_state = 10'b0000000001;     // S0
			end
			state[5]: begin
				if (in) next_state = 10'b0001000000;  // S6
				else next_state = 10'b1000000000;     // S8
			end
			state[6]: begin
				if (in) next_state = 10'b0010000000;  // S7
				else next_state = 10'b0100000000;     // S9
			end
			state[7]: begin
				out2 = 1;
				if (in) next_state = 10'b0010000000;  // S7
				else next_state = 10'b0000000001;     // S0
			end
			state[8]: begin
				out1 = 1;
				if (in) next_state = 10'b0000000010;  // S1
				else next_state = 10'b0000000001;     // S0
			end
			state[9]: begin
				out1 = 1;
				out2 = 1;
				if (in) next_state = 10'b0000000010;  // S1
				else next_state = 10'b0000000001;     // S0
			end
			default: next_state = 10'b0000000001; // Default to S0
		endcase
	end
endmodule
