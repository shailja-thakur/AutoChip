module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);

	// Define the state encodings
	parameter S0 = 10'b0000000001;
	parameter S1 = 10'b0000000010;
	parameter S2 = 10'b0000000100;
	parameter S3 = 10'b0000001000;
	parameter S4 = 10'b0000010000;
	parameter S5 = 10'b0000100000;
	parameter S6 = 10'b0001000000;
	parameter S7 = 10'b0010000000;
	parameter S8 = 10'b0100000000;
	parameter S9 = 10'b1000000000;

	// State transition logic
	always @* begin
		case (state)
			// Transitions from state S0
			S0: begin
				if (in)
					next_state = S1;
				else
					next_state = S0;
			end

			// Transitions from state S1
			S1: begin
				if (in)
					next_state = S2;
				else
					next_state = S0;
			end

			// Transitions from state S2
			S2: begin
				if (in)
					next_state = S3;
				else
					next_state = S0;
			end

			// Transitions from state S3
			S3: begin
				if (in)
					next_state = S4;
				else
					next_state = S0;
			end

			// Transitions from state S4
			S4: begin
				if (in)
					next_state = S5;
				else
					next_state = S0;
			end

			// Transitions from state S5
			S5: begin
				if (in)
					next_state = S6;
				else
					next_state = S8;
			end

			// Transitions from state S6
			S6: begin
				if (in)
					next_state = S7;
				else
					next_state = S9;
			end

			// Transitions from state S7
			S7: begin
				if (in)
					next_state = S7;
				else
					next_state = S0;
			end

			// Transitions from state S8
			S8: begin
				if (in)
					next_state = S1;
				else
					next_state = S0;
			end

			// Transitions from state S9
			S9: begin
				if (in)
					next_state = S1;
				else
					next_state = S0;
			end
		endcase
	end

	// Output logic
	assign out1 = (state == S7);
	assign out2 = (state == S9);

endmodule
