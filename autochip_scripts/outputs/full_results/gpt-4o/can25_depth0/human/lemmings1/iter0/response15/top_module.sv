module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);
	
	// State Encoding
	typedef enum logic [1:0] {LEFT = 2'b01, RIGHT = 2'b10} state_t;
	state_t state, next_state;

	// State Transition Logic
	always @(*) begin
		case (state)
			LEFT: if (bump_left) 
					next_state = RIGHT;
				else 
					next_state = LEFT;

			RIGHT: if (bump_right) 
					next_state = LEFT;
				else 
					next_state = RIGHT;

			default: 
				next_state = LEFT; // Default state (handles unexpected state)
		endcase
	end

	// State Register with Asynchronous Reset
	always @(posedge clk or posedge areset) begin
		if (areset) 
			state <= LEFT;
		else 
			state <= next_state;
	end

	// Output Logic
	assign walk_left = (state == LEFT);
	assign walk_right = (state == RIGHT);
	
endmodule
