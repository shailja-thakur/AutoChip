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
		LEFT,
		RIGHT
	} state_type;

	// Define state register
	reg state_type current_state;
	reg walk_left;
	reg walk_right;

	// Define outputs
	assign walk_left = (current_state == LEFT);
	assign walk_right = (current_state == RIGHT);

	// Define next state logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= LEFT;
		end else begin
			case (current_state)
				LEFT: begin
					if (bump_right)
						current_state <= RIGHT;
				end
				RIGHT: begin
					if (bump_left)
						current_state <= LEFT;
				end
			endcase
		end
	end

endmodule
