module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);

	// Define states
	parameter IDLE = 1'b0;
	parameter WALK_LEFT = 1'b1;

	// Define current state
	reg [1:0] state, next_state;

	// Define output
	reg walk_left, walk_right;

	// Sequential logic
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= WALK_LEFT;
		else
			state <= next_state;
	end

	// Combinational logic
	always @* begin
		walk_left = 1'b1;
		walk_right = 1'b0;

		case (state)
			IDLE: begin
				if (bump_left)
					next_state = WALK_RIGHT;
				else if (bump_right)
					next_state = WALK_LEFT;
				else
					next_state = IDLE;
			end
			WALK_LEFT: begin
				if (bump_right)
					next_state = WALK_LEFT;
				else if (bump_left)
					next_state = WALK_RIGHT;
				else
					next_state = WALK_LEFT;
			end
		endcase
	end
endmodule
