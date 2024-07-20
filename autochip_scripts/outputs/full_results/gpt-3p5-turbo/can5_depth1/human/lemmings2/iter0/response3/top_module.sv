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
		WALK_LEFT, WALK_RIGHT, FALL
	} State;

	// Define the signals
	reg        [1:0]  curr_state;
	reg        [1:0]  next_state;
	reg                change_dir;
	reg                falling;

	// Reset the machine to the initial state
	always @(posedge areset) begin
		curr_state   <= WALK_LEFT;
		change_dir   <= 0;
		falling      <= 0;
	end

	// Define the next state logic
	always @(posedge clk) begin
		curr_state   <= next_state;
		change_dir   <= 0;
		falling      <= 0;
		
		// Default next state is current state
		next_state   = curr_state;
		
		case (curr_state)
			WALK_LEFT: begin
				if (bump_right) begin
					next_state   = WALK_RIGHT;
					change_dir   = 1;
				end else if (ground == 0) begin
					next_state   = FALL;
					falling      = 1;
				end
			end
			
			WALK_RIGHT: begin
				if (bump_left) begin
					next_state   = WALK_LEFT;
					change_dir   = 1;
				end else if (ground == 0) begin
					next_state   = FALL;
					falling      = 1;
				end
			end
			
			FALL: begin
				if (ground == 1) begin
					if (falling == 1) begin
						if (change_dir == 1) begin
							next_state   = if (curr_state == WALK_LEFT) WALK_RIGHT;
										   else if (curr_state == WALK_RIGHT) WALK_LEFT;
						end else begin
							next_state   = if (curr_state == WALK_LEFT) WALK_LEFT;
										   else if (curr_state == WALK_RIGHT) WALK_RIGHT;
						end
					end else begin
						next_state   = if (curr_state == WALK_LEFT) WALK_LEFT;
									   else if (curr_state == WALK_RIGHT) WALK_RIGHT;
					end
					
					falling   = 0;
				end
			end
		endcase
	end

	// Define the output signals
	always @(*) begin
		case (curr_state)
			WALK_LEFT: begin
				walk_left   = 1;
				walk_right  = 0;
				aaah        = 0;
			end
			
			WALK_RIGHT: begin
				walk_left   = 0;
				walk_right  = 1;
				aaah        = 0;
			end
			
			FALL: begin
				walk_left   = 0;
				walk_right  = 0;
				aaah        = 1;
			end
		endcase
	end

endmodule
