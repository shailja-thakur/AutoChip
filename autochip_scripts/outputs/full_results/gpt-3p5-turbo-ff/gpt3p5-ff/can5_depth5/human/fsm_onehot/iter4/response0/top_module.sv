module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);

	// Assign next_state based on current state and input
	always @* begin
		case(state)
			10'b0000000001: next_state = in ? 10'b0000000010 : 10'b0000000001; // S0
			10'b0000000010: next_state = in ? 10'b0000000011 : 10'b0000000001; // S1
			10'b0000000011: next_state = in ? 10'b0000000100 : 10'b0000000001; // S2
			10'b0000000100: next_state = in ? 10'b0000000101 : 10'b0000000001; // S3
			10'b0000000101: next_state = in ? 10'b0000000110 : 10'b0000000001; // S4
			10'b0000000110: next_state = in ? 10'b0000000000 : 10'b0000000111; // S5
			10'b0000000111: next_state = in ? 10'b0000000101 : 10'b0000001000; // S6
			10'b0000001000: next_state = in ? 10'b0000000001 : 10'b0000000001; // S7
			10'b0000001001: next_state = in ? 10'b0000000010 : 10'b0000000001; // S8
			10'b0000001010: next_state = in ? 10'b0000000010 : 10'b0000000001; // S9
			default: next_state = 10'b0000000000;
		endcase
	end

	// Assign outputs based on current state
	always @* begin
		out1 = (state == 10'b0000000110) ? 1'b1 : 1'b0; // S5 output
		out2 = (state == 10'b0000000111) ? 1'b1 : 1'b0; // S6 output
	end

endmodule
