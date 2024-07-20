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

	// Define state enumeration
	typedef enum logic [1:0] {
		IDLE,
		WALK_LEFT,
		WALK_RIGHT,
		FALL
	} state_type;

	// Declare state and next_state variables
	reg state_type state;
	reg state_type next_state;

	// Assign initial state
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= IDLE;
		else
			state <= next_state;
	end

	// State logic and output assignments
	always @(state or bump_left or bump_right or ground) begin
		// Default assignments
		walk_left <= 0;
		walk_right <= 0;
		aaah <= 0;

		case (state)
			IDLE: begin
				// Outputs are all default values in IDLE state
				if (bump_left)
					next_state <= WALK_RIGHT;
				else if (bump_right)
					next_state <= WALK_LEFT;
				else if (ground == 0)
					next_state <= FALL;
				else
					next_state <= IDLE;
			end
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
					next_state <= state;
				else if (bump_left)
					next_state <= WALK_RIGHT;
				else if (bump_right)
					next_state <= WALK_LEFT;
				else
					next_state <= FALL;
			end
		endcase
	end

	// Output assignments
	always @(state or next_state) begin
		case (state)
			IDLE: begin
				walk_left <= 1;
			end
			WALK_LEFT: begin
				walk_left <= 1;
			end
			WALK_RIGHT: begin
				walk_right <= 1;
			end
			FALL: begin
				aaah <= 1;
			end
		endcase
	end

endmodule
