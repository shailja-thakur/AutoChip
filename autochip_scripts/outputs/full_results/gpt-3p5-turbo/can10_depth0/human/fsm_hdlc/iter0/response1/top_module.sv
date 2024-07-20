module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	// Define states
	typedef enum logic [2:0] {
		S0, // Initial state
		S1, // Detecting 1st '0' after a sequence of '1's
		S2, // Detected 5 consecutive '1's, waiting for '0'
		S3, // Detected '0', checking if 7 or more '1's follow
		S4 // Detected 7 or more consecutive '1's
	} state_t;

	// Declare state and next state variables
	state_t state, next_state;

	// Flip-flop to store the previous input
	reg prev_in;

	// Combinational logic to detect transitions and determine next state and outputs
	always_comb begin
		// Default next state is current state
		next_state = state;

		// Default outputs are all low
		disc = 0;
		flag = 0;
		err = 0;

		case (state)
			S0:
				if (in && !prev_in) begin
					next_state = S1;
				end
			S1:
				if (!in && prev_in) begin
					next_state = S2;
				end
			S2:
				if (!in && prev_in) begin
					next_state = S1;
					flag = 1;
				end
				else if (in && !prev_in) begin
					next_state = S3;
				end
			S3:
				if (in && !prev_in) begin
					next_state = S4;
					err = 1;
				end
				else if (!in && prev_in) begin
					next_state = S2;
					disc = 1;
				end
			S4:
				if (in && !prev_in) begin
					next_state = S4;
					err = 1;
				end
				else if (!in && prev_in) begin
					next_state = S2;
					disc = 1;
				end
		endcase

	end

	// Sequential logic to update state and store previous input
	always_ff @(posedge clk) begin
		if (reset) begin
			state <= S0;
			prev_in <= 1'b0;
		end
		else begin
			state <= next_state;
			prev_in <= in;
		end
	end
	
endmodule
