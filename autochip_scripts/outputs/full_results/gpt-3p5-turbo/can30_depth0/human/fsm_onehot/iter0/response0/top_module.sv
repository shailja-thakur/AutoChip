module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);
	
	assign out1 = (state[7] || state[8]) && !state[5];
	assign out2 = state[6] && !state[7];
	
	always @* begin
		case (state)
			10'b0000000001: next_state = 10'b0000000001; // S0 (0, 1) --1--> S0
			10'b0000000010: next_state = 10'b0000000110; // S0 (0, 1) --0--> S1
			10'b0000000110: next_state = 10'b0000000001; // S1 (0, 0) --1--> S0
			10'b0000000011: next_state = 10'b0000001000; // S1 (0, 1) --0--> S2
			10'b0000001000: next_state = 10'b0000000001; // S2 (0, 0) --1--> S0
			10'b0000000100: next_state = 10'b0000010000; // S2 (0, 1) --0--> S3
			10'b0000010000: next_state = 10'b0000000001; // S3 (0, 0) --1--> S0
			10'b0000001000: next_state = 10'b0000100000; // S3 (0, 1) --0--> S4
			10'b0000100000: next_state = 10'b0000000001; // S4 (0, 0) --1--> S0
			10'b0000010000: next_state = 10'b0001000010; // S4 (0, 1) --0--> S5
			10'b0001000010: next_state = 10'b0010000000; // S5 (0, 0) --1--> S8
			10'b0100000000: next_state = 10'b0000000010; // S5 (1, 0) --0--> S6
			10'b0000010000: next_state = 10'b0000000010; // S5 (0, 1) --0--> S6
			10'b0000000010: next_state = 10'b0100000000; // S6 (0, 0) --1--> S9
			10'b0100000000: next_state = 10'b1000000000; // S6 (1, 0) --0--> S0
			10'b1000000000: next_state = 10'b0000000001; // S7 (0, 0) --1--> S0
			10'b1010000000: next_state = 10'b1010000000; // S7 (0, 1) --0--> S7
			10'b1000000000: next_state = 10'b0000000110; // S8 (1, 0) --0--> S1
			10'b1000000001: next_state = 10'b0000000001; // S8 (1, 0) --1--> S0
			10'b1010000000: next_state = 10'b0000000110; // S9 (1, 1) --0--> S1
			10'b1010000001: next_state = 10'b0000000001; // S9 (1, 1) --1--> S0
			default: next_state = 10'b0000000000; // default case
		endcase
	end

endmodule
