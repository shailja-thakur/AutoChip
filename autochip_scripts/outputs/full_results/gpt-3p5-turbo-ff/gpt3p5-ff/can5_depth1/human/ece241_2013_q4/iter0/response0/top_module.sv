module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);
	// Define states for the state machine
	typedef enum logic [1:0] {
		STATE_ABOVE_S3,
		STATE_BETWEEN_S3_S2,
		STATE_BETWEEN_S2_S1,
		STATE_BELOW_S1
	} state_t;
	
	reg state_reg; // Current state register
	reg next_state_reg; // Next state register for synchronous update
	
	// Initialize state registers
	initial begin
		state_reg = STATE_BELOW_S1;
		next_state_reg = STATE_BELOW_S1;
	end
	
	// Update the next state based on current state and sensor inputs
	always @(posedge clk) begin
		if (reset) begin
			state_reg <= STATE_BELOW_S1; // Reset state to STATE_BELOW_S1
			next_state_reg <= STATE_BELOW_S1;
		end else begin
			state_reg <= next_state_reg;
			case (state_reg)
				STATE_ABOVE_S3:
					if (s[3])
						next_state_reg <= STATE_ABOVE_S3;
					else if (s[2] && s[1])
						next_state_reg <= STATE_BETWEEN_S3_S2;
					else if (s[1])
						next_state_reg <= STATE_BETWEEN_S2_S1;
					else
						next_state_reg <= STATE_BELOW_S1;
				STATE_BETWEEN_S3_S2:
					if (s[3])
						next_state_reg <= STATE_ABOVE_S3;
					else if (s[1])
						next_state_reg <= STATE_BETWEEN_S2_S1;
					else
						next_state_reg <= STATE_BELOW_S1;
				STATE_BETWEEN_S2_S1:
					if (s[2] && s[1])
						next_state_reg <= STATE_BETWEEN_S2_S1;
					else if (!s[1])
						next_state_reg <= STATE_BELOW_S1;
					else
						next_state_reg <= STATE_ABOVE_S3;
				STATE_BELOW_S1:
					if (!s[1])
						next_state_reg <= STATE_BELOW_S1;
					else if (s[3])
						next_state_reg <= STATE_ABOVE_S3;
					else if (s[2] && s[1])
						next_state_reg <= STATE_BETWEEN_S3_S2;
					else if (s[1])
						next_state_reg <= STATE_BETWEEN_S2_S1;
			endcase
		end
	end
	
	// Output logic based on current state
	always @* begin
		case (state_reg)
			STATE_ABOVE_S3:
				fr3 = 0;
				fr2 = 0;
				fr1 = 0;
				dfr = 0;
			STATE_BETWEEN_S3_S2:
				fr3 = 0;
				fr2 = 0;
				fr1 = 1;
				dfr = 0;
			STATE_BETWEEN_S2_S1:
				fr3 = 0;
				fr2 = 1;
				fr1 = 1;
				dfr = 0;
			STATE_BELOW_S1:
				fr3 = 1;
				fr2 = 1;
				fr1 = 1;
				dfr = 0;
		endcase
	end
endmodule
