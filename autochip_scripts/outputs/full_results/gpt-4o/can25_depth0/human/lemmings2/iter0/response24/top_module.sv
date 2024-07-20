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
		LEFT = 3'b000,
		RIGHT = 3'b001,
		FALL_LEFT = 3'b010,
		FALL_RIGHT = 3'b011,
		FALL = 3'b100
	} state_t;

	state_t state, next_state;

	// State transition logic
	always @(*) begin
		case (state)
			// Walking left
			LEFT: begin
				if (ground == 0) 
					next_state = FALL_LEFT;
				else if (bump_left)
					next_state = RIGHT;
				else
					next_state = LEFT;
			end

			// Walking right
			RIGHT: begin
				if (ground == 0)
					next_state = FALL_RIGHT;
				else if (bump_right)
					next_state = LEFT;
				else
					next_state = RIGHT;
			end

			// Falling from left
			FALL_LEFT: begin
				if (ground == 1)
					next_state = LEFT;
				else
					next_state = FALL_LEFT;
			end

			// Falling from right
			FALL_RIGHT: begin
				if (ground == 1)
					next_state = RIGHT;
				else
					next_state = FALL_RIGHT;
			end

			// Default fall state
			default: next_state = LEFT;
		endcase
	end

	// State flip-flops with asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= LEFT;
		else
			state <= next_state;
	end

	// Output logic
	always @(*) begin
		case (state)
			LEFT: begin
				walk_left = 1;
				walk_right = 0;
				aaah = 0;
			end
			RIGHT: begin
				walk_left = 0;
				walk_right = 1;
				aaah = 0;
			end
			FALL_LEFT: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 1;
			end
			FALL_RIGHT: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 1;
			end
			default: begin
				walk_left = 1;
				walk_right = 0;
				aaah = 0;
			end
		endcase
	end

endmodule
