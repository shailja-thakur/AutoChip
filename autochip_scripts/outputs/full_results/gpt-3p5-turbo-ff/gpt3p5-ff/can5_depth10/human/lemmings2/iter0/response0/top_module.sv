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

// Define states
parameter WALK_LEFT = 1'b0;
parameter WALK_RIGHT = 1'b1;

// Define current state and next state
reg current_state;
reg next_state;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		// Reset to initial state
		current_state <= WALK_LEFT;
	else begin
		// Update state based on current state and inputs
		current_state <= next_state;
	end
end

always @(*) begin
	case (current_state)
		WALK_LEFT:
			if (bump_right || (ground && !bump_left))
				next_state = WALK_RIGHT;
			else
				next_state = WALK_LEFT;
		WALK_RIGHT:
			if (bump_left || (ground && !bump_right))
				next_state = WALK_LEFT;
			else
				next_state = WALK_RIGHT;
	endcase
end

// Define outputs
assign walk_left = (current_state == WALK_LEFT);
assign walk_right = (current_state == WALK_RIGHT);
assign aaah = (!ground && (current_state == WALK_LEFT || current_state == WALK_RIGHT));

endmodule
