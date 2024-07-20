module top_module (
	input in,
	input [9:0] state,
	output reg [9:0] next_state,
	output reg out1,
	output reg out2
);

	always @(*) begin
		// Default output values
		out1 = 0;
		out2 = 0;

		// Default next state value
		next_state = 10'b0;

		case (1'b1) // one-hot encoding: only one bit of 'state' is 1
			state[0]: next_state = in ? 10'b0000000010 : 10'b0000000001;
			state[1]: next_state = in ? 10'b0000000100 : 10'b0000000001;
			state[2]: next_state = in ? 10'b0000001000 : 10'b0000000001;
			state[3]: next_state = in ? 10'b0000010000 : 10'b0000000001;
			state[4]: next_state = in ? 10'b0000100000 : 10'b0000000001;
			state[5]: next_state = in ? 10'b0001000000 : 10'b0010000000;
			state[6]: next_state = in ? 10'b0100000000 : 10'b1000000000;
			state[7]: begin
				next_state = in ? 10'b0000000000 : 10'b0000000001;
				out2 = 1; // S7 output
			end
			state[8]: begin
				next_state = in ? 10'b0000000010 : 10'b0000000001;
				out1 = 1; // S8 output
			end
			state[9]: begin
				next_state = in ? 10'b0000000010 : 10'b0000000001;
				out1 = 1; // S9 output
				out2 = 1;
			end
			default: next_state = 10'b0000000001; // Reset to S0 in case of an error
		endcase
	end

endmodule
