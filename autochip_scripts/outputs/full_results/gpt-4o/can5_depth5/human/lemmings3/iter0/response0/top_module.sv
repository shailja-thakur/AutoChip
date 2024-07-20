module top_module (
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

	// State encoding
	typedef enum logic [2:0] {
		LEFT = 3'b000,
		RIGHT = 3'b001,
		FALL_LEFT = 3'b010,
		FALL_RIGHT = 3'b011,
		DIG_LEFT = 3'b100,
		DIG_RIGHT = 3'b101
	} state_t;
	
	state_t state, next_state;

	// State transition logic (Combinational)
	always @(*) begin
		next_state = state; // Default to current state
		case(state)
			LEFT: begin
				if (!ground)           next_state = FALL_LEFT;
				else if (dig)          next_state = DIG_LEFT;
				else if (bump_left)    next_state = RIGHT;
			end
			RIGHT: begin
				if (!ground)           next_state = FALL_RIGHT;
				else if (dig)          next_state = DIG_RIGHT;
				else if (bump_right)   next_state = LEFT;
			end
			FALL_LEFT: begin
				if (ground)            next_state = LEFT;
			end
			FALL_RIGHT: begin
				if (ground)            next_state = RIGHT;
			end
			DIG_LEFT: begin
				if (!ground)           next_state = FALL_LEFT;
			end
			DIG_RIGHT: begin
				if (!ground)           next_state = FALL_RIGHT;
			end
		endcase
	end

	// State flip-flops (Sequential)
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= LEFT; 	// On reset, go to LEFT state
		else
			state <= next_state;
	end

	// Output logic (Combinational)
	always @(*) begin
		// Default outputs
		walk_left = 0;
		walk_right = 0;
		aaah = 0;
		digging = 0;
		
		case(state)
			LEFT: begin
				walk_left = 1;
			end
			RIGHT: begin
				walk_right = 1;
			end
			FALL_LEFT, FALL_RIGHT: begin
				aaah = 1;
			end
			DIG_LEFT: begin
				digging = 1;
			end
			DIG_RIGHT: begin
				digging = 1;
			end
		endcase
	end

endmodule
