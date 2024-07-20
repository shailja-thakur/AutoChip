module top_module (
	input in,
	input [9:0] state,
	output reg [9:0] next_state,
	output reg out1,
	output reg out2);

	// State transition logic
	always @(*) begin
		case (1'b1) // The state is one-hot encoded
			state[0]: next_state = in ? 10'b0000000010 : 10'b0000000001; // S0
			state[1]: next_state = in ? 10'b0000000100 : 10'b0000000001; // S1
			state[2]: next_state = in ? 10'b0000001000 : 10'b0000000001; // S2
			state[3]: next_state = in ? 10'b0000010000 : 10'b0000000001; // S3
			state[4]: next_state = in ? 10'b0000100000 : 10'b0000000001; // S4
			state[5]: next_state = in ? 10'b0001000000 : 10'b1000000000; // S5
			state[6]: next_state = in ? 10'b0010000000 : 10'b0100000000; // S6
			state[7]: next_state = in ? 10'b0000001000 : 10'b0000000010; // S7
			state[8]: next_state = in ? 10'b0000000100 : 10'b0000000010; // S8
			state[9]: next_state = in ? 10'b0000000100 : 10'b0000000010; // S9
			default:  next_state = 10'b0000000001;                      // Default (shouldn't happen but handle it)
		endcase
	end

	// Output logic
	always @(*) begin
		out1 = state[8] | state[9]; // S8 or S9 -> out1 = 1
		out2 = state[7] | state[9]; // S7 or S9 -> out2 = 1
	end

endmodule
