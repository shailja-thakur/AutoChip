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
reg walk_left, walk_right, aaah, digging;

parameter INIT = 5'b00000;
parameter WALK_LEFT = 5'b00001;
parameter WALK_RIGHT = 5'b00010;
parameter FALL = 5'b00011;
parameter DIG = 5'b00100;

always @(posedge clk or posedge areset) begin
	if (areset)
		state <= INIT;
	else begin
		case (state)
			INIT:
				if (areset)
					state <= INIT;
				else if (bump_left)
					state <= WALK_RIGHT;
				else if (bump_right)
					state <= WALK_LEFT;
				else if (dig && ground)
					state <= DIG;
				else if (ground == 0)
					state <= FALL;
				else
					state <= WALK_LEFT;
			WALK_LEFT:
				if (areset)
					state <= INIT;
				else if (bump_left)
					state <= WALK_RIGHT;
				else if (bump_right)
					state <= FALL;
				else if (dig && ground)
					state <= DIG;
				else if (ground == 0)
					state <= FALL;
				else
					state <= WALK_LEFT;
			WALK_RIGHT:
				if (areset)
					state <= INIT;
				else if (bump_right)
					state <= WALK_LEFT;
				else if (bump_left)
					state <= FALL;
				else if (dig && ground)
					state <= DIG;
				else if (ground == 0)
					state <= FALL;
				else
					state <= WALK_RIGHT;
			FALL:
				if (areset)
					state <= INIT;
				else if (ground)
					state <= WALK_LEFT;
				else if (aaah)
					state <= FALL;
				else
					state <= FALL;
			DIG:
				if (areset)
					state <= INIT;
				else if (ground)
					state <= WALK_LEFT;
				else if (digging)
					state <= DIG;
				else
					state <= FALL;
		endcase
	end
end

always @(state) begin
	case (state)
		INIT:
			begin
				walk_left = 1'b1;
				walk_right = 1'b0;
				aaah = 1'b0;
				digging = 1'b0;
			end
		WALK_LEFT:
			begin
				walk_left = 1'b1;
				walk_right = 1'b0;
				aaah = 1'b0;
				digging = 1'b0;
			end
		WALK_RIGHT:
			begin
				walk_left = 1'b0;
				walk_right = 1'b1;
				aaah = 1'b0;
				digging = 1'b0;
			end
		FALL:
			begin
				walk_left = 1'b0;
				walk_right = 1'b0;
				aaah = 1'b1;
				digging = 1'b0;
			end
		DIG:
			begin
				walk_left = 1'b0;
				walk_right = 1'b0;
				aaah = 1'b0;
				digging = 1'b1;
			end
	endcase
end

endmodule
