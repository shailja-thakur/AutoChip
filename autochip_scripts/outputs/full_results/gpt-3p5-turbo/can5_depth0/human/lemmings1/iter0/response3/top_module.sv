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
		S_WALK_LEFT,
		S_WALK_RIGHT
	} state_t;
	
	// Define state register and next state
	reg state_t state;
	reg state_t next_state;
	
	// Define outputs
	reg walk_left;
	reg walk_right;
	
	// Define always block for sequential logic
	always @(posedge clk or negedge areset) begin
		if (areset) begin
			state <= S_WALK_LEFT;
		end else begin
			state <= next_state;
		end
	end
	
	// Define always block for combinational logic
	always @* begin
		case (state)
			S_WALK_LEFT: begin
				if (bump_right && !bump_left)
					next_state = S_WALK_RIGHT;
				else
					next_state = S_WALK_LEFT;
			end
			
			S_WALK_RIGHT: begin
				if (bump_left && !bump_right)
					next_state = S_WALK_LEFT;
				else
					next_state = S_WALK_RIGHT;
			end
		endcase
	end
	
	// Define output assignment
	always @* begin
		case (state)
			S_WALK_LEFT: begin
				walk_left = 1;
				walk_right = 0;
			end
			
			S_WALK_RIGHT: begin
				walk_left = 0;
				walk_right = 1;
			end
		endcase
	end
endmodule
