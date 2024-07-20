module lemming_machine (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	input dig,
	output reg walk_left,
	output reg walk_right,
	output reg aaah,
	output reg digging
);

	// Define states
	typedef enum logic [1:0] {
		WALK_TO_LEFT,
		WALK_TO_RIGHT,
		FALLING,
		DIGGING
	} state_t;

	reg state_t current_state, next_state;

	// Initialize state
	initial begin
		current_state <= WALK_TO_LEFT;
	end

	// Define state transitions
	always @(posedge clk or posedge areset) begin
		if (areset == 1) begin
			current_state <= WALK_TO_LEFT;
		end
		else begin
			current_state <= next_state;
		end
	end

	// Define state outputs
	always @* begin
		walk_left = 0;
		walk_right = 0;
		aaah = 0;
		digging = 0;
		
		case (current_state)
			WALK_TO_LEFT: begin
				walk_left = 1;
				if (bump_right) begin
					next_state = WALK_TO_RIGHT;
				end
				else if (ground == 0) begin
					next_state = FALLING;
				end
				else if (dig) begin
					next_state = DIGGING;
				end
				else begin
					next_state = WALK_TO_LEFT;
				end
			end
			WALK_TO_RIGHT: begin
				walk_right = 1;
				if (bump_left) begin
					next_state = WALK_TO_LEFT;
				end
				else if (ground == 0) begin
					next_state = FALLING;
				end
				else if (dig) begin
					next_state = DIGGING;
				end
				else begin
					next_state = WALK_TO_RIGHT;
				end
			end
			FALLING: begin
				aaah = 1;
				if (ground == 1 && !dig) begin
					next_state = current_state;
				end
				else begin
					next_state = FALLING;
				end
			end
			DIGGING: begin
				digging = 1;
				if (ground == 0) begin
					next_state = FALLING;
				end
				else begin
					next_state = DIGGING;
				end
			end
			default: begin
				next_state = current_state;
			end
		endcase
	end

endmodule
