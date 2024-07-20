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
	typedef enum logic [1:0] {
		IDLE,      // Idle state
		WALK_LEFT, // Walking left state
		WALK_RIGHT // Walking right state
	} state_t;

	// Declare registers for storing state, direction and digging flag
	reg state_t current_state, next_state;
	reg direction; // 0 for left, 1 for right
	reg digging;

	// Define the outputs
	assign walk_left = (current_state == WALK_LEFT);
	assign walk_right = (current_state == WALK_RIGHT);
	assign aaah = (current_state != WALK_LEFT && current_state != WALK_RIGHT);
	assign digging = (current_state == IDLE && ground && dig);

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			// Asynchronous reset, set initial state and direction
			current_state <= WALK_LEFT;
			direction <= 0;
		end else begin
			// Sequential logic for state transitions
			current_state <= next_state;
			direction <= (current_state == WALK_LEFT) ? 0 : 1;
		end
	end

	always @(current_state, direction, bump_left, bump_right, ground, dig) begin
		case (current_state)
			IDLE: begin
				if (bump_left && !bump_right && ground) begin
					// Bumped on the left, switch to walking right
					next_state = WALK_RIGHT;
				end else if (!bump_left && bump_right && ground) begin
					// Bumped on the right, switch to walking left
					next_state = WALK_LEFT;
				end else if (ground) begin
					// Still on the ground, stay in idle state
					next_state = IDLE;
				end else if (!ground) begin
					// Ground disappeared, fall and switch to the previous direction
					next_state = (direction == 0) ? WALK_LEFT : WALK_RIGHT;
				end
			end

			WALK_LEFT: begin
				if (bump_left && !bump_right && ground) begin
					// Bumped on the left, switch to walking right
					next_state = WALK_RIGHT;
				end else if (!bump_left && !bump_right && !ground) begin
					// Ground disappeared, fall and stay in walking left state
					next_state = WALK_LEFT;
				end else if (ground && !digging) begin
					// Ground reappeared, continue walking left
					next_state = WALK_LEFT;
				end else if (ground && digging) begin
					// Ground reappeared, start digging
					next_state = IDLE;
				end
			end

			WALK_RIGHT: begin
				if (!bump_left && bump_right && ground) begin
					// Bumped on the right, switch to walking left
					next_state = WALK_LEFT;
				end else if (!bump_left && !bump_right && !ground) begin
					// Ground disappeared, fall and stay in walking right state
					next_state = WALK_RIGHT;
				end else if (ground && !digging) begin
					// Ground reappeared, continue walking right
					next_state = WALK_RIGHT;
				end else if (ground && digging) begin
					// Ground reappeared, start digging
					next_state = IDLE;
				end
			end
		endcase
	end

endmodule
