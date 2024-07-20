module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);

	// State transition logic
	always @(state or in) begin
		case(state)
			10'b1_000_000_000: next_state = 10'b1_000_000_000;  // S0 (0, 0) --0--> S0
			10'b1_000_000_000: next_state = 10'b1_000_000_001;  // S0 (0, 0) --1--> S1
			10'b0_100_000_000: next_state = 10'b1_000_000_000;  // S1 (0, 0) --0--> S0
			10'b0_100_000_000: next_state = 10'b0_010_000_000;  // S1 (0, 0) --1--> S2
			10'b0_010_000_000: next_state = 10'b1_000_000_000;  // S2 (0, 0) --0--> S0
			10'b0_010_000_000: next_state = 10'b0_001_000_000;  // S2 (0, 0) --1--> S3
			10'b0_001_000_000: next_state = 10'b1_000_000_000;  // S3 (0, 0) --0--> S0
			10'b0_001_000_000: next_state = 10'b0_000_100_000;  // S3 (0, 0) --1--> S4
			10'b0_000_100_000: next_state = 10'b1_000_000_000;  // S4 (0, 0) --0--> S0
			10'b0_000_100_000: next_state = 10'b0_000_010_000;  // S4 (0, 0) --1--> S5
			10'b0_000_010_000: next_state = 10'b0_000_000_001;  // S5 (0, 0) --0--> S8
			10'b0_000_010_000: next_state = 10'b0_000_000_010;  // S5 (0, 0) --1--> S6
			10'b0_000_000_100: next_state = 10'b0_000_000_001;  // S6 (0, 0) --0--> S9
			10'b0_000_000_100: next_state = 10'b0_000_000_100;  // S6 (0, 0) --1--> S7
			10'b0_000_000_010: next_state = 10'b1_000_000_000;  // S7 (0, 1) --0--> S0
			10'b0_000_000_010: next_state = 10'b0_000_000_010;  // S7 (0, 1) --1--> S7
			10'b0_000_000_001: next_state = 10'b1_000_000_000;  // S8 (1, 0) --0--> S0
			10'b0_000_000_001: next_state = 10'b1_000_000_001;  // S8 (1, 0) --1--> S1
			10'b0_000_000_001: next_state = 10'b1_000_000_000;  // S9 (1, 1) --0--> S0
			10'b0_000_000_001: next_state = 10'b0_000_000_001;  // S9 (1, 1) --1--> S1
			default: next_state = 10'b0;  // Default case (should not occur)
		endcase
	end

	// Output logic
	assign out1 = (state[7] | state[8]);  // Combine bits 7 and 8 for out1
	assign out2 = state[6];  // Use bit 6 for out2

endmodule
