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
		STATE_WALK_LEFT   = 3'd0,
		STATE_WALK_RIGHT  = 3'd1,
		STATE_FALL_LEFT   = 3'd2,
		STATE_FALL_RIGHT  = 3'd3,
		STATE_DIG_LEFT    = 3'd4,
		STATE_DIG_RIGHT   = 3'd5,
		STATE_SPLATTERED  = 3'd6
	} state_t;
	
	state_t state, next_state;
	reg [4:0] fall_counter; // 5-bit counter to count up to 20 cycles
	
	// State transition logic
	always @(*) begin
		case (state)
			STATE_WALK_LEFT: begin
				if (!ground)
					next_state = STATE_FALL_LEFT;
				else if (dig)
					next_state = STATE_DIG_LEFT;
				else if (bump_left)
					next_state = STATE_WALK_RIGHT;
				else
					next_state = STATE_WALK_LEFT;
			end
			STATE_WALK_RIGHT: begin
				if (!ground)
					next_state = STATE_FALL_RIGHT;
				else if (dig)
					next_state = STATE_DIG_RIGHT;
				else if (bump_right)
					next_state = STATE_WALK_LEFT;
				else
					next_state = STATE_WALK_RIGHT;
			end
			STATE_FALL_LEFT: begin
				if (ground) begin
					if (fall_counter > 20)
						next_state = STATE_SPLATTERED;
					else
						next_state = STATE_WALK_LEFT;
				end
				else
					next_state = STATE_FALL_LEFT;
			end
			STATE_FALL_RIGHT: begin
				if (ground) begin
					if (fall_counter > 20)
						next_state = STATE_SPLATTERED;
					else
						next_state = STATE_WALK_RIGHT;
				end
				else
					next_state = STATE_FALL_RIGHT;
			end
			STATE_DIG_LEFT: begin
				if (!ground)
					next_state = STATE_FALL_LEFT;
				else
					next_state = STATE_DIG_LEFT;
			end
			STATE_DIG_RIGHT: begin
				if (!ground)
					next_state = STATE_FALL_RIGHT;
				else
					next_state = STATE_DIG_RIGHT;
			end
			STATE_SPLATTERED: begin
				next_state = STATE_SPLATTERED; // Remain splattered
			end
			default: next_state = STATE_WALK_LEFT;
		endcase
	end

	// State flip-flops
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= STATE_WALK_LEFT;
			fall_counter <= 0;
		end else begin
			state <= next_state;
			if (state == STATE_FALL_LEFT || state == STATE_FALL_RIGHT)
				fall_counter <= fall_counter + 1;
			else
				fall_counter <= 0;
		end
	end
	
	// Output logic
	always @(*) begin
		walk_left = 0;
		walk_right = 0;
		aaah = 0;
		digging = 0;
		case (state)
			STATE_WALK_LEFT:   walk_left = 1;
			STATE_WALK_RIGHT:  walk_right = 1;
			STATE_FALL_LEFT, STATE_FALL_RIGHT: aaah = 1;
			STATE_DIG_LEFT:    digging = 1;
			STATE_DIG_RIGHT:   digging = 1;
			STATE_SPLATTERED:  begin
				walk_left = 0;
				walk_right = 0;
				aaah = 0;
				digging = 0;
			end
		endcase
	end

endmodule
