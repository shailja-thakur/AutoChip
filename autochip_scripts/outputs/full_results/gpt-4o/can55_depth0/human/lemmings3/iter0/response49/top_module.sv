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

	// Define states
	typedef enum reg [2:0] {
		STATE_WALK_LEFT,
		STATE_WALK_RIGHT,
		STATE_FALLING_LEFT,
		STATE_FALLING_RIGHT,
		STATE_DIGGING_LEFT,
		STATE_DIGGING_RIGHT
	} state_t;
	
	state_t state, next_state;

	// State transition logic
	always @(*) begin
		case (state)
			STATE_WALK_LEFT: begin
				if (!ground)
					next_state = STATE_FALLING_LEFT;
				else if (dig)
					next_state = STATE_DIGGING_LEFT;
				else if (bump_left)
					next_state = STATE_WALK_RIGHT;
				else
					next_state = STATE_WALK_LEFT;
			end
			STATE_WALK_RIGHT: begin
				if (!ground)
					next_state = STATE_FALLING_RIGHT;
				else if (dig)
					next_state = STATE_DIGGING_RIGHT;
				else if (bump_right)
					next_state = STATE_WALK_LEFT;
				else
					next_state = STATE_WALK_RIGHT;
			end
			STATE_FALLING_LEFT: begin
				if (ground)
					next_state = STATE_WALK_LEFT;
				else
					next_state = STATE_FALLING_LEFT;
			end
			STATE_FALLING_RIGHT: begin
				if (ground)
					next_state = STATE_WALK_RIGHT;
				else
					next_state = STATE_FALLING_RIGHT;
			end
			STATE_DIGGING_LEFT: begin
				if (!ground)
					next_state = STATE_FALLING_LEFT;
				else
					next_state = STATE_DIGGING_LEFT;
			end
			STATE_DIGGING_RIGHT: begin
				if (!ground)
					next_state = STATE_FALLING_RIGHT;
				else
					next_state = STATE_DIGGING_RIGHT;
			end
			default: next_state = STATE_WALK_LEFT;
		endcase
	end

	// State flip-flops with asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= STATE_WALK_LEFT;
		else
			state <= next_state;
	end

	// Output logic
	always @(*) begin
		// Default values
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
			STATE_FALLING_LEFT: begin
				aaah = 1;
			end
			STATE_FALLING_RIGHT: begin
				aaah = 1;
			end
			STATE_DIGGING_LEFT: begin
				digging = 1;
			end
			STATE_DIGGING_RIGHT: begin
				digging = 1;
			end
		endcase
	end

endmodule
