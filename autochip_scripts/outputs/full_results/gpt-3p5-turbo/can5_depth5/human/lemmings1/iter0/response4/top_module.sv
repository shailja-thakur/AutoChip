module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);

	// Define states
	typedef enum logic [1:0] {
		WALK_LEFT,
		WALK_RIGHT
	} state_type;

	// Define state register and next state register
	reg state_type current_state;
	reg state_type next_state;

	// Define outputs
	reg walk_left;
	reg walk_right;

	// Synchronous process for state transition and output generation
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= WALK_LEFT;
		end else begin
			current_state <= next_state;
		end
	end

	// Combinational process to determine next state and outputs based on current state and inputs
	always @(*) begin
		case (current_state)
			WALK_LEFT:
				begin
					if (bump_right) begin
						next_state = WALK_RIGHT;
					end else begin
						next_state = WALK_LEFT;
					end
					walk_left = 1;
					walk_right = 0;
				end
			WALK_RIGHT:
				begin
					if (bump_left) begin
						next_state = WALK_LEFT;
					end else begin
						next_state = WALK_RIGHT;
					end
					walk_left = 0;
					walk_right = 1;
				end
		endcase
	end

endmodule
