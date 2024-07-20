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
	
	// Enumerated states
	typedef enum logic[1:0] {WALK_LEFT, WALK_RIGHT, FALL} state;
	
	// State register
	reg [1:0] current_state, next_state;
	
	// Output logic
	assign walk_left = (current_state == WALK_LEFT);
	assign walk_right = (current_state == WALK_RIGHT);
	assign aaah = (current_state == FALL);
	
	// Next state logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= WALK_LEFT;
		end 
		else begin
			current_state <= next_state;
		end
	end
	
	// State transition logic
	always @(current_state, bump_left, bump_right, ground) begin
		next_state = current_state;
		
		case (current_state)
			WALK_LEFT: begin
				if (bump_right) begin
					next_state = WALK_RIGHT;
				end
				
				if (!ground) begin
					next_state = FALL;
				end
			end
			
			WALK_RIGHT: begin
				if (bump_left) begin
					next_state = WALK_LEFT;
				end
				
				if (!ground) begin
					next_state = FALL;
				end
			end
			
			FALL: begin
				if (ground) begin
					if (current_state == WALK_LEFT) begin
						next_state = WALK_LEFT;
					end
					
					if (current_state == WALK_RIGHT) begin
						next_state = WALK_RIGHT;
					end
				end
			end
		endcase
	end
	
endmodule
