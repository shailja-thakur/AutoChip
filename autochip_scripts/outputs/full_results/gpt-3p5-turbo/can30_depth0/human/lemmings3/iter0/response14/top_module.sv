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

reg [1:0] state;
reg walk_left;
reg walk_right;
reg aaah;
reg digging;

// State Definitions
parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;
parameter DIGGING = 2'b10;

always @(posedge clk or posedge areset)
begin
	if (areset)
		state <= WALK_LEFT;
	else
	begin
		case (state)
			WALK_LEFT:
				if (bump_right && !bump_left && ground)
					state <= WALK_RIGHT;
				else if (dig && ground)
					state <= DIGGING;
				else if (!ground)
					state <= WALK_LEFT;
				else
					state <= WALK_LEFT;
			
			WALK_RIGHT:
				if (bump_left && !bump_right && ground)
					state <= WALK_LEFT;
				else if (dig && ground)
					state <= DIGGING;
				else if (!ground)
					state <= WALK_RIGHT;
				else
					state <= WALK_RIGHT;
			
			DIGGING:
				if (!ground)
					state <= DIGGING;
				else if (bump_right && !bump_left && ground)
					state <= WALK_RIGHT;
				else if (bump_left && !bump_right && ground)
					state <= WALK_LEFT;
				else
					state <= DIGGING;
		endcase
	end
end

always @*
begin
	case (state)
		WALK_LEFT:
			begin
				walk_left = 1;
				walk_right = 0;
				aaah = 0;
				digging = 0;
			end
			
		WALK_RIGHT:
			begin
				walk_left = 0;
				walk_right = 1;
				aaah = 0;
				digging = 0;
			end
			
		
		DIGGING:
			begin
				walk_left = 0;
				walk_right = 0;
				aaah = 0;
				digging = 1;
			end
	endcase
end

endmodule
