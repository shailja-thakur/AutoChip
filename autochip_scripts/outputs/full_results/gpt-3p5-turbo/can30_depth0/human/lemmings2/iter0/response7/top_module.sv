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
	typedef enum logic [1:0] {
		IDLE,
		LEFT,
		RIGHT,
		FALL
	} state;

	// Define current state variable
	reg state current_state;
	reg state next_state;

	// Define walking direction variables
	reg walk_left;
	reg walk_right;

	// Define outputs
	reg aaah;

	// Synchronous always_ff block for state logic
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= IDLE;
		end else begin
			current_state <= next_state;
		end
	end

	// Combinational always block for next_state logic and outputs
	always_comb begin
		case (current_state)
			IDLE: begin
				// Initial state, walking left
				walk_left = 1;
				walk_right = 0;
				aaah = 0;
				
				// Transition conditions
				if (bump_left) begin
					next_state = RIGHT;
				end else if (bump_right) begin
					next_state = LEFT;
				end else if (ground == 0) begin
					next_state = FALL;
				end else begin
					next_state = IDLE;
				end
			end

			LEFT: begin
				// Currently walking left
				walk_left = 1;
				walk_right = 0;
				aaah = 0;
				
				// Transition conditions
				if (bump_left) begin
					next_state = RIGHT;
				end else if (bump_right) begin
					next_state = LEFT;
				end else if (ground == 0) begin
					next_state = FALL;
				end else begin
					next_state = LEFT;
				end
			end

			RIGHT: begin
				// Currently walking right
				walk_left = 0;
				walk_right = 1;
				aaah = 0;
				
				// Transition conditions
				if (bump_left) begin
					next_state = RIGHT;
				end else if (bump_right) begin
					next_state = LEFT;
				end else if (ground == 0) begin
					next_state = FALL;
				end else begin
					next_state = RIGHT;
				end
			end

			FALL: begin
				// Falling state
				walk_left = (current_state == LEFT) ? 1 : 0;
				walk_right = (current_state == RIGHT) ? 1 : 0;
				aaah = 1;
				
				// Transition conditions
				if (ground == 1) begin
					next_state = (current_state == LEFT) ? LEFT : RIGHT;
				end else begin
					next_state = FALL;
				end
			end
		endcase
	end
	
endmodule
