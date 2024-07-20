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
		WALK_LEFT,
		WALK_RIGHT,
		FALL
	} state_t;

	reg state_t current_state, next_state;
	
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= WALK_LEFT;
		end
		else begin
			current_state <= next_state;
		end
	end
	
	always_comb begin
		next_state = current_state;
		aaah = 0;
		
		case (current_state)
			WALK_LEFT: begin
				walk_left = 1;
				walk_right = 0;
				
				if (bump_right) begin
					next_state = WALK_RIGHT;
				end
				else if (ground == 0) begin
					next_state = FALL;
				end
			end
			
			WALK_RIGHT: begin
				walk_left = 0;
				walk_right = 1;
				
				if (bump_left) begin
					next_state = WALK_LEFT;
				end
				else if (ground == 0) begin
					next_state = FALL;
				end
			end
			
			FALL: begin
				walk_left = current_state == WALK_LEFT;
				walk_right = current_state == WALK_RIGHT;
				aaah = 1;
				
				if (ground == 1) begin
					next_state = current_state;
				end
			end
		endcase
	end
endmodule
