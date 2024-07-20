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

	// State encoding
	typedef enum logic [2:0] {
		S_WALK_LEFT = 3'b000,
		S_WALK_RIGHT = 3'b001,
		S_FALL_LEFT = 3'b010,
		S_FALL_RIGHT = 3'b011,
		S_DIG_LEFT = 3'b100,
		S_DIG_RIGHT = 3'b101
	} state_t;

	state_t state, next_state;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= S_WALK_LEFT;
		end else begin
			state <= next_state;
		end
	end

	always @(*) begin
		case (state)
			S_WALK_LEFT: begin
				if (!ground) begin
					next_state = S_FALL_LEFT;
				end else if (dig) begin
					next_state = S_DIG_LEFT;
				end else if (bump_left) begin
					next_state = S_WALK_RIGHT;
				end else begin
					next_state = S_WALK_LEFT;
				end
			end
			
			S_WALK_RIGHT: begin
				if (!ground) begin
					next_state = S_FALL_RIGHT;
				end else if (dig) begin
					next_state = S_DIG_RIGHT;
				end else if (bump_right) begin
					next_state = S_WALK_LEFT;
				end else begin
					next_state = S_WALK_RIGHT;
				end
			end
			
			S_FALL_LEFT: begin
				if (ground) begin
					next_state = S_WALK_LEFT;
				end else begin
					next_state = S_FALL_LEFT;
				end
			end
			
			S_FALL_RIGHT: begin
				if (ground) begin
					next_state = S_WALK_RIGHT;
				end else begin
					next_state = S_FALL_RIGHT;
				end
			end
			
			S_DIG_LEFT: begin
				if (!ground) begin
					next_state = S_FALL_LEFT;
				end else begin
					next_state = S_DIG_LEFT;
				end
			end
			
			S_DIG_RIGHT: begin
				if (!ground) begin
					next_state = S_FALL_RIGHT;
				end else begin
					next_state = S_DIG_RIGHT;
				end
			end
			
			default: begin
				next_state = S_WALK_LEFT;
			end
		endcase
	end

	always @(*) begin
		walk_left = 0;
		walk_right = 0;
		aaah = 0;
		digging = 0;

		case (state)
			S_WALK_LEFT: begin
				walk_left = 1;
			end
			
			S_WALK_RIGHT: begin
				walk_right = 1;
			end
			
			S_FALL_LEFT, S_FALL_RIGHT: begin
				aaah = 1;
			end
			
			S_DIG_LEFT: begin
				digging = 1;
				walk_left = 1;
			end
			
			S_DIG_RIGHT: begin
				digging = 1;
				walk_right = 1;
			end
		endcase
	end

endmodule
