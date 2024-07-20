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
	// Define the states
	typedef enum logic [1:0] {
		WALK_LEFT,
		WALK_RIGHT,
		FALL
	} State;

	// Define the signals
	State current_state;
	State next_state;

	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= WALK_LEFT;
		end else begin
			current_state <= next_state;
		end
	end

	always_comb begin
		case (current_state)
			WALK_LEFT: begin
				walk_left = 1;
				walk_right = 0;
				aaah = 0;
				if (bump_right) begin
					next_state = WALK_RIGHT;
				end else if (!ground) begin
					next_state = FALL;
				end else begin
					next_state = WALK_LEFT;
				end
			end

			WALK_RIGHT: begin
				walk_left = 0;
				walk_right = 1;
				aaah = 0;
				if (bump_left) begin
					next_state = WALK_LEFT;
				end else if (!ground) begin
					next_state = FALL;
				end else begin
					next_state = WALK_RIGHT;
				end
			end

			FALL: begin
				walk_left = (current_state == WALK_LEFT);
				walk_right = (current_state == WALK_RIGHT);
				aaah = 1;
				if (ground) begin
					next_state = current_state;
				end else begin
					next_state = FALL;
				end
			end
		endcase
	end
endmodule
