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
		LEFT = 3'b000,
		RIGHT = 3'b001,
		FALL_LEFT = 3'b010,
		FALL_RIGHT = 3'b011,
		DIG_LEFT = 3'b100,
		DIG_RIGHT = 3'b101,
		SPLATTER = 3'b110
	} fsm_state_t;

	fsm_state_t state, next_state;
	integer fall_count;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= LEFT;
			fall_count <= 0;
			walk_left <= 1;
			walk_right <= 0;
			aaah <= 0;
			digging <= 0;
		end else begin
			state <= next_state;

			case (state)
				FALL_LEFT, FALL_RIGHT: begin
					if (ground) begin
						fall_count <= 0; // Reset fall_count when ground is reached
					end else begin
						fall_count <= fall_count + 1;
					end
				end

				default: begin
					fall_count <= 0;
				end
			endcase
		end
	end

	always @* begin
		next_state = state; // Default state to avoid latches

		case (state)
			LEFT: begin
				if (!ground) begin
					next_state = FALL_LEFT;
				} else if (dig) begin
					next_state = DIG_LEFT;
				} else if (bump_left) begin
					next_state = RIGHT;
				}
			end

			RIGHT: begin
				if (!ground) begin
					next_state = FALL_RIGHT;
				} else if (dig) begin
					next_state = DIG_RIGHT;
				} else if (bump_right) begin
					next_state = LEFT;
				}
			end

			FALL_LEFT: begin
				if (ground) begin
					if (fall_count >= 20) begin
						next_state = SPLATTER;
					} else begin
						next_state = LEFT;
					end
				end
			end

			FALL_RIGHT: begin
				if (ground) begin
					if (fall_count >= 20) begin
						next_state = SPLATTER;
					} else begin
						next_state = RIGHT;
					end
				end
			end

			DIG_LEFT: begin
				if (!ground) begin
					next_state = FALL_LEFT;
				end
			end

			DIG_RIGHT: begin
				if (!ground) begin
					next_state = FALL_RIGHT;
				end
			end

			SPLATTER: begin
				// Remain in this state
			end
		endcase
	end

	always @* begin
		walk_left = 0;
		walk_right = 0;
		aaah = 0;
		digging = 0;

		case (state)
			LEFT: walk_left = 1;
			RIGHT: walk_right = 1;
			FALL_LEFT, FALL_RIGHT: aaah = 1;
			DIG_LEFT: digging = 1;
			DIG_RIGHT: digging = 1;
			SPLATTER: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 0;
				digging = 0;
			end
		endcase
	end

endmodule
