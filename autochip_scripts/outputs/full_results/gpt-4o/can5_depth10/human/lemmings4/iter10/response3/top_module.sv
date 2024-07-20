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

	typedef enum {LEFT, RIGHT, FALL_LEFT, FALL_RIGHT, DIG_LEFT, DIG_RIGHT, SPLAT} state_t;
	state_t state, next_state;
	reg [4:0] fall_counter;

	// Output logic
	always @(*) begin
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
			FALL_LEFT, FALL_RIGHT: begin
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
			SPLAT: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 0;
				digging = 0;
			end
		endcase
	end

	// State transition logic
	always @(*) begin
		case (state)
			LEFT: begin
				if (!ground) next_state = FALL_LEFT;
				else if (dig) next_state = DIG_LEFT;
				else if (bump_left) next_state = RIGHT;
				else next_state = LEFT;
			end
			RIGHT: begin
				if (!ground) next_state = FALL_RIGHT;
				else if (dig) next_state = DIG_RIGHT;
				else if (bump_right) next_state = LEFT;
				else next_state = RIGHT;
			end
			FALL_LEFT, FALL_RIGHT: begin
				if (ground && fall_counter >= 20) next_state = SPLAT;
				else if (ground) next_state = (state == FALL_LEFT) ? LEFT : RIGHT;
				else next_state = state;
			end
			DIG_LEFT, DIG_RIGHT: begin
				if (!ground) next_state = (state == DIG_LEFT) ? FALL_LEFT : FALL_RIGHT;
				else next_state = state;
			end
			SPLAT: begin
				next_state = SPLAT;
			end
			default: begin
				next_state = LEFT;
			end
		endcase
	end

	// State flip-flops with asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= LEFT;
			fall_counter <= 0;
		end
		else begin
			state <= next_state;
			if (!ground && (state == FALL_LEFT || state == FALL_RIGHT)) begin
				if (fall_counter < 20)
					fall_counter <= fall_counter + 1;
			end else if (ground && (state == FALL_LEFT || state == FALL_RIGHT)) begin
                fall_counter <= 0;
            end else begin
                fall_counter <= fall_counter;
            end
		end
	end

endmodule
