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
		STATE_WALK_LEFT = 3'b000,
		STATE_WALK_RIGHT = 3'b001,
		STATE_DIGGER_LEFT = 3'b010,
		STATE_DIGGER_RIGHT = 3'b011,
		STATE_FALL_LEFT = 3'b100,
		STATE_FALL_RIGHT = 3'b101,
		STATE_SPLATTER = 3'b110
	} state_t;

	state_t current_state, next_state;
	reg [4:0] fall_count; // Counter to track falls for splatter condition

	// State transition logic
	always @(*) begin
		case (current_state)
			STATE_WALK_LEFT: begin
				if (!ground) begin
					next_state = STATE_FALL_LEFT;
				} else if (dig) begin
					next_state = STATE_DIGGER_LEFT;
				} else if (bump_left || bump_right) begin
					next_state = STATE_WALK_RIGHT;
				} else begin
					next_state = STATE_WALK_LEFT;
				}
			end
			
			STATE_WALK_RIGHT: begin
				if (!ground) begin
					next_state = STATE_FALL_RIGHT;
				} else if (dig) begin
					next_state = STATE_DIGGER_RIGHT;
				} else if (bump_left || bump_right) begin
					next_state = STATE_WALK_LEFT;
				} else begin
					next_state = STATE_WALK_RIGHT;
				}
			end
			
			STATE_DIGGER_LEFT: begin
				if (!ground) begin
					next_state = STATE_FALL_LEFT;
				} else begin
					next_state = STATE_DIGGER_LEFT;
				}
			end
			
			STATE_DIGGER_RIGHT: begin
				if (!ground) begin
					next_state = STATE_FALL_RIGHT;
				} else begin
					next_state = STATE_DIGGER_RIGHT;
				}
			end
	
			STATE_FALL_LEFT: begin
				if (ground) begin
					if (fall_count > 20) begin
						next_state = STATE_SPLATTER;
					} else begin
						next_state = STATE_WALK_LEFT;
					}
				} else begin
					next_state = STATE_FALL_LEFT;
				}
			end

			STATE_FALL_RIGHT: begin
				if (ground) begin
					if (fall_count > 20) begin
						next_state = STATE_SPLATTER;
					} else begin
						next_state = STATE_WALK_RIGHT;
					}
				} else begin
					next_state = STATE_FALL_RIGHT;
				}
			end

			STATE_SPLATTER: begin
				next_state = STATE_SPLATTER;
			end

			default: begin
				next_state = STATE_WALK_LEFT;
			end
		endcase
	end

	// State flip-flops
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= STATE_WALK_LEFT;
			fall_count <= 0;
		end else begin
			current_state <= next_state;
			if (current_state == STATE_FALL_LEFT || current_state == STATE_FALL_RIGHT) begin
				fall_count <= fall_count + 1;
			end else begin
				fall_count <= 0;
			end
		end
	end

	// Output logic
	always @(*) begin
		// Default values
		walk_left = 0;
		walk_right = 0;
		aaah = 0;
		digging = 0;

		case (current_state)
			STATE_WALK_LEFT: begin
				walk_left = 1;
			end
			STATE_WALK_RIGHT: begin
				walk_right = 1;
			end
			STATE_DIGGER_LEFT: begin
				digging = 1;
				walk_left = 1;
			end
			STATE_DIGGER_RIGHT: begin
				digging = 1;
				walk_right = 1;
			end
			STATE_FALL_LEFT: begin
				aaah = 1;
			end
			STATE_FALL_RIGHT: begin
				aaah = 1;
			end
			STATE_SPLATTER: begin
				// All outputs already set to 0
			end
		endcase
	end

endmodule
