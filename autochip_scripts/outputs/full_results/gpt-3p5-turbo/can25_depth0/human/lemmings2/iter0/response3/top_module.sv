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

	// State definitions
	parameter [1:0] WALK_LEFT = 2'b00;
	parameter [1:0] WALK_RIGHT = 2'b01;
	parameter [1:0] FALL = 2'b10;
	
	reg [1:0] state;
	
	// Output assignments
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			walk_left <= 1'b1;
			walk_right <= 1'b0;
			aaah <= 1'b0;
			state <= WALK_LEFT;
		end else begin
			case (state)
				WALK_LEFT: begin
					if (bump_right)
						state <= WALK_RIGHT;
					else if (!ground)
						state <= FALL;
				end
				WALK_RIGHT: begin
					if (bump_left)
						state <= WALK_LEFT;
					else if (!ground)
						state <= FALL;
				end
				FALL: begin
					if (ground)
						state <= state[1:0];
				end
			endcase
			
			case (state)
				WALK_LEFT: begin
					walk_left <= 1'b1;
					walk_right <= 1'b0;
					aaah <= 1'b0;
				end
				WALK_RIGHT: begin
					walk_left <= 1'b0;
					walk_right <= 1'b1;
					aaah <= 1'b0;
				end
				FALL: begin
					walk_left <= 1'b0;
					walk_right <= 1'b0;
					aaah <= 1'b1;
				end
			endcase
		end
	end
	
endmodule
