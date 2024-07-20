module lemming_machine (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	output reg walk_left,
	output reg walk_right,
	output reg aaah
);

	// Define the states
	typedef enum logic [1:0] {
		WALK_LEFT,
		WALK_RIGHT,
		FALL
	} state_t;

	// Flip-flop to store the current state
	reg [1:0] current_state;

	// Next state logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= WALK_LEFT;
		end else begin
			case (current_state)
				WALK_LEFT:
					if (bump_right || (bump_left && !ground))
						current_state <= WALK_RIGHT;
					else if (!ground)
						current_state <= FALL;
				WALK_RIGHT:
					if (bump_left || (bump_right && !ground))
						current_state <= WALK_LEFT;
					else if (!ground)
						current_state <= FALL;
				FALL:
					if (ground)
						current_state <= current_state; // Stay in FALL state
					else if (bump_left || bump_right)
						current_state <= current_state; // Stay in FALL state
					else if (current_state == WALK_LEFT)
						current_state <= WALK_LEFT;
					else if (current_state == WALK_RIGHT)
						current_state <= WALK_RIGHT;
			endcase
		end
	end

	// Output logic
	always @(posedge clk) begin
		case (current_state)
			WALK_LEFT:
				walk_left <= 1;
				walk_right <= 0;
				aaah <= 0;
			WALK_RIGHT:
				walk_left <= 0;
				walk_right <= 1;
				aaah <= 0;
			FALL:
				walk_left <= (current_state == WALK_LEFT) ? 1 : 0;
				walk_right <= (current_state == WALK_RIGHT) ? 1 : 0;
				aaah <= 1;
		endcase
	end

endmodule
