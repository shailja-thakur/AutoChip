module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	output walk_left,
	output walk_right,
	output reg aaah
);

	// State encoding
	typedef enum logic[2:0] {
		LEFT         = 3'b000,
		RIGHT        = 3'b001,
		FALLING_LEFT = 3'b010,
		FALLING_RIGHT = 3'b011,
		FALLING      = 3'b100
	} state_t;

	state_t state, next_state;

	// State transitions
	always_ff @(posedge clk or posedge areset) begin
		if (areset)
			state <= LEFT;
		else
			state <= next_state;
	end

	// Next state logic
	always_comb begin
		case (state)
			LEFT: begin
				if (!ground)
					next_state = FALLING_LEFT;
				else if (bump_left)
					next_state = RIGHT;
				else
					next_state = LEFT;
			end
			
			RIGHT: begin
				if (!ground)
					next_state = FALLING_RIGHT;
				else if (bump_right)
					next_state = LEFT;
				else
					next_state = RIGHT;
			end
			
			FALLING_LEFT: begin
				if (ground)
					next_state = LEFT;
				else
					next_state = FALLING_LEFT;
			end
			
			FALLING_RIGHT: begin
				if (ground)
					next_state = RIGHT;
				else
					next_state = FALLING_RIGHT;
			end
			
			// Generic FALLING state to handle both falling conditions
			FALLING: begin
				if (ground)
					next_state = state_is_left_before_fall ? LEFT : RIGHT;
				else
					next_state = FALLING;
			end
			
			default: next_state = LEFT; // Default state
		endcase
	end

	// Output logic
	assign walk_left = (state == LEFT);
	assign walk_right = (state == RIGHT);
	always_comb begin
		aaah = (state == FALLING) || (state == FALLING_LEFT) || (state == FALLING_RIGHT);
	end

	// Handle state memory of direction before fall
	logic state_is_left_before_fall;
	always_ff @(posedge clk or posedge areset) begin
		if (areset)
			state_is_left_before_fall <= 1;
		else if (state == LEFT || state == RIGHT)
			state_is_left_before_fall <= (state == LEFT);
	end

endmodule
