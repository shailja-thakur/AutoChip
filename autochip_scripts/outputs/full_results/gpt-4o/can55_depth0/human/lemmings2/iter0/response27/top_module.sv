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
	typedef enum {LEFT, RIGHT, FALLING_LEFT, FALLING_RIGHT} state_t;
	state_t state, next_state;

	// State transitions
	always @(*) begin
		case (state)
			LEFT: begin
				if (!ground) begin
					next_state = FALLING_LEFT;
				end else if (bump_left) begin
					next_state = RIGHT;
				end else begin
					next_state = LEFT;
				end
			end
			RIGHT: begin
				if (!ground) begin
					next_state = FALLING_RIGHT;
				end else if (bump_right) begin
					next_state = LEFT;
				end else begin
					next_state = RIGHT;
				end
			end
			FALLING_LEFT: begin
				if (ground) begin
					next_state = LEFT;
				end else begin
					next_state = FALLING_LEFT;
				end
			end
			FALLING_RIGHT: begin
				if (ground) begin
					next_state = RIGHT;
				end else begin
					next_state = FALLING_RIGHT;
				end
			end
		endcase
	end

	// State flip-flops with asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= LEFT;
		end else begin
			state <= next_state;
		end
	end

	// Output logic
	always @(*) begin
		// Default outputs
		walk_left = 0;
		walk_right = 0;
		aaah = 0;
		
		case (state)
			LEFT: begin
				walk_left = 1;
			end
			RIGHT: begin
				walk_right = 1;
			end
			FALLING_LEFT, FALLING_RIGHT: begin
				aaah = 1;
			end
		endcase
	end

endmodule
