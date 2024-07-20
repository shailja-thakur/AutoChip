module top_module (
	input in,
	input [9:0] state,
	output reg [9:0] next_state,
	output reg out1,
	output reg out2);

	always @(*) begin
		// Default to zero for all outputs
		next_state = 10'b0;
		out1 = 1'b0;
		out2 = 1'b0;

		case (1'b1) // sythesize casez for one-hot encoding
			state[0]: next_state = in ? 10'b0000000010 : 10'b0000000001;
			state[1]: next_state = in ? 10'b0000000100 : 10'b0000000001;
			state[2]: next_state = in ? 10'b0000001000 : 10'b0000000001;
			state[3]: next_state = in ? 10'b0000010000 : 10'b0000000001;
			state[4]: next_state = in ? 10'b0000100000 : 10'b0000000001;
			state[5]: next_state = in ? 10'b0001000000 : 10'b1000000000;
			state[6]: next_state = in ? 10'b0010000000 : 10'b0100000000;
			state[7]: begin
				next_state = in ? 10'b0000000000 : 10'b0000000001;
				out2 = 1'b1; // Set out2 in state S7 when transitioning
			end
			state[8]: begin
				next_state = in ? 10'b0000000010 : 10'b0000000001;
				out1 = 1'b1; // Set out1 in state S8 when transitioning
			end
			state[9]: begin
				next_state = in ? 10'b0000000010 : 10'b0000000001;
				out1 = 1'b1; // Set out1 in state S9 when transitioning
				out2 = 1'b1; // Set out2 in state S9 when transitioning
			end
			default: next_state = 10'b0000000001; // Default to S0 state
		endcase
	end
endmodule
