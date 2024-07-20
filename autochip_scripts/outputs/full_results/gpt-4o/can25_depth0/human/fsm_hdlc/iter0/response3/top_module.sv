module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

	// State encoding
	typedef enum logic [2:0] {
		S0,  // Initial state (previous input is considered as 0)
		S1,  // Seen 1
		S2,  // Seen 2 consecutive 1s
		S3,  // Seen 3 consecutive 1s
		S4,  // Seen 4 consecutive 1s
		S5,  // Seen 5 consecutive 1s
		S6,  // Seen 6 consecutive 1s (flag or disc state)
		S7   // Error state (7 or more consecutive 1s)
	} state_t;

	state_t current_state, next_state;

	// Output logic
	always_ff @(posedge clk) begin
		if (reset) begin
			current_state <= S0;
			disc <= 0;
			flag <= 0;
			err <= 0;
		end else begin
			current_state <= next_state;
			
			// Clear output signals
			disc <= 0;
			flag <= 0;
			err <= 0;
			
			case (next_state)
				S6:
					if (in)
						flag <= 1;
					else
						disc <= 1;
				S7:
					err <= 1;
			endcase
		end
	end

	// State transition logic
	always_comb begin
		case (current_state)
			S0: next_state = in ? S1 : S0;
			S1: next_state = in ? S2 : S0;
			S2: next_state = in ? S3 : S0;
			S3: next_state = in ? S4 : S0;
			S4: next_state = in ? S5 : S0;
			S5: next_state = in ? S6 : S0;
			S6: next_state = in ? S7 : S0;
			S7: next_state = in ? S7 : S0;
			default: next_state = S0;
		endcase
	end

endmodule
