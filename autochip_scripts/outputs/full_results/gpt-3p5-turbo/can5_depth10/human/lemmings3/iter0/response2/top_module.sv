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
	
	// Define states
	enum logic [1:0] {WALK_LEFT, WALK_RIGHT, FALL, DIG} state;

	// State register
	reg [1:0] next_state;
	
	// Combinational logic for next state and outputs
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			next_state <= WALK_LEFT;
			walk_left <= 1;
			walk_right <= 0;
			aaah <= 0;
			digging <= 0;
		end else begin
			case (state)
				
				WALK_LEFT:
					if (bump_right)
						next_state <= WALK_RIGHT;
					else if (!ground)
						next_state <= FALL;
					else if (dig && ground)
						next_state <= DIG;
					else
						next_state <= WALK_LEFT;
				
				WALK_RIGHT:
					if (bump_left)
						next_state <= WALK_LEFT;
					else if (!ground)
						next_state <= FALL;
					else if (dig && ground)
						next_state <= DIG;
					else
						next_state <= WALK_RIGHT;
					
				FALL:
					if (ground && !dig)
						next_state <= walk_left ? WALK_LEFT : WALK_RIGHT;
					else
						next_state <= FALL;
				
				DIG:
					if (!ground || !dig)
						next_state <= walk_left ? WALK_LEFT : WALK_RIGHT;
					else
						next_state <= DIG;
						
				default:
					next_state <= state;
					
			endcase
		
			walk_left <= (state == WALK_LEFT);
			walk_right <= (state == WALK_RIGHT);
			aaah <= (state == FALL);
			digging <= (state == DIG);
		end
	end
	
	// Sequential logic for state
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= WALK_LEFT;
		else
			state <= next_state;
	end
	
endmodule
