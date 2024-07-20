module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	input dig,
	output reg walk_left,
	output reg walk_right,
	output reg aaah,
	output reg digging
);

	// State definition
	typedef enum logic [2:0] {
		STATE_WALK_LEFT = 3'b000,
		STATE_WALK_RIGHT = 3'b001,
		STATE_FALL = 3'b010,
		STATE_DIG_LEFT = 3'b011,
		STATE_DIG_RIGHT = 3'b100
	} state_t;

	state_t state, next_state;

	// Output logic based on state
	always_comb begin
		// Default outputs
		walk_left = 0;
		walk_right = 0;
		aaah = 0;
		digging = 0;

		case (state)
			STATE_WALK_LEFT: begin
				walk_left = 1;
			end
			STATE_WALK_RIGHT: begin
				walk_right = 1;
			end
			STATE_FALL: begin
				aaah = 1;
			end
			STATE_DIG_LEFT: begin
				digging = 1;
			end
			STATE_DIG_RIGHT: begin
				digging = 1;
			end
		endcase
	end

	// State transition logic
	always_comb begin
		next_state = state; // Default to holding state to prevent latches

		case (state)
			STATE_WALK_LEFT: begin
				if (!ground)
					next_state = STATE_FALL;
				else if (dig && ground)
					next_state = STATE_DIG_LEFT;
				else if (bump_left)
					next_state = STATE_WALK_RIGHT;
			end
			STATE_WALK_RIGHT: begin
				if (!ground)
					next_state = STATE_FALL;
				else if (dig && ground)
					next_state = STATE_DIG_RIGHT;
				else if (bump_right)
					next_state = STATE_WALK_LEFT;
			end
			STATE_FALL: begin
				if (ground) begin
					if (state == STATE_FALL && prev_state == STATE_WALK_LEFT)
						next_state = STATE_WALK_LEFT;
					else if (state == STATE_FALL && prev_state == STATE_WALK_RIGHT)
						next_state = STATE_WALK_RIGHT;
				end
			end
			STATE_DIG_LEFT: begin
				if (!ground)
					next_state = STATE_FALL;
			end
			STATE_DIG_RIGHT: begin
				if (!ground)
					next_state = STATE_FALL;
			end
		endcase
	end

	// State register with asynchronous reset
	always_ff @(posedge clk or posedge areset) begin
		if (areset)
			state <= STATE_WALK_LEFT;
		else
			state <= next_state;
	end

endmodule
