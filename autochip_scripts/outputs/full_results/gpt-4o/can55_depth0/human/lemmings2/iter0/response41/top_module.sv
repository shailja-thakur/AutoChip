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

    // Define states
	typedef enum reg [1:0] {
		WALK_LEFT = 2'b00,
		WALK_RIGHT = 2'b01,
		FALL_LEFT = 2'b10,
		FALL_RIGHT = 2'b11
	} state_t;

	// Current and next state variables
	state_t current_state, next_state;

    // Always block to update state on clock edge or reset
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			// Reset state to WALK_LEFT
			current_state <= WALK_LEFT;
		end
		else begin
			// Update current state
			current_state <= next_state;
		end
	end

    // Always block for state transitions
	always @(*) begin
		case (current_state)
			WALK_LEFT: begin
				if (!ground) next_state = FALL_LEFT;
				else if (bump_left) next_state = WALK_RIGHT;
				else next_state = WALK_LEFT;
			end

			WALK_RIGHT: begin
				if (!ground) next_state = FALL_RIGHT;
				else if (bump_right) next_state = WALK_LEFT;
				else next_state = WALK_RIGHT;
			end

			FALL_LEFT: begin
				if (ground) next_state = WALK_LEFT;
				else next_state = FALL_LEFT;
			end

			FALL_RIGHT: begin
				if (ground) next_state = WALK_RIGHT;
				else next_state = FALL_RIGHT;
			end

			default: next_state = WALK_LEFT;
		endcase
	end

    // Always block for output logic based on current state
	always @(*) begin
		case (current_state)
			WALK_LEFT: begin
				walk_left = 1;
				walk_right = 0;
				aaah = 0;
			end

			WALK_RIGHT: begin
				walk_left = 0;
				walk_right = 1;
				aaah = 0;
			end

			FALL_LEFT, FALL_RIGHT: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 1;
			end

			default: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 0;
			end
		endcase
	end

endmodule
