module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	output reg walk_left,
	output reg walk_right,
	output reg aaah
);

	// State encoding
	typedef enum logic [1:0] {
		LEFT  = 2'b00,
		RIGHT = 2'b01,
		FALL_LEFT  = 2'b10,
		FALL_RIGHT = 2'b11
	} state_t;
	
	state_t current_state, next_state;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= LEFT;
		end else begin
			current_state <= next_state;
		end
	end

	always @(*) begin
		// Default assignments
		next_state = current_state;
		case (current_state)
			LEFT: begin
				if (!ground) begin
					next_state = FALL_LEFT;
				// If bumped on the left, change to walking right
				end else if (bump_left || (bump_left && bump_right)) begin
					next_state = RIGHT;
				end
			end
			RIGHT: begin
				if (!ground) begin
					next_state = FALL_RIGHT;
				// If bumped on the right, change to walking left
				end else if (bump_right || (bump_left && bump_right)) begin
					next_state = LEFT;
				end
			end
			FALL_LEFT: begin
				if (ground) begin
					next_state = LEFT;
				end
			end
			FALL_RIGHT: begin
				if (ground) begin
					next_state = RIGHT;
				end
			end
		endcase
	end

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			// Reset state is walking left
			walk_left <= 1;
			walk_right <= 0;
			aaah <= 0;
		end else begin
			// Output logic based on the state
			case (next_state)
				LEFT: begin
					walk_left <= 1;
					walk_right <= 0;
					aaah <= 0;
				end
				RIGHT: begin
					walk_left <= 0;
					walk_right <= 1;
					aaah <= 0;
				end
				FALL_LEFT, FALL_RIGHT: begin
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 1;
				end
			endcase
		end
	end

endmodule
