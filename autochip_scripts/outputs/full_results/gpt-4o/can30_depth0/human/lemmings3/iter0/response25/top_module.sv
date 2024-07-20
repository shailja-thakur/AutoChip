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
		LEFT     = 3'b000, // Walking left
		RIGHT    = 3'b001, // Walking right
		FALL     = 3'b010, // Falling
		DIG_LEFT = 3'b011, // Digging left
		DIG_RIGHT= 3'b100  // Digging right
	} state_t;

	// State variables
	state_t state, next_state;

	// Output logic
	always_comb begin
		case (state)
			LEFT: begin
				walk_left = 1;
				walk_right = 0;
				aaah = 0;
				digging = 0;
			end
			RIGHT: begin
				walk_left = 0;
				walk_right = 1;
				aaah = 0;
				digging = 0;
			end
			FALL: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 1;
				digging = 0;
			end
			DIG_LEFT: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 0;
				digging = 1;
			end
			DIG_RIGHT: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 0;
				digging = 1;
			end
			default: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 0;
				digging = 0;
			end
		endcase
	end

	// Next state logic
	always_comb begin
		case (state)
			LEFT: begin
				if (!ground) begin
					next_state = FALL;
				} else if (dig) begin
					next_state = DIG_LEFT;
				} else if (bump_left) begin
					next_state = RIGHT;
				} else begin
					next_state = LEFT;
				}
			end
			RIGHT: begin
				if (!ground) begin
					next_state = FALL;
				} else if (dig) begin
					next_state = DIG_RIGHT;
				} else if (bump_right) begin
					next_state = LEFT;
				} else begin
					next_state = RIGHT;
				}
			end
			FALL: begin
				if (ground) begin
					if (state == LEFT || state == DIG_LEFT) begin
						next_state = LEFT;
					} else if (state == RIGHT || state == DIG_RIGHT) begin
						next_state = RIGHT;
					}
				end else begin
					next_state = FALL;
				}
			end
			DIG_LEFT: begin
				if (!ground) begin
					next_state = FALL;
				} else begin
					next_state = DIG_LEFT;
				}
			end
			DIG_RIGHT: begin
				if (!ground) begin
					next_state = FALL;
				} else begin
					next_state = DIG_RIGHT;
				}
			end
			default: begin
				next_state = LEFT;
			end
		endcase
	end

	// State transition
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= LEFT;
		} else begin
			state <= next_state;
		end
	end

endmodule
