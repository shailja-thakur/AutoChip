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

	enum {WALK_LEFT, WALK_RIGHT, FALL, DIG} state;

	always @(posedge clk or posedge areset)
	begin
		if(areset)
			state <= WALK_LEFT;
		else
		begin
			case(state)
				WALK_LEFT:
					if(bump_right)
						state <= WALK_RIGHT;
					else if(ground)
					begin
						if(dig)
							state <= DIG;
						else
							state <= WALK_LEFT;
					end
					else
						state <= FALL;
				
				WALK_RIGHT:
					if(bump_left)
						state <= WALK_LEFT;
					else if(ground)
					begin
						if(dig)
							state <= DIG;
						else
							state <= WALK_RIGHT;
					end
					else
						state <= FALL;
				
				FALL:
					if(ground)
						state <= state; // No change in state
					else
						state <= FALL;
				
				DIG:
					if(!ground)
						state <= FALL;
					else if(!dig)
						state <= WALK_LEFT;
					else
						state <= DIG;
			endcase
		end
	end

	always @(state)
	begin
		walk_left = (state == WALK_LEFT);
		walk_right = (state == WALK_RIGHT);
		aaah = (state == FALL);
		digging = (state == DIG);
	end

endmodule
