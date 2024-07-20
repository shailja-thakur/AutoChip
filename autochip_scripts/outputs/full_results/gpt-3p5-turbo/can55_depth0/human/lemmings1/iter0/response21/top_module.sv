module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);
	// Define states
	typedef enum logic [1:0] {
		STATE_WALK_LEFT,
		STATE_WALK_RIGHT
	} state_t;

	// Define the state register and initialize it to STATE_WALK_LEFT
	reg state_t current_state = STATE_WALK_LEFT;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			// Reset to the initial state
			current_state <= STATE_WALK_LEFT;
		end else begin
			// State transition logic
			case (current_state)
				STATE_WALK_LEFT: begin
					if (bump_right) begin
						current_state <= STATE_WALK_RIGHT;
					end
				end
				STATE_WALK_RIGHT: begin
					if (bump_left) begin
						current_state <= STATE_WALK_LEFT;
					end
				end
			endcase
		end
	end

	// Output logic
	always_comb begin
		case (current_state)
			STATE_WALK_LEFT: begin
				walk_left = 1;
				walk_right = 0;
			end
			STATE_WALK_RIGHT: begin
				walk_left = 0;
				walk_right = 1;
			end
		endcase
	end
endmodule
