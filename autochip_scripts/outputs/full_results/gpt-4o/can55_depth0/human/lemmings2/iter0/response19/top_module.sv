module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	output walk_left,
	output walk_right,
	output aaah
);

	// Define states
	typedef enum logic [1:0] {
		WALK_LEFT = 2'b00,
		WALK_RIGHT = 2'b01,
		FALL_LEFT = 2'b10,
		FALL_RIGHT = 2'b11
	} state_t;
	
	state_t state, next_state;
	
	always_ff @(posedge clk or posedge areset) begin
		if (areset)
			state <= WALK_LEFT;
		else
			state <= next_state;
	end

	always_comb begin
		case (state)
			WALK_LEFT: begin
				if (!ground)
					next_state = FALL_LEFT;
				else if (bump_left || bump_right)
					next_state = WALK_RIGHT;
				else
					next_state = WALK_LEFT;
			end

			WALK_RIGHT: begin
				if (!ground)
					next_state = FALL_RIGHT;
				else if (bump_left || bump_right)
					next_state = WALK_LEFT;
				else
					next_state = WALK_RIGHT;
			end

			FALL_LEFT: begin
				if (ground)
					next_state = WALK_LEFT;
				else
					next_state = FALL_LEFT;
			end

			FALL_RIGHT: begin
				if (ground)
					next_state = WALK_RIGHT;
				else
					next_state = FALL_RIGHT;
			end

			default: next_state = WALK_LEFT;
		endcase
	end
	
	assign walk_left = (state == WALK_LEFT);
	assign walk_right = (state == WALK_RIGHT);
	assign aaah = (state == FALL_LEFT) || (state == FALL_RIGHT);

endmodule
