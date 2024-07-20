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

	reg [1:0] state;

	// States
	parameter IDLE = 2'd0;
	parameter WALKING_LEFT = 2'd1;
	parameter WALKING_RIGHT = 2'd2;
	parameter FALLING = 2'd3;
	parameter DIGGING = 2'd4;

	initial 
	begin
		state = IDLE;
		walk_left = 1'b1;
		walk_right = 1'b0;
		aaah = 1'b0;
		digging = 1'b0;
	end

	always @(posedge clk or posedge areset)
	begin
		if (areset)
		begin
			state <= IDLE;
			walk_left <= 1'b1;
			walk_right <= 1'b0;
			aaah <= 1'b0;
			digging <= 1'b0;
		end
		else
		begin
			case (state)
				IDLE:
					begin
						if (bump_left)
							state <= WALKING_RIGHT;
						else if (bump_right)
							state <= WALKING_LEFT;
						else if (~ground)
							state <= FALLING;
						else if (dig && ground)
							state <= DIGGING;
						else
							state <= IDLE;
					end
				WALKING_LEFT:
					begin
						if (bump_right)
							state <= WALKING_RIGHT;
						else if (~ground)
							state <= FALLING;
						else if (dig && ground)
							state <= DIGGING;
						else
							state <= WALKING_LEFT;
					end
				WALKING_RIGHT:
					begin
						if (bump_left)
							state <= WALKING_LEFT;
						else if (~ground)
							state <= FALLING;
						else if (dig && ground)
							state <= DIGGING;
						else
							state <= WALKING_RIGHT;
					end
				FALLING:
					begin
						if (ground)
							state <= WALKING_LEFT;
						else
							state <= FALLING;
					end
				DIGGING:
					begin
						if (~ground)
							state <= FALLING;
						else if (~dig)
							state <= WALKING_LEFT;
						else
							state <= DIGGING;
					end
			endcase
		end
	end

	always @(state)
	begin
		case (state)
			IDLE:
				begin
					walk_left <= 1'b1;
					walk_right <= 1'b0;
					aaah <= 1'b0;
					digging <= 1'b0;
				end
			WALKING_LEFT:
				begin
					walk_left <= 1'b1;
					walk_right <= 1'b0;
					aaah <= 1'b0;
					digging <= 1'b0;
				end
			WALKING_RIGHT:
				begin
					walk_left <= 1'b0;
					walk_right <= 1'b1;
					aaah <= 1'b0;
					digging <= 1'b0;
				end
			FALLING:
				begin
					walk_left <= 1'b0;
					walk_right <= 1'b0;
					aaah <= 1'b1;
					digging <= 1'b0;
				end
			DIGGING:
				begin
					walk_left <= 1'b0;
					walk_right <= 1'b0;
					aaah <= 1'b0;
					digging <= 1'b1;
				end
		endcase
	end
endmodule
