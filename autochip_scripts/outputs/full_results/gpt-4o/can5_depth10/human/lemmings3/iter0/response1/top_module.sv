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

	typedef enum reg [2:0] {
		WALK_LEFT = 3'd0,
		WALK_RIGHT = 3'd1,
		FALL_LEFT = 3'd2,
		FALL_RIGHT = 3'd3,
		DIG_LEFT = 3'd4,
		DIG_RIGHT = 3'd5
	} state_t;

	reg [2:0] state, next_state;

	always @(*) begin
		case (state)
			WALK_LEFT: begin
				if (!ground) 
					next_state = FALL_LEFT;        // Falling takes precedence
				else if (dig)
					next_state = DIG_LEFT;         // Digging takes next precedence
				else if (bump_left) 
					next_state = WALK_RIGHT;
				else 
					next_state = WALK_LEFT;        // Continue walking left
			end
			WALK_RIGHT: begin
				if (!ground)
					next_state = FALL_RIGHT;       // Falling takes precedence
				else if (dig)
					next_state = DIG_RIGHT;        // Digging takes next precedence
				else if (bump_right) 
					next_state = WALK_LEFT;
				else 
					next_state = WALK_RIGHT;       // Continue walking right
			end
			FALL_LEFT: begin
				if (ground)
					next_state = WALK_LEFT;        // Resume walking left once on ground
				else 
					next_state = FALL_LEFT;        // Continue falling
			end
			FALL_RIGHT: begin
				if (ground)
					next_state = WALK_RIGHT;       // Resume walking right once on ground
				else 
					next_state = FALL_RIGHT;       // Continue falling
			end
			DIG_LEFT: begin
				if (!ground)
					next_state = FALL_LEFT;        // Fall after finishing digging
				else 
					next_state = DIG_LEFT;         // Continue digging left
			end
			DIG_RIGHT: begin
				if (!ground)
					next_state = FALL_RIGHT;       // Fall after finishing digging
				else 
					next_state = DIG_RIGHT;        // Continue digging right
			end
			default: next_state = WALK_LEFT;       // Default state
		endcase
	end

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= WALK_LEFT;
		end
		else begin
			state <= next_state;
		end
	end

	always @(*) begin
		walk_left = (state == WALK_LEFT);
		walk_right = (state == WALK_RIGHT);
		aaah = (state == FALL_LEFT) || (state == FALL_RIGHT);
		digging = (state == DIG_LEFT) || (state == DIG_RIGHT);
	end

endmodule
