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

	// Define the output registers
	reg out_walk_left;
	reg out_walk_right;
	reg out_aaah;

	// Assign the outputs to the output registers
	always @(state) begin
		case (state)
			ST_WALK_LEFT: begin
				// Set the outputs accordingly
				out_walk_left = 1;
				out_walk_right = 0;
				out_aaah = 0;
			end

			ST_WALK_RIGHT: begin
				// Set the outputs accordingly
				out_walk_left = 0;
				out_walk_right = 1;
				out_aaah = 0;
			end

			ST_FALL: begin
				// Set the outputs accordingly
				out_walk_left = walk_left;
				out_walk_right = walk_right;
				out_aaah = 1;
			end
		endcase
	end

	// Synchronous always block for clock edge detection
	always @(posedge clk) begin
		if (areset) begin
			// Reset the state machine to the initial state (walk left)
			state <= ST_WALK_LEFT;
		end else begin
			// Update the state based on the next state
			state <= next_state;
		end
	end

	// Combinational always block to compute the next state
	always @* begin
		case (state)
			ST_WALK_LEFT: begin
				// If bumped on the left or right, switch to walking right
				if (bump_left) begin
					next_state = ST_WALK_RIGHT;
				end else if (bump_right) begin
					next_state = ST_WALK_RIGHT;
				// If not bumped, continue walking left
				end else begin
					next_state = ST_WALK_LEFT;
				end
			end

			ST_WALK_RIGHT: begin
				// If bumped on the right or left, switch to walking left
				if (bump_right) begin
					next_state = ST_WALK_LEFT;
				end else if (bump_left) begin
					next_state = ST_WALK_LEFT;
				// If not bumped, continue walking right
				end else begin
					next_state = ST_WALK_RIGHT;
				end
			end

			ST_FALL: begin
				// If ground reappears, resume walking in the same direction
				if (ground) begin
					if (state == ST_WALK_LEFT) begin
						next_state = ST_WALK_LEFT;
					end else if (state == ST_WALK_RIGHT) begin
						next_state = ST_WALK_RIGHT;
					end
				// If not ground, continue falling
				end else begin
					next_state = ST_FALL;
				end
			end
		endcase
	end

	// Assign the outputs to the output registers using nonblocking assignments
	always @(posedge clk) begin
		if (areset) begin
			walk_left <= 1'b0;
			walk_right <= 1'b0;
			aaah <= 1'b0;
		end else begin
			walk_left <= out_walk_left;
			walk_right <= out_walk_right;
			aaah <= out_aaah;
		end
	end
endmodule
