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

	// State enumeration
	typedef enum logic [1:0] {
		IDLE,
		WALK_LEFT,
		WALK_RIGHT,
		FALL
	} state_t;
	
	// Define current state and next state variables
	reg state_t current_state, next_state;

	// Moore outputs
	assign walk_left = (current_state == WALK_LEFT);
	assign walk_right = (current_state == WALK_RIGHT);
	assign aaah = (current_state == FALL);

	always @(posedge clk or posedge areset) begin
		if (areset)
			current_state <= WALK_LEFT;
		else
			current_state <= next_state;
	end

	always @* begin
		next_state = current_state;
		
		case (current_state)
			IDLE:
				if (bump_left && !bump_right && ground)
					next_state = WALK_RIGHT;
				else if (!bump_left && bump_right && ground)
					next_state = WALK_LEFT;
				
			WALK_LEFT:
				if (bump_right || (!ground && !aaah))
					next_state = WALK_RIGHT;
				else if (!ground && aaah)
					next_state = FALL;
		      
			WALK_RIGHT:
				if (bump_left || (!ground && !aaah))
					next_state = WALK_LEFT;
				else if (!ground && aaah)
					next_state = FALL;
				
			FALL:
				if (ground)
					next_state = (current_state == WALK_LEFT) ? WALK_LEFT : WALK_RIGHT;
		endcase
	end
	
endmodule
