module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);

	// Define intermediate signals for the next state
	wire [9:0] next_state_temp;

	// Define intermediate signals for the outputs
	wire out1_temp;
	wire out2_temp;

	// Implement the state transition logic
	always @* begin
		case (state)
			10'b0000000001: next_state_temp = 10'b0000000001; // S0 (0, 0) --0--> S0
			10'b0000000001: next_state_temp = 10'b0000000010; // S0 (0, 0) --1--> S1
			10'b0000000010: next_state_temp = 10'b0000000001; // S1 (0, 0) --0--> S0
			10'b0000000010: next_state_temp = 10'b0000000011; // S1 (0, 0) --1--> S2
			10'b0000000011: next_state_temp = 10'b0000000001; // S2 (0, 0) --0--> S0
			10'b0000000011: next_state_temp = 10'b0000000100; // S2 (0, 0) --1--> S3
			10'b0000000100: next_state_temp = 10'b0000000001; // S3 (0, 0) --0--> S0
			10'b0000000100: next_state_temp = 10'b0000000101; // S3 (0, 0) --1--> S4
			10'b0000000101: next_state_temp = 10'b0000000001; // S4 (0, 0) --0--> S0
			10'b0000000101: next_state_temp = 10'b0000000110; // S4 (0, 0) --1--> S5
			10'b0000000110: next_state_temp = 10'b0000001000; // S5 (0, 0) --0--> S8
			10'b0000000110: next_state_temp = 10'b0000000111; // S5 (0, 0) --1--> S6
			10'b0000000111: next_state_temp = 10'b0000001001; // S6 (0, 0) --0--> S9
			10'b0000000111: next_state_temp = 10'b0000001010; // S6 (0, 0) --1--> S7
			10'b0000001010: next_state_temp = 10'b0000000001; // S7 (0, 1) --0--> S0
			10'b0000001010: next_state_temp = 10'b0000001010; // S7 (0, 1) --1--> S7
			10'b0000001000: next_state_temp = 10'b0000000001; // S8 (1, 0) --0--> S0
			10'b0000001000: next_state_temp = 10'b0000000010; // S8 (1, 0) --1--> S1
			10'b0000001001: next_state_temp = 10'b0000000001; // S9 (1, 1) --0--> S0
			10'b0000001001: next_state_temp = 10'b0000000010; // S9 (1, 1) --1--> S1
			default: next_state_temp = 10'b1111111111; // Default state is an error state
		endcase
	end

	// Implement the output logic
	always @* begin
		case (state)
			10'b0000000110: begin // S5
				out1_temp = 1'b0;
				out2_temp = 1'b0;
			end
			10'b0000001010: begin // S7
				out1_temp = in;
				out2_temp = 1'b0;
			end
			10'b0000000101: begin // S4
				out1_temp = 1'b0;
				out2_temp = 1'b0;
			end
			10'b0000001000: begin // S8
				out1_temp = 1'b1;
				out2_temp = 1'b0;
			end
			10'b0000001001: begin // S9
				out1_temp = 1'b1;
				out2_temp = 1'b1;
			end
			default: begin
				out1_temp = 1'b0;
				out2_temp = 1'b0;
			end
		endcase
	end

	// Assign outputs
	assign next_state = next_state_temp;
	assign out1 = out1_temp;
	assign out2 = out2_temp;

endmodule
