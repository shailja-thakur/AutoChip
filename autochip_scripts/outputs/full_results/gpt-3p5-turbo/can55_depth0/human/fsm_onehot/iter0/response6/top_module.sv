module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);
	
	// state transition logic
	always @(*) begin
		case (state)
			10'b1_000_000_000: next_state = 10'b1_000_000_000; // S0 (0, 0) --0--> S0
			10'b1_000_000_000: next_state = 10'b1_000_000_001; // S0 (0, 0) --1--> S1
			10'b0_100_000_000: next_state = 10'b1_000_000_000; // S1 (0, 0) --0--> S0
			10'b0_100_000_000: next_state = 10'b0_000_000_010; // S1 (0, 0) --1--> S2
			10'b0_001_000_000: next_state = 10'b1_000_000_000; // S2 (0, 0) --0--> S0
			10'b0_001_000_000: next_state = 10'b0_000_100_000; // S2 (0, 0) --1--> S3
			10'b0_000_100_000: next_state = 10'b1_000_000_000; // S3 (0, 0) --0--> S0
			10'b0_000_100_000: next_state = 10'b0_000_001_000; // S3 (0, 0) --1--> S4
			10'b0_000_010_000: next_state = 10'b1_000_000_000; // S4 (0, 0) --0--> S0
			10'b0_000_010_000: next_state = 10'b0_000_000_001; // S4 (0, 0) --1--> S5
			10'b0_000_000_100: next_state = 10'b0_000_001_000; // S5 (0, 0) --0--> S8
			10'b0_000_000_100: next_state = 10'b0_000_100_000; // S5 (0, 0) --1--> S6
			10'b0_000_000_010: next_state = 10'b0_000_010_000; // S6 (0, 0) --0--> S9
			10'b0_000_000_010: next_state = 10'b0_000_000_100; // S6 (0, 0) --1--> S7
			10'b0_000_000_001: next_state = 10'b1_000_000_000; // S7 (0, 1) --0--> S0
			10'b0_000_000_001: next_state = 10'b0_000_000_001; // S7 (0, 1) --1--> S7
			10'b0_000_001_000: next_state = 10'b1_000_000_000; // S8 (1, 0) --0--> S0
			10'b0_000_001_000: next_state = 10'b1_000_000_001; // S8 (1, 0) --1--> S1
			10'b0_000_000_001: next_state = 10'b1_000_000_000; // S9 (1, 1) --0--> S0
			10'b0_000_000_001: next_state = 10'b1_000_000_001; // S9 (1, 1) --1--> S1
			default: next_state = 10'b0; // default case for unknown state
		endcase
	end

	// output logic
	assign out1 = (state[7] || state[8]); // out1 is high when in S7 or S8
	assign out2 = state[6]; // out2 is high when in S7

endmodule
