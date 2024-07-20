module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	input dig,
	output walk_left,
	output walk_right,
	output aaah,
	output digging
);

	// State definition
	typedef enum logic [1:0] {
		WALK_LEFT,
		WALK_RIGHT,
		FALL,
		DIG,
		SPLATTER
	} state_t;

	reg state_t current_state;
	reg state_t next_state;

	// Outputs
	reg walk_left;
	reg walk_right;
	reg aaah;
	reg digging;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= WALK_LEFT;
		end else begin
			current_state <= next_state;
		end
	end

	always @(current_state or bump_left or bump_right or ground or dig) begin
		case (current_state)
			WALK_LEFT:
				begin
					walk_left <= 1;
					walk_right <= 0;
					aaah <= 0;
					digging <= 0;

					if (bump_right) begin
						next_state <= WALK_RIGHT;
					end else if (!ground) begin
						next_state <= FALL;
					end else if (dig) begin
						next_state <= DIG;
					end
				end

			WALK_RIGHT:
				begin
					walk_left <= 0;
					walk_right <= 1;
					aaah <= 0;
					digging <= 0;

					if (bump_left) begin
						next_state <= WALK_LEFT;
					end else if (!ground) begin
						next_state <= FALL;
					end else if (dig) begin
						next_state <= DIG;
					end
				end

			FALL:
				begin
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 1;
					digging <= 0;

					if (ground) begin
						next_state <= current_state;
					end else if (dig) begin
						next_state <= DIG;
					end else if (current_state == FALL && !ground) begin
						next_state <= SPLATTER;
					end
				end

			DIG:
				begin
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 0;
					digging <= 1;

					if (!ground) begin
						next_state <= FALL;
					end else if (current_state == DIG && !dig) begin
						next_state <= current_state;
					end
				end

			SPLATTER:
				begin
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 0;
					digging <= 0;

					next_state <= SPLATTER;
				end
		endcase
	end

endmodule
