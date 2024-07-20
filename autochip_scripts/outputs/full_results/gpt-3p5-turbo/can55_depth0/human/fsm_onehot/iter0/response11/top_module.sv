module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);

	// State transition logic
	always @(*) begin
		case (state)
			10'b0100000000: next_state = 10'b0100000000; // S0 (0, 0) --0--> S0
			10'b0100000000: next_state = 10'b0110000000; // S0 (0, 0) --1--> S1
			10'b0110000000: next_state = 10'b0100000000; // S1 (0, 0) --0--> S0
			10'b0110000000: next_state = 10'b0100000000; // S1 (0, 0) --1--> S2
			10'b0100000000: next_state = 10'b0100000000; // S2 (0, 0) --0--> S0
			10'b0100000000: next_state = 10'b0100000000; // S2 (0, 0) --1--> S3
			10'b0100000000: next_state = 10'b0100000000; // S3 (0, 0) --0--> S0
			10'b0100000000: next_state = 10'b0100000000; // S3 (0, 0) --1--> S4
			10'b0100000000: next_state = 10'b0100000000; // S4 (0, 0) --0--> S0
			10'b0100000000: next_state = 10'b0100000000; // S4 (0, 0) --1--> S5
			10'b0100000000: next_state = 10'b0000000100; // S5 (0, 0) --0--> S8
			10'b0100000000: next_state = 10'b0000000010; // S5 (0, 0) --1--> S6
			10'b0000000010: next_state = 10'b0000001000; // S6 (0, 0) --0--> S9
			10'b0000000010: next_state = 10'b0000000100; // S6 (0, 0) --1--> S7
			10'b0000000100: next_state = 10'b0100000000; // S7 (0, 1) --0--> S0
			10'b0000000100: next_state = 10'b0000000100; // S7 (0, 1) --1--> S7
			10'b0000001000: next_state = 10'b0100000000; // S8 (1, 0) --0--> S0
			10'b0000001000: next_state = 10'b0110000000; // S8 (1, 0) --1--> S1
			10'b0000000101: next_state = 10'b0100000000; // S9 (1, 1) --0--> S0
			10'b0000000101: next_state = 10'b0110000000; // S9 (1, 1) --1--> S1
			default: next_state = 10'b0000000000;
		endcase
	end

	// Output logic
	assign out1 = (state[2] || state[3] || state[5] || state[9]) ? 1'b1 : 1'b0; // Output 1 logic
	assign out2 = state[6] ? 1'b1 : 1'b0; // Output 2 logic

endmodule
