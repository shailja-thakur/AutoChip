module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);

	// Define the states
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

	// Define the next states based on the current state and input
	always @* begin
		case (state)
			S0: begin
				if (in == 1)
					next_state = S1;
				else
					next_state = S0;
			end

			S1: begin
				if (in == 1)
					next_state = S2;
				else
					next_state = S0;
			end

			S2: begin
				if (in == 1)
					next_state = S3;
				else
					next_state = S0;
			end

			S3: begin
				if (in == 1)
					next_state = S4;
				else
					next_state = S0;
			end

			S4: begin
				if (in == 1)
					next_state = S5;
				else
					next_state = S0;
			end

			S5: begin
				if (in == 1)
					next_state = S6;
				else
					next_state = S8;
			end

			S6: begin
				if (in == 1)
					next_state = S7;
				else
					next_state = S9;
			end

			S7: begin
				if (in == 1)
					next_state = S7;
				else
					next_state = S0;
			end

			S8: begin
				if (in == 1)
					next_state = S1;
				else
					next_state = S0;
			end

			S9: begin
				if (in == 1)
					next_state = S1;
				else
					next_state = S0;
			end
		endcase
	end

	// Define the output logic based on the current state
	always @* begin
		case (state)
			S0: begin
				out1 = 0;
				out2 = 0;
			end

			S1: begin
				out1 = 0;
				out2 = 0;
			end

			S2: begin
				out1 = 0;
				out2 = 0;
			end

			S3: begin
				out1 = 0;
				out2 = 0;
			end

			S4: begin
				out1 = 0;
				out2 = 0;
			end

			S5: begin
				out1 = 0;
				out2 = 0;
			end

			S6: begin
				out1 = 0;
				out2 = 0;
			end

			S7: begin
				out1 = 0;
				out2 = 1;
			end

			S8: begin
				out1 = 1;
				out2 = 0;
			end

			S9: begin
				out1 = 1;
				out2 = 1;
			end
		endcase
	end

endmodule
