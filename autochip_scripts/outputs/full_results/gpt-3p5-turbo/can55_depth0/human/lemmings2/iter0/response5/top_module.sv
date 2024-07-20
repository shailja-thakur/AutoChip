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
	} state_type;
	
	// Define the state register and next state variables
	reg state_type current_state;
	reg state_type next_state;
	
	// Define the outputs
	reg walk_left;
	reg walk_right;
	reg aaah;
	
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= WALK_LEFT;
			walk_left <= 1;
			walk_right <= 0;
			aaah <= 0;
		end
		else begin
			current_state <= next_state;
			
			case (current_state)
				WALK_LEFT: begin
					if (bump_right)
						next_state <= WALK_RIGHT;
					else if (ground == 0)
						next_state <= FALL;
					else
						next_state <= WALK_LEFT;
				end
				
				WALK_RIGHT: begin
					if (bump_left)
						next_state <= WALK_LEFT;
					else if (ground == 0)
						next_state <= FALL;
					else
						next_state <= WALK_RIGHT;
				end
				
				FALL: begin
					if (ground == 1)
						next_state <= current_state;
					else
						next_state <= FALL;
				end
			endcase
			
			case (current_state)
				WALK_LEFT: begin
					walk_left <= 1;
					walk_right <= 0;
					aaah <= 0;
				end
				
				WALK_RIGHT: begin
					walk_left <= 0;
					walk_right <= 1;
					aaah <= 0;
				end
				
				FALL: begin
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 1;
				end
			endcase
		end
	end

endmodule
