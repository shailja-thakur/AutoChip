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

	// state encoding
	typedef enum logic [2:0] {
		S_WALK_LEFT = 3'b000,
		S_WALK_RIGHT = 3'b001,
		S_FALL = 3'b010,
		S_DIG = 3'b011
	} state_t;

	state_t state, next_state;

	// state transition logic
	always @(*) begin
		case (state)
			S_WALK_LEFT: begin
				if (!ground)
					next_state = S_FALL;
				else if (dig)
					next_state = S_DIG;
				else if (bump_left)
					next_state = S_WALK_RIGHT;
				else
					next_state = S_WALK_LEFT;
			end
			S_WALK_RIGHT: begin
				if (!ground)
					next_state = S_FALL;
				else if (dig)
					next_state = S_DIG;
				else if (bump_right)
					next_state = S_WALK_LEFT;
				else
					next_state = S_WALK_RIGHT;
			end
			S_FALL: begin
				if (ground)
					next_state = (walk_left) ? S_WALK_LEFT : S_WALK_RIGHT;
				else
					next_state = S_FALL;
			end
			S_DIG: begin
				if (!ground)
					next_state = S_FALL;
				else
					next_state = S_DIG;
			end
			default: next_state = S_WALK_LEFT;
		endcase
	\end

	// state flip-flops
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= S_WALK_LEFT;
		else
			state <= next_state;
	\end

	// output logic
	always @(*) begin
		case (state)
			S_WALK_LEFT: begin
				walk_left = 1;
				walk_right = 0;
				aaah = 0;
				digging = 0;
			end
			S_WALK_RIGHT: begin
				walk_left = 0;
				walk_right = 1;
				aaah = 0;
				digging = 0;
			end
			S_FALL: begin
				walk_left = (state == S_WALK_LEFT);
				walk_right = (state == S_WALK_RIGHT);
				aaah = 1;
				digging = 0;
			end
			S_DIG: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 0;
				digging = 1;
			end
			default: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 0;
				digging = 0;
			end
		endcase
	\end

endmodule
