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
	typedef enum logic [1:0] {
		STATE_WALK_LEFT  = 2'b00,
		STATE_WALK_RIGHT = 2'b01,
		STATE_FALL_LEFT  = 2'b10,
		STATE_FALL_RIGHT = 2'b11
	} state_t;

	state_t state, next_state;

	// State transition logic
	always @(*) begin
		case (state)
			STATE_WALK_LEFT: begin
				if (ground) begin
					if (bump_left) 
						next_state = STATE_WALK_RIGHT;
					else 
						next_state = STATE_WALK_LEFT;
				} else begin
					next_state = STATE_FALL_LEFT;
				end
			end

			STATE_WALK_RIGHT: begin
				if (ground) begin
					if (bump_right) 
						next_state = STATE_WALK_LEFT;
					else 
						next_state = STATE_WALK_RIGHT;
				} else begin
					next_state = STATE_FALL_RIGHT;
				end
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

			default: 
				next_state = STATE_WALK_LEFT;
		endcase
	end

	// State flip-flops
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= STATE_WALK_LEFT;
		else
			state <= next_state;
	end

	// Output logic
	always @(*) begin
		case (state)
			STATE_WALK_LEFT: begin
				walk_left = 1;
				walk_right = 0;
				aaah = 0;
			end

			STATE_WALK_RIGHT: begin
				walk_left = 0;
				walk_right = 1;
				aaah = 0;
			end

			STATE_FALL_LEFT, STATE_FALL_RIGHT: begin
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
