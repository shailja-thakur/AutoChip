module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	input dig,
	output walk_left,
	output walk_right,
	output aaah,
	output digging
);

	// Define states
	typedef enum logic [1:0] {
		WALK_LEFT,
		WALK_RIGHT,
		FALL,
		DIG
	} state_t;
	
	reg [1:0] current_state, next_state;
	
	// Define outputs
	reg walk_left, walk_right, aaah, digging;
	
	// Perform state transitions and assign outputs
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= WALK_LEFT;
			walk_left <= 1;
			walk_right <= 0;
			aaah <= 0;
			digging <= 0;
		end
		else begin
			current_state <= next_state;
		end
	end
	
	// Define combinational logic for next state and outputs
	always @(current_state or bump_left or bump_right or ground or dig) begin
		case (current_state)
			WALK_LEFT: begin
				if (bump_right)
					next_state = WALK_RIGHT;
				else if (dig && ground)
					next_state = DIG;
				else if (!ground)
					next_state = FALL;
				else
					next_state = WALK_LEFT;
				
				walk_left = 1;
				walk_right = 0;
				aaah = 0;
				digging = 0;
			end
			
			WALK_RIGHT: begin
				if (bump_left)
					next_state = WALK_LEFT;
				else if (dig && ground)
					next_state = DIG;
				else if (!ground)
					next_state = FALL;
				else
					next_state = WALK_RIGHT;
				
				walk_left = 0;
				walk_right = 1;
				aaah = 0;
				digging = 0;
			end
			
			FALL: begin
				if (ground)
					next_state = current_state;
				else
					next_state = FALL;
				
				walk_left = 0;
				walk_right = 0;
				aaah = 1;
				digging = 0;
			end
			
			DIG: begin
				if (!ground)
					next_state = FALL;
				else if (dig && ground)
					next_state = DIG;
				else if (bump_right)
					next_state = WALK_RIGHT;
				else if (bump_left)
					next_state = WALK_LEFT;
				else
					next_state = DIG;
				
				walk_left = 0;
				walk_right = 0;
				aaah = 0;
				digging = 1;
			end
		endcase
	end
	
endmodule
