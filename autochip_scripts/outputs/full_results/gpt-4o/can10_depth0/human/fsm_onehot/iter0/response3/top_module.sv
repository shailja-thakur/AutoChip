module top_module (
	input in,
	input [9:0] state,
	output reg [9:0] next_state,
	output reg out1,
	output reg out2);

	// Combinational logic for next state
	always @(*) begin
		next_state = 10'b0; // Default: no state transitions
		out1 = 0;
		out2 = 0;

		case (1'b1) // Case statement to handle one-hot encoding
			state[0]: next_state = in ? 10'b0000000010 : 10'b0000000001;
			state[1]: next_state = in ? 10'b0000000100 : 10'b0000000001;
			state[2]: next_state = in ? 10'b0000001000 : 10'b0000000001;
			state[3]: next_state = in ? 10'b0000010000 : 10'b0000000001;
			state[4]: next_state = in ? 10'b0000100000 : 10'b0000000001;
			state[5]: next_state = in ? 10'b0001000000 : 10'b1000000000;
			state[6]: next_state = in ? 10'b0010000000 : 10'b0100000000;
			state[7]: next_state = in ? 10'b0000000000 : 10'b0000000001;
			state[8]: next_state = in ? 10'b0000000010 : 10'b0000000001;
			state[9]: next_state = in ? 10'b0000000010 : 10'b0000000001;
			default: next_state = 10'b0000000001; // Default to state S0
		endcase
		
		// Output logic
		if (state[7]) begin
			out2 = 1;
		end
		if (state[8]) begin
			out1 = 1;
		end
		if (state[9]) begin
			out1 = 1;
			out2 = 1;
		end
	end
endmodule
