module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);

	// Define the state transitions and outputs using combinatorial logic
	always @(*) begin
		// Initialize next_state and outputs to 0
		next_state = 10'b0;
		out1 = 1'b0;
		out2 = 1'b0;

		// State transition and output logic for each state
		case (state)
			10'b0000000001: begin // S0
				if (in == 1'b0) begin
					next_state = 10'b0000000001; // Stay in S0
				end else if (in == 1'b1) begin
					next_state = 10'b0000000010; // Transition to S1
				end
				// Output stays 0
			end

			10'b0000000010: begin // S1
				if (in == 1'b0) begin
					next_state = 10'b0000000001; // Transition to S0
				end else if (in == 1'b1) begin
					next_state = 10'b0000000100; // Transition to S2
				end
				// Output stays 0
			end

			10'b0000000100: begin // S2
				if (in == 1'b0) begin
					next_state = 10'b0000000001; // Transition to S0
				end else if (in == 1'b1) begin
					next_state = 10'b0000001000; // Transition to S3
				end
				// Output stays 0
			end

			10'b0000001000: begin // S3
				if (in == 1'b0) begin
					next_state = 10'b0000000001; // Transition to S0
				end else if (in == 1'b1) begin
					next_state = 10'b0000010000; // Transition to S4
				end
				// Output stays 0
			end

			10'b0000010000: begin // S4
				if (in == 1'b0) begin
					next_state = 10'b0000000001; // Transition to S0
				end else if (in == 1'b1) begin
					next_state = 10'b0000100000; // Transition to S5
				end
				// Output stays 0
			end

			10'b0000100000: begin // S5
				if (in == 1'b0) begin
					next_state = 10'b1000000000; // Transition to S8
				end else if (in == 1'b1) begin
					next_state = 10'b0001000000; // Transition to S6
				end
				// Output stays 0
			end

			10'b0001000000: begin // S6
				if (in == 1'b0) begin
					next_state = 10'b1000000000; // Transition to S8
				end else if (in == 1'b1) begin
					next_state = 10'b0010000000; // Transition to S7
				end
				// Output stays 0
			end

			10'b0010000000: begin // S7
				if (in == 1'b0) begin
					next_state = 10'b0000000001; // Transition to S0
					out2 = 1'b1; // Set output out2 to 1
				end else if (in == 1'b1) begin
					next_state = 10'b0010000000; // Stay in S7
				end
				// Output stays 0
			end

			10'b1000000000: begin // S8
				if (in == 1'b0) begin
					next_state = 10'b0000000001; // Transition to S0
					out1 = 1'b1; // Set output out1 to 1
				end else if (in == 1'b1) begin
					next_state = 10'b0000000010; // Transition to S1
				end
				// Output stays 0
			end

			10'b1010000000: begin // S9
				if (in == 1'b0) begin
					next_state = 10'b0000000001; // Transition to S0
					out1 = 1'b1; // Set output out1 to 1
					out2 = 1'b1; // Set output out2 to 1
				end else if (in == 1'b1) begin
					next_state = 10'b0000000010; // Transition to S1
				end
			end

		endcase
	end

endmodule
