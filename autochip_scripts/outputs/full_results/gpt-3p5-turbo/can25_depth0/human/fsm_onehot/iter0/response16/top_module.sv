module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);
	
	// State transition logic
	always @* begin
		case (state)
			10'b01_000_000: next_state = 10'b01_000_000; // S0 (0, 0) --0--> S0
			10'b01_000_000: next_state = 10'b10_000_000; // S0 (0, 0) --1--> S1
			10'b10_000_000: next_state = 10'b01_000_000; // S1 (0, 0) --0--> S0
			10'b10_000_000: next_state = 10'b11_000_000; // S1 (0, 0) --1--> S2
			10'b11_000_000: next_state = 10'b01_000_000; // S2 (0, 0) --0--> S0
			10'b11_000_000: next_state = 10'b11_000_000; // S2 (0, 0) --1--> S3
			10'b11_000_000: next_state = 10'b01_000_000; // S3 (0, 0) --0--> S0
			10'b11_000_000: next_state = 10'b11_000_000; // S3 (0, 0) --1--> S4
			10'b01_000_000: next_state = 10'b01_000_000; // S4 (0, 0) --0--> S0
			10'b01_000_000: next_state = 10'b01_000_000; // S4 (0, 0) --1--> S5
			10'b01_000_000: next_state = 10'b00_000_001; // S5 (0, 0) --0--> S8
			10'b01_000_000: next_state = 10'b00_000_010; // S5 (0, 0) --1--> S6
			10'b00_000_010: next_state = 10'b00_000_100; // S6 (0, 0) --0--> S9
			10'b00_000_010: next_state = 10'b00_000_111; // S6 (0, 0) --1--> S7
			10'b00_000_111: next_state = 10'b01_000_000; // S7 (0, 1) --0--> S0
			10'b00_000_111: next_state = 10'b00_000_111; // S7 (0, 1) --1--> S7
			10'b00_000_001: next_state = 10'b01_000_000; // S8 (1, 0) --0--> S0
			10'b00_000_001: next_state = 10'b10_000_000; // S8 (1, 0) --1--> S1
			10'b00_111_111: next_state = 10'b01_000_000; // S9 (1, 1) --0--> S0
			10'b00_111_111: next_state = 10'b10_000_000; // S9 (1, 1) --1--> S1
			default: next_state = 10'b0; // Default case, should not occur
		endcase
	end
	
	// Output logic
	assign out1 = (state == 10'b00_000_001) ? 1'b1 : 1'b0; // S8 (1, 0)
	assign out2 = (state == 10'b00_000_111) ? 1'b1 : 1'b0; // S7 (0, 1)
	
endmodule
