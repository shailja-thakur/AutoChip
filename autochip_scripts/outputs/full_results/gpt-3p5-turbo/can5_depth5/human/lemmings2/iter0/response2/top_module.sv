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
	parameter IDLE = 0, WALK_LEFT = 1, WALK_RIGHT = 2, FALL = 3;
	
	always @(posedge clk or posedge areset) begin
		if (areset == 1) begin
			state <= IDLE;
		end else begin
			case (state)
				IDLE: begin
					if (bump_left == 1) begin
						state <= WALK_RIGHT;
					end else if (bump_right == 1) begin
						state <= WALK_LEFT;
					end else if (ground == 0) begin
						state <= FALL;
					end
				end
				
				WALK_LEFT: begin
					if (bump_right == 1) begin
						state <= WALK_LEFT;
					end else if (ground == 0) begin
						state <= FALL;
					end
				end
				
				WALK_RIGHT: begin
					if (bump_left == 1) begin
						state <= WALK_RIGHT;
					end else if (ground == 0) begin
						state <= FALL;
					end
				end
				
				FALL: begin
					if (ground == 1) begin
						if (state == WALK_LEFT) begin
							state <= WALK_LEFT;
						end else if (state == WALK_RIGHT) begin
							state <= WALK_RIGHT;
						end
					end
				end
			endcase
		end
	end
	
	always @(state) begin
		case (state)
			IDLE: begin
				aaah = 0;
				walk_left = 1;
				walk_right = 0;
			end
			
			WALK_LEFT: begin
				aaah = 0;
				walk_left = 1;
				walk_right = 0;
			end
			
			WALK_RIGHT: begin
				aaah = 0;
				walk_left = 0;
				walk_right = 1;
			end
			
			FALL: begin
				aaah = 1;
				walk_left = 0;
				walk_right = 0;
			end
		endcase
	end

endmodule
