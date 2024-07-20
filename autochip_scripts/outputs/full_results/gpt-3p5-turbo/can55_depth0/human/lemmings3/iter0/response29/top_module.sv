module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	input dig,
	output walk_left,
	output walk_right,
	output aaah,
	output digging
);

	// Define the states of the finite state machine
	typedef enum logic [2:0] {
		WALK_LEFT,
		WALK_RIGHT,
		FALLING_LEFT,
		FALLING_RIGHT,
		DIGGING_LEFT,
		DIGGING_RIGHT
	} state_type;

	reg state_type state, next_state;

	// Define the outputs of the finite state machine
	reg walk_left, walk_right, aaah, digging;

	// Implement the finite state machine
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= WALK_LEFT;
			walk_left <= 1;
			walk_right <= 0;
			aaah <= 0;
			digging <= 0;
		end else begin
			state <= next_state;
			walk_left <= (state == WALK_LEFT) ? 1 : 0;
			walk_right <= (state == WALK_RIGHT) ? 1 : 0;
			aaah <= ((state == FALLING_LEFT || state == FALLING_RIGHT) && ground) ? 1 : 0;
			digging <= (state == DIGGING_LEFT || state == DIGGING_RIGHT) ? 1 : 0;
		end
	end

	always @(state, bump_left, bump_right, ground, dig) begin
		case (state)
			WALK_LEFT:
				if (bump_right)
					next_state = WALK_RIGHT;
				else if (!ground)
					next_state = FALLING_LEFT;
				else if (dig)
					next_state = (bump_left) ? WALK_RIGHT : DIGGING_LEFT;
				else
					next_state = WALK_LEFT;
			WALK_RIGHT:
				if (bump_left)
					next_state = WALK_LEFT;
				else if (!ground)
					next_state = FALLING_RIGHT;
				else if (dig)
					next_state = (bump_right) ? WALK_LEFT : DIGGING_RIGHT;
				else
					next_state = WALK_RIGHT;
			FALLING_LEFT:
				if (ground)
					next_state = WALK_LEFT;
				else if (dig)
					next_state = (bump_left) ? WALK_RIGHT : DIGGING_LEFT;
				else
					next_state = FALLING_LEFT;
			FALLING_RIGHT:
				if (ground)
					next_state = WALK_RIGHT;
				else if (dig)
					next_state = (bump_right) ? WALK_LEFT : DIGGING_RIGHT;
				else
					next_state = FALLING_RIGHT;
			DIGGING_LEFT:
				if (!ground)
					next_state = FALLING_LEFT;
				else if (dig)
					next_state = (bump_left) ? WALK_RIGHT : DIGGING_LEFT;
				else
					next_state = DIGGING_LEFT;
			DIGGING_RIGHT:
				if (!ground)
					next_state = FALLING_RIGHT;
				else if (dig)
					next_state = (bump_right) ? WALK_LEFT : DIGGING_RIGHT;
				else
					next_state = DIGGING_RIGHT;
		endcase
	end

endmodule
