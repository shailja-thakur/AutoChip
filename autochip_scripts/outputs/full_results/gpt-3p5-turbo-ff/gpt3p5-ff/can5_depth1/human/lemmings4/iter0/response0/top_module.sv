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

reg [4:0] state;

parameter WALK_LEFT = 3'd1;
parameter WALK_RIGHT = 3'd2;
parameter FALL = 3'd3;
parameter DIG = 3'd4;
parameter SPLATTER = 3'd5;

assign walk_left = (state == WALK_LEFT);
assign walk_right = (state == WALK_RIGHT);
assign aaah = (state == FALL || state == SPLATTER);
assign digging = (state == DIG);

always @(posedge clk or posedge areset)
begin
	if (areset)
		state <= WALK_LEFT;
	else
		case(state)
			WALK_LEFT:
				begin
					if(bump_right && !bump_left)
						state <= WALK_RIGHT;
					else if(!bump_right && ground)
						state <= WALK_LEFT;
					else if(!ground)
						state <= FALL;
					else if(dig && !ground)
						state <= DIG;
					else if(fall_count >= 20)
						state <= SPLATTER;
				end
			WALK_RIGHT:
				begin
					if(bump_left && !bump_right)
						state <= WALK_LEFT;
					else if(!bump_left && ground)
						state <= WALK_RIGHT;
					else if(!ground)
						state <= FALL;
					else if(dig && !ground)
						state <= DIG;
					else if(fall_count >= 20)
						state <= SPLATTER;
				end
			FALL:
				begin
					if(ground)
						state <= WALK_LEFT;
					else if(dig && !ground)
						state <= DIG;
					else if(fall_count >= 20)
						state <= SPLATTER;
				end
			DIG:
				begin
					if(!dig || (dig && ground))
						state <= WALK_LEFT;
					else if(fall_count >= 20)
						state <= SPLATTER;
				end
			SPLATTER:
				state <= SPLATTER;
			default:
				state <= WALK_LEFT;
		endcase
end

always @(posedge clk or posedge areset)
begin
	if (areset)
		fall_count <= 0;
	else if (!ground)
		fall_count <= fall_count + 1;
	else
		fall_count <= 0;
end

reg [4:0] fall_count;

endmodule
