module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);

	always @(*) begin
		// Default all next state values to 0
		next_state = 10'b0000000000;
		
		case (state)
			10'b0000000001: next_state = in ? 10'b0000000010 : 10'b0000000001; // S0
			10'b0000000010: next_state = in ? 10'b0000000100 : 10'b0000000001; // S1
			10'b0000000100: next_state = in ? 10'b0000001000 : 10'b0000000001; // S2
			10'b0000001000: next_state = in ? 10'b0000010000 : 10'b0000000001; // S3
			10'b0000010000: next_state = in ? 10'b0000100000 : 10'b0000000001; // S4
			10'b0000100000: next_state = in ? 10'b0001000000 : 10'b1000000000; // S5
			10'b0001000000: next_state = in ? 10'b0010000000 : 10'b0100000000; // S6
			10'b0010000000: next_state = in ? 10'b0010000000 : 10'b0000000001; // S7
			10'b0100000000: next_state = in ? 10'b0000000010 : 10'b0000000001; // S8
			10'b1000000000: next_state = in ? 10'b0000000010 : 10'b0000000001; // S9
			default: next_state = 10'b0000000001; // Undefined state, default to S0
		endcase
	end

	assign out1 = state[8] | state[9]; // S8 or S9
	assign out2 = state[6] | state[9]; // S7 or S9

endmodule
