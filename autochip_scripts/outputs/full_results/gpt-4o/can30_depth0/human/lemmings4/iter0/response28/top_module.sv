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

	// Define state encoding
	typedef enum logic [2:0] {
		STATE_WALK_LEFT  = 3'b000,
		STATE_WALK_RIGHT = 3'b001,
		STATE_FALL_LEFT  = 3'b010,
		STATE_FALL_RIGHT = 3'b011,
		STATE_DIG_LEFT   = 3'b100,
		STATE_DIG_RIGHT  = 3'b101,
		STATE_SPLAT      = 3'b110
	} state_t;

	state_t state, next_state;
	logic [5:0] fall_counter; // 6 bits to count up to 32 clock cycles

	// State transition logic
	always @(*) begin
		case (state)
			STATE_WALK_LEFT: begin
				if (!ground) // Falling
					next_state = STATE_FALL_LEFT;
				else if (dig) // Dig while walking left
					next_state = STATE_DIG_LEFT;
				else if (bump_left && bump_right) // Bumped from both sides
					next_state = STATE_WALK_RIGHT;
				else if (bump_left) // Bumped from left
					next_state = STATE_WALK_RIGHT;
				else
					next_state = STATE_WALK_LEFT;
			end
			STATE_WALK_RIGHT: begin
				if (!ground) // Falling
					next_state = STATE_FALL_RIGHT;
				else if (dig) // Dig while walking right
					next_state = STATE_DIG_RIGHT;
				else if (bump_left && bump_right) // Bumped from both sides
					next_state = STATE_WALK_LEFT;
				else if (bump_right) // Bumped from right
					next_state = STATE_WALK_LEFT;
				else
					next_state = STATE_WALK_RIGHT;
			end
			STATE_FALL_LEFT: begin
				if (ground) begin
					if (fall_counter >= 20) // Splatter after falling more than 20 cycles 
						next_state = STATE_SPLAT;
					else
						next_state = STATE_WALK_LEFT;
				end
				else
					next_state = STATE_FALL_LEFT;
			end
			STATE_FALL_RIGHT: begin
				if (ground) begin
					if (fall_counter >= 20) // Splatter after falling more than 20 cycles 
						next_state = STATE_SPLAT;
					else
						next_state = STATE_WALK_RIGHT;
				end
				else
					next_state = STATE_FALL_RIGHT;
			end
			STATE_DIG_LEFT: begin
				if (!ground) // Falling while digging
					next_state = STATE_FALL_LEFT;
				else
					next_state = STATE_DIG_LEFT;
			end
			STATE_DIG_RIGHT: begin
				if (!ground) // Falling while digging
					next_state = STATE_FALL_RIGHT;
				else
					next_state = STATE_DIG_RIGHT;
			end
			STATE_SPLAT: begin
				next_state = STATE_SPLAT; // Remain splat forever
			end
			default: begin
				next_state = STATE_WALK_LEFT;
			end
		endcase
		// Prioritizing falling over digging, and digging over switching direction
		if (!ground)
			next_state = (state == STATE_WALK_LEFT || state == STATE_FALL_LEFT || state == STATE_DIG_LEFT) ? STATE_FALL_LEFT : STATE_FALL_RIGHT;
		else if (dig)
			next_state = (state == STATE_WALK_LEFT) ? STATE_DIG_LEFT : (state == STATE_WALK_RIGHT) ? STATE_DIG_RIGHT : state;
	end

	// State flip-flops with asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= STATE_WALK_LEFT;
		else
			state <= next_state;
	end

	// Fall counter logic
	always @(posedge clk or posedge areset) begin
		if (areset)
			fall_counter <= 0;
		else if (state == STATE_FALL_LEFT || state == STATE_FALL_RIGHT)
			fall_counter <= fall_counter + 1;
		else
			fall_counter <= 0;
	end

	// Output logic
	always @(*) begin
		walk_left = (state == STATE_WALK_LEFT);
		walk_right = (state == STATE_WALK_RIGHT);
		aaah = (state == STATE_FALL_LEFT || state == STATE_FALL_RIGHT);
		digging = (state == STATE_DIG_LEFT || state == STATE_DIG_RIGHT);
	end
endmodule
