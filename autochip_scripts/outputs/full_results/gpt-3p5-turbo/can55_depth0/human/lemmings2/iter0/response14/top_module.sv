module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	output walk_left,
	output walk_right,
	output aaah
);

	reg [1:0] state;
	parameter [1:0] WALK_LEFT = 2'b00, WALK_RIGHT = 2'b01, FALLING = 2'b10;
	parameter [1:0] STAY_LEFT = 2'b00, STAY_RIGHT = 2'b01;
	
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= WALK_LEFT;
		else begin
			case (state)
				WALK_LEFT: begin
					if (bump_right)
						state <= WALK_RIGHT;
					else if (!ground)
						state <= FALLING;
					else
						state <= WALK_LEFT;
				end
				
				WALK_RIGHT: begin
					if (bump_left)
						state <= WALK_LEFT;
					else if (!ground)
						state <= FALLING;
					else
						state <= WALK_RIGHT;
				end
				
				FALLING: begin
					if (ground)
						state <= (state == WALK_LEFT) ? STAY_LEFT : STAY_RIGHT;
					else
						state <= FALLING;
				end
			endcase
		end
	end
	
	always @(state) begin
		walk_left = (state == WALK_LEFT || state == STAY_LEFT) ? 1 : 0;
		walk_right = (state == WALK_RIGHT || state == STAY_RIGHT) ? 1 : 0;
		aaah = (state == FALLING) ? 1 : 0;
	end
	
endmodule
