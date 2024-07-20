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
		S_WALK_LEFT,
		S_WALK_RIGHT,
		S_FALLING
	} state_t;
	
	// Define the signals
	state_t next_state;
	state_t current_state;

	// Define the outputs
	assign walk_left = (current_state == S_WALK_LEFT) ? 1 : 0;
	assign walk_right = (current_state == S_WALK_RIGHT) ? 1 : 0;
	assign aaah = (current_state == S_FALLING) ? 1 : 0;
	
	// Synchronous process
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= S_WALK_LEFT;
		end else begin
			current_state <= next_state;
		end
	end
	
	// Combiantional process
	always_comb begin
		next_state = current_state;
		case (current_state)
			S_WALK_LEFT: begin
				if (bump_right) begin
					next_state = S_WALK_RIGHT;
				end else if (!ground) begin
					next_state = S_FALLING;
				end
			end
			
			S_WALK_RIGHT: begin
				if (bump_left) begin
					next_state = S_WALK_LEFT;
				end else if (!ground) begin
					next_state = S_FALLING;
				end
			end
			
			S_FALLING: begin
				if (ground) begin
					if (current_state == S_WALK_LEFT) begin
						next_state = S_WALK_LEFT;
					end else if (current_state == S_WALK_RIGHT) begin
						next_state = S_WALK_RIGHT;
					end
				end
			end
		endcase
	end
	
endmodule
