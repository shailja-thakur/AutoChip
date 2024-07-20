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

	parameter IDLE = 2'b00;
	parameter WALK_LEFT = 2'b01;
	parameter WALK_RIGHT = 2'b10;
	
	reg [1:0] state;
	reg walk_left;
	reg walk_right;
	reg aaah;
	reg digging;
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= IDLE;
			walk_left <= 1'b0;
			walk_right <= 1'b0;
			aaah <= 1'b0;
			digging <= 1'b0;
		end else begin
			case (state)
				IDLE:
					if (bump_left && !bump_right)
						state <= WALK_RIGHT;
					else if (bump_right && !bump_left)
						state <= WALK_LEFT;
					else if (!bump_left && !bump_right && !dig && !ground)
						aaah <= 1'b1;
					else if (dig && ground)
						state <= WALK_LEFT;
				WALK_LEFT:
					if (bump_right && !bump_left)
						state <= WALK_RIGHT;
					else if (!ground)
						aaah <= 1'b1;
					else if (dig && ground)
						state <= WALK_RIGHT;
					else if (dig && !ground)
						state <= WALK_LEFT;
				WALK_RIGHT:
					if (bump_left && !bump_right)
						state <= WALK_LEFT;
					else if (!ground)
						aaah <= 1'b1;
					else if (dig && ground)
						state <= WALK_LEFT;
					else if (dig && !ground)
						state <= WALK_RIGHT;
			endcase
			
			case (state)
				IDLE:
					walk_left <= 1'b1;
					walk_right <= 1'b0;
					aaah <= 1'b0;
					digging <= 1'b0;
				WALK_LEFT:
					walk_left <= 1'b1;
					walk_right <= 1'b0;
					aaah <= 1'b0;
					digging <= 1'b0;
				WALK_RIGHT:
					walk_left <= 1'b0;
					walk_right <= 1'b1;
					aaah <= 1'b0;
					digging <= 1'b0;
			endcase
		end
	end
	
endmodule
