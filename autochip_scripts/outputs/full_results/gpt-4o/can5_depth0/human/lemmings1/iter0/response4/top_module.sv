module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);

	// Define state encoding
	typedef enum logic [1:0] {
		LEFT = 2'b01,
		RIGHT = 2'b10
	} state_t;

	state_t state, next_state;

	// State transition logic
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= LEFT;
		end else begin
			state <= next_state;
		end
	end

	// Next state logic
	always_comb begin
		case (state)
			LEFT: begin
				if (bump_left)
					next_state = RIGHT;
				else
					next_state = LEFT;
			end
			RIGHT: begin
				if (bump_right)
					next_state = LEFT;
				else
					next_state = RIGHT;
			end
			default: next_state = LEFT; // X-state protection
		endcase
	end

	// Output logic
	assign walk_left = (state == LEFT);
	assign walk_right = (state == RIGHT);

endmodule
