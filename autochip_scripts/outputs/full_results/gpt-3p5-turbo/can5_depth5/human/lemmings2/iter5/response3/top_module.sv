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

	// Define the possible states of the finite state machine
	parameter ST_WALK_LEFT = 2'b00;
	parameter ST_WALK_RIGHT = 2'b01;
	parameter ST_FALL = 2'b10;

	// Define the flip-flops to store the current state and next state
	reg[1:0] state;
	reg[1:0] next_state;

	// Synchronous always block for clock edge detection
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			// Reset the state machine to the initial state (walk left)
			state <= ST_WALK_LEFT;
		end else begin
			// Update the state based on the next state
			state <= next_state;
		end
	end

	// Combinational always block to compute the next state and outputs
	always @(state or bump_left or bump_right or ground) begin
		case (state)
			ST_WALK_LEFT: begin
				// If bumped on the left or right, switch to walking right
				if (bump_right) begin
					next_state = ST_WALK_RIGHT;
				end else if (bump_left) begin
					next_state = ST_WALK_RIGHT;
				// If not bumped, continue walking left
				end else begin
					next_state = ST_WALK_LEFT;
				end
			end

			ST_WALK_RIGHT: begin
				// If bumped on the right or left, switch to walking left
				if (bump_left) begin
					next_state = ST_WALK_LEFT;
				end else if (bump_right) begin
					next_state = ST_WALK_LEFT;
				// If not bumped, continue walking right
				end else begin
					next_state = ST_WALK_RIGHT;
				end
			end

			ST_FALL: begin
				// If ground reappears, resume walking in the same direction
				if (ground) begin
					next_state = (state == ST_WALK_LEFT) ? ST_WALK_LEFT : ST_WALK_RIGHT;
				// If not ground, continue falling and say "aaah!"
				end else begin
					next_state = ST_FALL;
				end
			end
		endcase
	end

	// Assign the outputs based on the current state
	always @(state) begin
		case (state)
			ST_WALK_LEFT: begin
				walk_left = 1;
				walk_right = 0;
				aaah = 0;
			end

			ST_WALK_RIGHT: begin
				walk_left = 0;
				walk_right = 1;
				aaah = 0;
			end

			ST_FALL: begin
				walk_left = (state == ST_WALK_LEFT);
				walk_right = (state == ST_WALK_RIGHT);
				aaah = 1;
			end
		endcase
	end
endmodule
