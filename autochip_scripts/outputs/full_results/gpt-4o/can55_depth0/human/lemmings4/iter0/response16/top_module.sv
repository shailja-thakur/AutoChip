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

	// States
	typedef enum logic [2:0] {
		STATE_WALK_LEFT = 3'b000,
		STATE_WALK_RIGHT = 3'b001,
		STATE_FALL_LEFT = 3'b010,
		STATE_FALL_RIGHT = 3'b011,
		STATE_DIG_LEFT = 3'b100,
		STATE_DIG_RIGHT = 3'b101,
		STATE_SPLATTER = 3'b110
	} state_t;

	state_t state, next_state;
	reg [4:0] fall_counter; // 5-bit counter for counting up to 20

	// State transition logic
	always @(*) begin
		case (state)
			STATE_WALK_LEFT: begin
				if (!ground) next_state = STATE_FALL_LEFT;
				else if (dig) next_state = STATE_DIG_LEFT;
				else if (bump_left) next_state = STATE_WALK_RIGHT;
				else next_state = STATE_WALK_LEFT;
			end
			STATE_WALK_RIGHT: begin
				if (!ground) next_state = STATE_FALL_RIGHT;
				else if (dig) next_state = STATE_DIG_RIGHT;
				else if (bump_right) next_state = STATE_WALK_LEFT;
				else next_state = STATE_WALK_RIGHT;
			end
			STATE_FALL_LEFT: begin
				if (ground) 
					if (fall_counter > 20) next_state = STATE_SPLATTER;
					else next_state = STATE_WALK_LEFT;
				else next_state = STATE_FALL_LEFT;
			end
			STATE_FALL_RIGHT: begin
				if (ground) 
					if (fall_counter > 20) next_state = STATE_SPLATTER;
					else next_state = STATE_WALK_RIGHT;
				else next_state = STATE_FALL_RIGHT;
			end
			STATE_DIG_LEFT: begin
				if (!ground) next_state = STATE_FALL_LEFT;
				else next_state = STATE_DIG_LEFT;
			end
			STATE_DIG_RIGHT: begin
				if (!ground) next_state = STATE_FALL_RIGHT;
				else next_state = STATE_DIG_RIGHT;
			end
			STATE_SPLATTER: begin
				next_state = STATE_SPLATTER;
			end
			default: next_state = STATE_WALK_LEFT;
		endcase
	end

	// State flip-flops
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= STATE_WALK_LEFT;
			fall_counter <= 0;
		end
		else begin
			state <= next_state;

			if (state == STATE_FALL_LEFT || state == STATE_FALL_RIGHT) 
				fall_counter <= fall_counter + 1;
			else
				fall_counter <= 0;
		end
	end

	// Output logic
	always @(*) begin
		case (state)
			STATE_WALK_LEFT: begin
				walk_left = 1;
				walk_right = 0;
				aaah = 0;
				digging = 0;
			end
			STATE_WALK_RIGHT: begin
				walk_left = 0;
				walk_right = 1;
				aaah = 0;
				digging = 0;
			end
			STATE_FALL_LEFT, STATE_FALL_RIGHT: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 1;
				digging = 0;
			end
			STATE_DIG_LEFT: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 0;
				digging = 1;
			end
			STATE_DIG_RIGHT: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 0;
				digging = 1;
			end
			STATE_SPLATTER: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 0;
				digging = 0;
			end
			default: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 0;
				digging = 0;
			end
		endcase
	end

endmodule
