module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	output reg walk_left,
	output reg walk_right,
	output reg aaah
);
	// State encoding
	typedef enum reg [2:0] {
		STATE_WALK_LEFT = 3'b001,
		STATE_WALK_RIGHT = 3'b010,
		STATE_FALL_LEFT = 3'b101,
		STATE_FALL_RIGHT = 3'b110
	} state_t;

	state_t current_state, next_state;

	// State transition logic
	always @(*) begin
		case (current_state)
			STATE_WALK_LEFT: begin
				if (!ground)
					next_state = STATE_FALL_LEFT;
				else if (bump_left)
					next_state = STATE_WALK_RIGHT;
				else
					next_state = STATE_WALK_LEFT;
			end

			STATE_WALK_RIGHT: begin
				if (!ground)
					next_state = STATE_FALL_RIGHT;
				else if (bump_right)
					next_state = STATE_WALK_LEFT;
				else
					next_state = STATE_WALK_RIGHT;
			end

			STATE_FALL_LEFT: begin
				if (ground)
					next_state = STATE_WALK_LEFT;
				else
					next_state = STATE_FALL_LEFT;
			end

			STATE_FALL_RIGHT: begin
				if (ground)
					next_state = STATE_WALK_RIGHT;
				else
					next_state = STATE_FALL_RIGHT;
			end

			default: begin
				next_state = STATE_WALK_LEFT; // Should not happen, default to walking left.
			end
		endcase
	end

	// State flip-flops with asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset)
			current_state <= STATE_WALK_LEFT;
		else
			current_state <= next_state;
		end
	// Output logic
	always @(*) begin
		// Default values
		walk_left = 0;
		walk_right = 0;
		aaah = 0;

		case (current_state)
			STATE_WALK_LEFT: walk_left = 1;
			STATE_WALK_RIGHT: walk_right = 1;
			STATE_FALL_LEFT: aaah = 1;
			STATE_FALL_RIGHT: aaah = 1;
		endcase
	end
endmodule
