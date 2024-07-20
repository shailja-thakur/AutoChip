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

	// State Encoding
	typedef enum logic [2:0] {
		WALK_LEFT = 3'b000,
		WALK_RIGHT = 3'b001,
		FALL_LEFT = 3'b010,
		FALL_RIGHT = 3'b011
	} state_t;
	
	state_t state, next_state;

	// Sequential State Transition
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= WALK_LEFT;
		end else begin
			state <= next_state;
		end
	end

	// Next State Logic
	always_comb begin
		case (state)
			WALK_LEFT: begin
				if (!ground) begin
					next_state = FALL_LEFT;
				end else if (bump_left) begin
					next_state = WALK_RIGHT;
				end else begin
					next_state = WALK_LEFT;
				end
			end
			WALK_RIGHT: begin
				if (!ground) begin
					next_state = FALL_RIGHT;
				end else if (bump_right) begin
					next_state = WALK_LEFT;
				end else begin
					next_state = WALK_RIGHT;
				end
			end
			FALL_LEFT: begin
				if (ground) begin
					next_state = WALK_LEFT;
				end else begin
					next_state = FALL_LEFT;
				end
			end
			FALL_RIGHT: begin
				if (ground) begin
					next_state = WALK_RIGHT;
				end else begin
					next_state = FALL_RIGHT;
				end
			end
			default: begin
				next_state = WALK_LEFT;
			end
		endcase
	end

	// Output Logic
	always_comb begin
		case (state)
			WALK_LEFT: begin
				walk_left = 1;
				walk_right = 0;
				aaah = 0;
			end
			WALK_RIGHT: begin
				walk_left = 0;
				walk_right = 1;
				aaah = 0;
			end
			FALL_LEFT, FALL_RIGHT: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 1;
			end
			default: begin
				walk_left = 1;
				walk_right = 0;
				aaah = 0;
			end
		endcase
	}
endmodule
