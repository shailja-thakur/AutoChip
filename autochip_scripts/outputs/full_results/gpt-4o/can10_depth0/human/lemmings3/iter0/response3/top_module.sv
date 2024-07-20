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

	// State encoding
	typedef enum logic [3:0] {
		S_WALK_LEFT = 4'b0001,
		S_WALK_RIGHT = 4'b0010,
		S_FALL_LEFT = 4'b0100,
		S_FALL_RIGHT = 4'b1000,
		S_DIG_LEFT = 4'b0011,
		S_DIG_RIGHT = 4'b0110
	} state_t;

	state_t state, next_state;

	// State machine
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= S_WALK_LEFT;
		end else begin
			state <= next_state;
		end
	end

	// Next state logic
	always_comb begin
		next_state = state;
		case (state)
			S_WALK_LEFT: begin
				if (!ground) begin
					next_state = S_FALL_LEFT;
				end else if (dig) begin
					next_state = S_DIG_LEFT;
				end else if (bump_left || bump_right) begin
					next_state = S_WALK_RIGHT;
				end
			end
			S_WALK_RIGHT: begin
				if (!ground) begin
					next_state = S_FALL_RIGHT;
				end else if (dig) begin
					next_state = S_DIG_RIGHT;
				end else if (bump_left || bump_right) begin
					next_state = S_WALK_LEFT;
				end
			end
			S_FALL_LEFT, S_FALL_RIGHT: begin
				if (ground) begin
					next_state = (state == S_FALL_LEFT) ? S_WALK_LEFT : S_WALK_RIGHT;
				end
			end
			S_DIG_LEFT: begin
				if (!ground) begin
					next_state = S_FALL_LEFT;
				end
			end
			S_DIG_RIGHT: begin
				if (!ground) begin
					next_state = S_FALL_RIGHT;
				end
			end
			default: begin
				next_state = S_WALK_LEFT;
			end
		endcase
	end

	// Output logic
	assign walk_left = (state == S_WALK_LEFT);
	assign walk_right = (state == S_WALK_RIGHT);
	assign aaah = (state == S_FALL_LEFT) || (state == S_FALL_RIGHT);
	assign digging = (state == S_DIG_LEFT) || (state == S_DIG_RIGHT);

endmodule
