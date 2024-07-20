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

	// State declarations
	typedef enum logic [2:0] {
		STATE_WALK_LEFT,
		STATE_WALK_RIGHT,
		STATE_FALL_LEFT,
		STATE_FALL_RIGHT,
		STATE_DIG_LEFT,
		STATE_DIG_RIGHT,
		STATE_SPLAT
	} state_t;

	state_t state, next_state;
	logic [4:0] fall_counter; // 5-bit counter to count up to 20

	// Asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= STATE_WALK_LEFT;
			fall_counter <= 0;
		end else begin
			state <= next_state;
			
			// Fall counter logic
			if (state == STATE_FALL_LEFT || state == STATE_FALL_RIGHT) begin
				if (~ground) begin
					if (fall_counter == 20) state <= STATE_SPLAT; // Check splatter condition
					else fall_counter <= fall_counter + 1;
				end else fall_counter <= 0; // Reset counter when hitting the ground
			end else fall_counter <= 0; // Reset counter for all other states
		end
	end

	// Next state logic
	always @(*) begin
		case (state)
			STATE_WALK_LEFT: begin
				if (~ground) next_state = STATE_FALL_LEFT;
				else if (dig) next_state = STATE_DIG_LEFT;
				else if (bump_left) next_state = STATE_WALK_RIGHT;
				else next_state = STATE_WALK_LEFT;
			end

			STATE_WALK_RIGHT: begin
				if (~ground) next_state = STATE_FALL_RIGHT;
				else if (dig) next_state = STATE_DIG_RIGHT;
				else if (bump_right) next_state = STATE_WALK_LEFT;
				else next_state = STATE_WALK_RIGHT;
			end

			STATE_FALL_LEFT: begin
				if (~ground) next_state = STATE_FALL_LEFT;
				else next_state = STATE_WALK_LEFT;
			end

			STATE_FALL_RIGHT: begin
				if (~ground) next_state = STATE_FALL_RIGHT;
				else next_state = STATE_WALK_RIGHT;
			end

			STATE_DIG_LEFT: begin
				if (~ground) next_state = STATE_FALL_LEFT;
				else next_state = STATE_DIG_LEFT;
			end

			STATE_DIG_RIGHT: begin
				if (~ground) next_state = STATE_FALL_RIGHT;
				else next_state = STATE_DIG_RIGHT;
			end

			STATE_SPLAT: begin
				next_state = STATE_SPLAT; // Stay in splat state forever
			end

			default: next_state = STATE_WALK_LEFT;
		endcase
	end

	// Output logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			walk_left <= 1;
			walk_right <= 0;
			aaah <= 0;
			digging <= 0;
		end else begin
			case (state)
				STATE_WALK_LEFT: begin
					walk_left <= 1;
					walk_right <= 0;
					aaah <= 0;
					digging <= 0;
				end

				STATE_WALK_RIGHT: begin
					walk_left <= 0;
					walk_right <= 1;
					aaah <= 0;
					digging <= 0;
				end

				STATE_FALL_LEFT, STATE_FALL_RIGHT: begin
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 1;
					digging <= 0;
				end

				STATE_DIG_LEFT, STATE_DIG_RIGHT: begin
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 0;
					digging <= 1;
				end

				STATE_SPLAT: begin
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 0;
					digging <= 0;
				end

				default: begin
					walk_left <= 1;
					walk_right <= 0;
					aaah <= 0;
					digging <= 0;
				end
			endcase
		end
	end

endmodule
