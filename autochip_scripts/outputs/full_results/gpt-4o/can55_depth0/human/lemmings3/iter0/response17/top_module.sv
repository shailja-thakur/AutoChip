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
	typedef enum reg [2:0] {
		WALK_LEFT = 3'd0,
		WALK_RIGHT = 3'd1,
		FALL_LEFT = 3'd2,
		FALL_RIGHT = 3'd3,
		DIG_LEFT = 3'd4,
		DIG_RIGHT = 3'd5
	} state_t;

	state_t current_state, next_state;

	// State transition logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= WALK_LEFT; // Reset to walking left
		end else begin
			current_state <= next_state;
		end
	end

	// Next state logic
	always @(*) begin
		case (current_state)
			WALK_LEFT: begin
				if (~ground) begin
					next_state = FALL_LEFT;
				} else if (dig) begin
					next_state = DIG_LEFT;
				} else if (bump_left | bump_right) begin
					next_state = WALK_RIGHT;
				} else begin
					next_state = WALK_LEFT;
				}
			end

			WALK_RIGHT: begin
				if (~ground) begin
					next_state = FALL_RIGHT;
				} else if (dig) begin
					next_state = DIG_RIGHT;
				} else if (bump_left | bump_right) begin
					next_state = WALK_LEFT;
				} else begin
					next_state = WALK_RIGHT;
				}
			end

			FALL_LEFT: begin
				if (ground) begin
					next_state = WALK_LEFT;
				} else begin
					next_state = FALL_LEFT;
				}
			end

			FALL_RIGHT: begin
				if (ground) begin
					next_state = WALK_RIGHT;
				} else begin
					next_state = FALL_RIGHT;
				}
			end

			DIG_LEFT: begin
				if (~ground) begin
					next_state = FALL_LEFT;
				} else begin
					next_state = DIG_LEFT;
				}
			end

			DIG_RIGHT: begin
				if (~ground) begin
					next_state = FALL_RIGHT;
				} else begin
					next_state = DIG_RIGHT;
				}
			end

			default: next_state = WALK_LEFT;
		endcase
	end

	// Output logic
	always @(*) begin
		// Default outputs
		walk_left = 1'b0;
		walk_right = 1'b0;
		aaah = 1'b0;
		digging = 1'b0;

		case (current_state)
			WALK_LEFT: begin
				walk_left = 1'b1;
			end
			WALK_RIGHT: begin
				walk_right = 1'b1;
			end
			FALL_LEFT, FALL_RIGHT: begin
				aaah = 1'b1;
			end
			DIG_LEFT, DIG_RIGHT: begin
				digging = 1'b1;
			end
		endcase
	end

endmodule
