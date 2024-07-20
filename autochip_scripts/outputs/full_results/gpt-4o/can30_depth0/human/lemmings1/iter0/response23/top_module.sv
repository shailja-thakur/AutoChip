module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output reg walk_left,
	output reg walk_right
);

	// State encoding
	typedef enum reg {LEFT, RIGHT} state_t;
	state_t state, next_state;

	// State transition logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= LEFT;  // Reset to walk left state
		end else begin
			state <= next_state;
		end
	end

	// Next state logic
	always @(*) begin
		case (state)
			LEFT: begin
				if (bump_left || bump_right) begin
					next_state = RIGHT;  // Switch to walking right
				end else begin
					next_state = LEFT;   // Continue walking left
				end
			end
			RIGHT: begin
				if (bump_left || bump_right) begin
					next_state = LEFT;   // Switch to walking left
				end else begin
					next_state = RIGHT;  // Continue walking right
				end
			end
			default: next_state = LEFT;  // Default state
		endcase
	end

	// Output logic
	always @(*) begin
		case (state)
			LEFT: begin
				walk_left = 1;
				walk_right = 0;
			end
			RIGHT: begin
				walk_left = 0;
				walk_right = 1;
			end
			default: begin
				walk_left = 1;
				walk_right = 0;
			end
		endcase
	end

endmodule
