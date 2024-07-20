module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	output reg walk_left,
	output reg walk_right,
	output reg aaah
);

	// State declaration
	enum {WALK_LEFT, WALK_RIGHT, FALL} state;

	// State register
	reg [1:0] next_state, current_state;

	// Output register
	reg next_walk_left, next_walk_right;

	// Reset the state to initial state on positive edge of areset
	always @(posedge areset) begin
		current_state <= WALK_LEFT;
	end

	// Next state logic
	always @(posedge clk) begin
		current_state <= next_state;
	end

	// State logic
	always @* begin
		case (current_state)
			WALK_LEFT:
				begin
					// Set output values
					next_walk_left = 1;
					next_walk_right = 0;
					
					// Determine next state based on inputs
					if (bump_left && !bump_right) begin
						next_state = WALK_RIGHT;
					end
					else if (!bump_left && bump_right) begin
						next_state = WALK_LEFT;
					end
					else if (bump_left && bump_right) begin
						next_state = WALK_RIGHT;
					end
					else if (!ground) begin
						next_state = FALL;
					end
					else begin
						next_state = WALK_LEFT;
					end
				end
				
			WALK_RIGHT:
				begin
					// Set output values
					next_walk_left = 0;
					next_walk_right = 1;
					
					// Determine next state based on inputs
					if (bump_left && !bump_right) begin
						next_state = WALK_RIGHT;
					end
					else if (!bump_left && bump_right) begin
						next_state = WALK_LEFT;
					end
					else if (bump_left && bump_right) begin
						next_state = WALK_LEFT;
					end
					else if (!ground) begin
						next_state = FALL;
					end
					else begin
						next_state = WALK_RIGHT;
					end
				end
				
			FALL:
				begin
					// Set output values
					next_walk_left = walk_left;
					next_walk_right = walk_right;
					aaah = 1;
					
					// Determine next state based on inputs
					if (ground) begin
						next_state = (walk_left) ? WALK_LEFT : WALK_RIGHT;
					end
					else begin
						next_state = FALL;
					end
				end
		endcase
	end
	
	// Output logic
	always @(posedge clk) begin
		walk_left <= next_walk_left;
		walk_right <= next_walk_right;
	end

endmodule
