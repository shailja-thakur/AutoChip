module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);

	// State encoding
	typedef enum logic [1:0] {
		LEFT  = 2'b00,
		RIGHT = 2'b01
	} state_t;

	state_t state, next_state;

	// State register
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= LEFT; // On asynchronous reset, go to walk_left state
		end
		else begin
			state <= next_state;
		end
	end

	// Next state logic
	always_comb begin
		case (state)
			LEFT: begin
				if (bump_left || (bump_left && bump_right))
					next_state = RIGHT;
				else
					next_state = LEFT;
			end
			RIGHT: begin
				if (bump_right || (bump_left && bump_right))
					next_state = LEFT;
				else
					next_state = RIGHT;
			end
			default: next_state = LEFT;
		endcase
	end

	// Output logic
	assign walk_left = (state == LEFT);
	assign walk_right = (state == RIGHT);

endmodule
