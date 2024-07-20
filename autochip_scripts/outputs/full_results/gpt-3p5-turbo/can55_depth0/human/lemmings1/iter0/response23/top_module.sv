module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);

	// Define the states
	typedef enum logic [1:0] {
		LEFT,
		RIGHT
	} state_t;

	// Define the state register
	reg state_t current_state;

	// Define the output variable
	reg walk_left;
	reg walk_right;

	// Outputs are assigned in an always_comb block based on the current state
	always_comb begin
		case (current_state)
			LEFT:
				walk_left = 1;
				walk_right = 0;
			RIGHT:
				walk_left = 0;
				walk_right = 1;
		endcase
	end

	// State transitions and output assignments are defined in an always_ff block
	always_ff @(posedge clk, posedge areset) begin
		if (areset) begin
			// Reset to initial state (walk left)
			current_state <= LEFT;
		end else begin
			// Check for state transitions based on inputs
			if (bump_left) begin
				current_state <= RIGHT;
			end else if (bump_right) begin
				current_state <= LEFT;
			end
		end
	end

endmodule
