module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);

	// State encoding
	parameter LEFT = 1'b0, RIGHT = 1'b1;
	
	// State register
	reg state, next_state;
	
	// Output logic based on the state
	assign walk_left = (state == LEFT);
	assign walk_right = (state == RIGHT);
	
	// State transition logic
	always @(*) begin
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
			default: next_state = LEFT;  // Default case to avoid latches
		endcase
	end
	
	// State register update logic
	always @(posedge clk or posedge areset) begin
		if (areset) 
			state <= LEFT;  // Reset state to LEFT
		else 
			state <= next_state;
	end

endmodule
