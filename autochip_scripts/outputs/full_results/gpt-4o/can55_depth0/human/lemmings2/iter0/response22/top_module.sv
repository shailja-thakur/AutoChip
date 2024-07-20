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
	typedef enum reg [2:0] {
		LEFT = 3'd0,
		RIGHT = 3'd1,
		FALL_LEFT = 3'd2,
		FALL_RIGHT = 3'd3,
	} state_t;

	state_t state, next_state;

	// State transition logic
	always @(*) begin
		case (state)
			LEFT: begin
				if (!ground)
					next_state = FALL_LEFT;
				else if (bump_left)
					next_state = RIGHT;
				else
					next_state = LEFT;
			end
			RIGHT: begin
				if (!ground)
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
		endcase
	end

	// State flip-flops with asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= LEFT;
		else
			state <= next_state;
		end
	end

	// Output logic
	assign walk_left  = (state == LEFT);
	assign walk_right = (state == RIGHT);
	assign aaah       = (state == FALL_LEFT) || (state == FALL_RIGHT);

endmodule
