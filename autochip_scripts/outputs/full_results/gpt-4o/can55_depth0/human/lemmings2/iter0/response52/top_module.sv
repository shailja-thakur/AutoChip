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

	// State encoding
	typedef enum logic [1:0] {
		LEFT = 2'd0,
		RIGHT = 2'd1,
		FALL_LEFT = 2'd2,
		FALL_RIGHT = 2'd3
	} state_t;
	
	state_t state, next_state;
	
	// State transition
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= LEFT;
		end else begin
			state <= next_state;
		end
	end
	
	// Next state logic
	always_comb begin
		next_state = state; // default next state is the same as current state
		case (state)
			LEFT: begin
				if (~ground)
					next_state = FALL_LEFT;
				else if (bump_left)
					next_state = RIGHT;
				else
					next_state = LEFT;
			end
			RIGHT: begin
				if (~ground)
					next_state = FALL_RIGHT;
				else if (bump_right)
					next_state = LEFT;
				else
					next_state = RIGHT;
			end
			FALL_LEFT: begin
				if (ground)
					next_state = LEFT;
				else
					next_state = FALL_LEFT;
			end
			FALL_RIGHT: begin
				if (ground)
					next_state = RIGHT;
				else
					next_state = FALL_RIGHT;
			end
			default: next_state = LEFT; // to handle undefined state
		endcase
	end
	
	// Output logic
	assign walk_left = (state == LEFT);
	assign walk_right = (state == RIGHT);
	assign aaah = (state == FALL_LEFT) || (state == FALL_RIGHT);
	
endmodule
