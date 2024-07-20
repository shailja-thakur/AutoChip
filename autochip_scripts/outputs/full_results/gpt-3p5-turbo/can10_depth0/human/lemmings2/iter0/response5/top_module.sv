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
	typedef enum logic [1:0] {LEFT, RIGHT, FALLING} state_t;
	state_t state, next_state;
	
	// Define outputs
	reg walk_left, walk_right, aaah;
	
	// Register to hold previous ground value
	reg prev_ground;
	
	// Initialize state and outputs
	initial begin
		state = LEFT;
		walk_left = 1;
		walk_right = 0;
		aaah = 0;
		prev_ground = 1;
	end
	
	// State transition and output logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= LEFT;
			walk_left <= 1;
			walk_right <= 0;
			aaah <= 0;
			prev_ground <= 1;
		end else begin
			state <= next_state;
			walk_left <= 0;
			walk_right <= 0;
			aaah <= 0;
			
			case (state)
				LEFT: begin
					if (bump_right) begin
						next_state = RIGHT;
						walk_left <= 0;
						walk_right <= 1;
					end else if (bump_left && !bump_right) begin
						next_state = LEFT;
						walk_left <= 1;
						walk_right <= 0;
					end else if (!ground) begin
						next_state = FALLING;
						aaah <= 1;
					end else begin
						next_state = LEFT;
						walk_left <= 1;
						walk_right <= 0;
					end
				end
				
				RIGHT: begin
					if (bump_left) begin
						next_state = LEFT;
						walk_left <= 1;
						walk_right <= 0;
					end else if (bump_right && !bump_left) begin
						next_state = RIGHT;
						walk_left <= 0;
						walk_right <= 1;
					end else if (!ground) begin
						next_state = FALLING;
						aaah <= 1;
					end else begin
						next_state = RIGHT;
						walk_left <= 0;
						walk_right <= 1;
					end
				end
				
				FALLING: begin
					if (prev_ground && ground) begin
						next_state = state;
						walk_left <= (state == LEFT);
						walk_right <= (state == RIGHT);
					end else begin
						next_state = FALLING;
						aaah <= 1;
					end
				end
			endcase
			
			// Store current ground value
			prev_ground <= ground;
		end
	end
	
endmodule
