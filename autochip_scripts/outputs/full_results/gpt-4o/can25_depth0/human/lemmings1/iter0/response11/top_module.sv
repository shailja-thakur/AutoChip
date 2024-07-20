module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);
	
	// State declarations
	typedef enum logic [1:0] {
		LEFT = 2'b01,  // State for walking left
		RIGHT = 2'b10  // State for walking right
	} state_t;
	
	state_t state, next_state;

	// State transition on clock edge
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= LEFT;  // Asynchronous reset to walking left
		end else begin
			state <= next_state;
		end
	end

	// Next state logic
	always_comb begin
		case (state)
			LEFT: begin
				if (bump_left || bump_right)
					next_state = RIGHT;  // Switch to walking right if bumped on either side
				else
					next_state = LEFT;
			end
			RIGHT: begin
				if (bump_left || bump_right)
					next_state = LEFT;   // Switch to walking left if bumped on either side
				else
					next_state = RIGHT;
			end
			default: next_state = LEFT;  // Default to walking left
		endcase
	end

	// Output logic
	assign walk_left = (state == LEFT);
	assign walk_right = (state == RIGHT);
	
endmodule
