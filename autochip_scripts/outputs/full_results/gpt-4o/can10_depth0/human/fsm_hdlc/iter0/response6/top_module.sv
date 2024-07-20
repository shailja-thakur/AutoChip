module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

	// State Encoding
	typedef enum logic [3:0] {
		S0, S1, S2, S3, S4, S5, S6, S7, S8
	} state_t;
	
	state_t state, next_state;

	// State Register
	always_ff @(posedge clk) begin
		if (reset)
			state <= S0;
		else
			state <= next_state;
	end

	// Next State Logic
	always_comb begin
		case (state)
			S0: next_state = in ? S1 : S0;
			S1: next_state = in ? S2 : S0;
			S2: next_state = in ? S3 : S0;
			S3: next_state = in ? S4 : S0;
			S4: next_state = in ? S5 : S0;
			S5: next_state = in ? S6 : S0;
			S6: next_state = in ? S8 : (in ? S1 : S7);
			S7: next_state = in ? S1 : S0;
			S8: next_state = in ? S8 : S8; // Error state
			default: next_state = S0;
		endcase
	end

	// Output Logic
	always_ff @(posedge clk) begin
		if (reset) begin
			disc <= 0;
			flag <= 0;
			err <= 0;
		end else begin
			case (state)
				S0: begin
					disc <= 0;
					flag <= 0;
					err <= 0;
				end
				S5: disc <= (in ? 1 : 0); // 0111110: This means you will discard the next bit (which is zero)
				S6: flag <= (in ? 1 : 0); // 01111110: This means a flag detection
				S8: err <= (in ? 1 : 0);  // Error state for 7 or more consecutive 1s
				default: begin
					disc <= 0;
					flag <= 0;
					err <= 0;
				end
			endcase
		end
	end
endmodule
