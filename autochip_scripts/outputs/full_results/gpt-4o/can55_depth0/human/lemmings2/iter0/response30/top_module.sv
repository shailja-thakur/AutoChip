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
	typedef enum logic [2:0] {
		WALK_LEFT   = 3'b000, 
		WALK_RIGHT  = 3'b001,
		FALL_LEFT   = 3'b010,
		FALL_RIGHT  = 3'b011
	} state_t;
	
	state_t state, next_state;

	// State transition logic
	always @(*) begin
		case (state)
			WALK_LEFT: begin
				if (!ground)
					next_state = FALL_LEFT;
				else if (bump_left)
					next_state = WALK_RIGHT;
				else
					next_state = WALK_LEFT;
			end
			WALK_RIGHT: begin
				if (!ground)
					next_state = FALL_RIGHT;
				else if (bump_right)
					next_state = WALK_LEFT;
				else
					next_state = WALK_RIGHT;
			end
			FALL_LEFT: begin
				if (ground)
					next_state = WALK_LEFT;
				else
					next_state = FALL_LEFT;
			end
			FALL_RIGHT: begin
				if (ground)
					next_state = WALK_RIGHT;
				else
					next_state = FALL_RIGHT;
			end
			default: next_state = WALK_LEFT;
		endcase
	end

	// State flip-flops with asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= WALK_LEFT;
		else
			state <= next_state;
	end

	// Output logic
	always @(*) begin
		walk_left  = (state == WALK_LEFT);
		walk_right = (state == WALK_RIGHT);
		aaah       = (state == FALL_LEFT || state == FALL_RIGHT);
	end

endmodule
