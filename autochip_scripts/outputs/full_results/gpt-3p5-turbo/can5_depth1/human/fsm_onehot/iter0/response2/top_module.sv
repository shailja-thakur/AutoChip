module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);

	// Definitions for states
	parameter S0 = 10'b0000000001; // State 0
	parameter S1 = 10'b0000000010; // State 1
	parameter S2 = 10'b0000000100; // State 2
	parameter S3 = 10'b0000001000; // State 3
	parameter S4 = 10'b0000010000; // State 4
	parameter S5 = 10'b0000100000; // State 5
	parameter S6 = 10'b0001000000; // State 6
	parameter S7 = 10'b0010000000; // State 7
	parameter S8 = 10'b0100000000; // State 8
	parameter S9 = 10'b1000000000; // State 9

	// Output assignments
	assign out1 = (state == S7); // Output 1 is 1 if the current state is S7, otherwise 0
	assign out2 = (state == S9); // Output 2 is 1 if the current state is S9, otherwise 0

	// State transition logic
	always @* begin
		case (state)
			S0: begin
				if (in == 1)     next_state = S1;
				else if (in == 0) next_state = S0;
			end
			S1: begin
				if (in == 1)     next_state = S2;
				else if (in == 0) next_state = S0;
			end
			S2: begin
				if (in == 1)     next_state = S3;
				else if (in == 0) next_state = S0;
			end
			S3: begin
				if (in == 1)     next_state = S4;
				else if (in == 0) next_state = S0;
			end
			S4: begin
				if (in == 1)     next_state = S5;
				else if (in == 0) next_state = S0;
			end
			S5: begin
				if (in == 1)     next_state = S6;
				else if (in == 0) next_state = S8;
			end
			S6: begin
				if (in == 1)     next_state = S7;
				else if (in == 0) next_state = S9;
			end
			S7: begin
				if (in == 1)     next_state = S7;
				else if (in == 0) next_state = S0;
			end
			S8: begin
				if (in == 1)     next_state = S1;
				else if (in == 0) next_state = S0;
			end
			S9: begin
				if (in == 1)     next_state = S1;
				else if (in == 0) next_state = S0;
			end
			default: next_state = S0;
		endcase
	end

endmodule
