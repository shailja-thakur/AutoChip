module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);
	
	// State transition logic
	always @*
	begin
		case(state)
			10'b0000000001: next_state = 10'b0000000001; // S0 (0, 0) --0--> S0
			10'b0000000001: next_state = 10'b0000000010; // S0 (0, 0) --1--> S1
			10'b0000000010: next_state = 10'b0000000001; // S1 (0, 0) --0--> S0
			10'b0000000010: next_state = 10'b0000000011; // S1 (0, 0) --1--> S2
			10'b0000000011: next_state = 10'b0000000001; // S2 (0, 0) --0--> S0
			10'b0000000011: next_state = 10'b0000000100; // S2 (0, 0) --1--> S3
			10'b0000000100: next_state = 10'b0000000001; // S3 (0, 0) --0--> S0
			10'b0000000100: next_state = 10'b0000000101; // S3 (0, 0) --1--> S4
			10'b0000000101: next_state = 10'b0000000001; // S4 (0, 0) --0--> S0
			10'b0000000101: next_state = 10'b0000000110; // S4 (0, 0) --1--> S5
			10'b0000000110: next_state = 10'b0000001000; // S5 (0, 0) --0--> S8
			10'b0000000110: next_state = 10'b0000000111; // S5 (0, 0) --1--> S6
			10'b0000000111: next_state = 10'b0000001001; // S6 (0, 0) --0--> S9
			10'b0000000111: next_state = 10'b0000001000; // S6 (0, 0) --1--> S7
			10'b0000001000: next_state = 10'b0000000001; // S7 (0, 1) --0--> S0
			10'b0000001000: next_state = 10'b0000001000; // S7 (0, 1) --1--> S7
			10'b0000001001: next_state = 10'b0000000001; // S8 (1, 0) --0--> S0
			10'b0000001001: next_state = 10'b0000000010; // S8 (1, 0) --1--> S1
			10'b0000001010: next_state = 10'b0000000001; // S9 (1, 1) --0--> S0
			10'b0000001010: next_state = 10'b0000000010; // S9 (1, 1) --1--> S1
			default: next_state = 10'b0000000000;
		endcase
	end

	// Output logic
	assign out1 = (state == 10'b0000000110) ? 1'b1 : 1'b0; // Output out1 is 1 only in state S5
	assign out2 = (state == 10'b0000000111) ? 1'b1 : 1'b0; // Output out2 is 1 only in state S6

endmodule
