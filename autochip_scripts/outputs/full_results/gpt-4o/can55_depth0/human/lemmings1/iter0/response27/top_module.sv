module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);
	// Define states
	typedef enum logic [1:0] {
		LEFT = 2'b01,  // Walking left
		RIGHT = 2'b10  // Walking right
	} state_t;
	
	state_t state, next_state;

	// Output logic based on state
	assign walk_left = (state == LEFT);
	assign walk_right = (state == RIGHT);

	// State Transition Logic
	always @(*) begin
		case (state)
			LEFT: begin
				if (bump_left)
					next_state = RIGHT;
				else
					next_state = LEFT;
			end
			RIGHT: begin
				if (bump_right)
					next_state = LEFT;
				else
					next_state = RIGHT;
			end
			default: next_state = LEFT; // default case to handle any unintended states
		endcase
	end

	// State Register with asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= LEFT; // On reset, always start by walking left
		else
			state <= next_state;
	end

endmodule
