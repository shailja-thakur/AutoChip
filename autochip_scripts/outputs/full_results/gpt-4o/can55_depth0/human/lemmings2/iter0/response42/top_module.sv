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

	// Define state encoding
	typedef enum logic [2:0] {
		WALK_LEFT = 3'b000,
		WALK_RIGHT = 3'b001,
		FALL_LEFT = 3'b010,
		FALL_RIGHT = 3'b011,
		FALL_LEFT_AAAH = 3'b100,
		FALL_RIGHT_AAAH = 3'b101
	} state_t;

	state_t state, next_state;
	
	// Combinational logic for next state
	always @(*) begin
		case (state)
			WALK_LEFT: begin
				if (!ground)
					next_state = FALL_LEFT;
				else if (bump_left)
					next_state = WALK_RIGHT;
				else
					next_state = WALK_LEFT;
			end
			WALK_RIGHT: begin
				if (!ground)
					next_state = FALL_RIGHT;
				else if (bump_right)
					next_state = WALK_LEFT;
				else
					next_state = WALK_RIGHT;
			end
			FALL_LEFT: begin
				if (ground)
					next_state = WALK_LEFT;
				else
					next_state = FALL_LEFT;
			end
			FALL_RIGHT: begin
				if (ground)
					next_state = WALK_RIGHT;
				else
					next_state = FALL_RIGHT;
			end
			FALL_LEFT_AAAH: begin
				if (ground)
					next_state = WALK_LEFT;
				else
					next_state = FALL_LEFT_AAAH;
			end
			FALL_RIGHT_AAAH: begin
				if (ground)
					next_state = WALK_RIGHT;
				else
					next_state = FALL_RIGHT_AAAH;
			end
			default: next_state = WALK_LEFT;
		endcase
	end

	// Sequential logic for state transitions
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= WALK_LEFT;  // Initial state is walking left
		else
			state <= next_state;
		end
	end

	// Output logic
	always @(*) begin
		// Default values
		walk_left = 0;
		walk_right = 0;
		aaah = 0;

		case (state)
			WALK_LEFT: walk_left = 1;
			WALK_RIGHT: walk_right = 1;
			FALL_LEFT: aaah = 1;
			FALL_RIGHT: aaah = 1;
			FALL_LEFT_AAAH: aaah = 1;
			FALL_RIGHT_AAAH: aaah = 1;
		endcase
	end

endmodule
