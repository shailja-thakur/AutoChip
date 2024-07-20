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
	reg [4:0] state;

	// State Definitions
	parameter [4:0]	WALK_LEFT = 5'b00001,
						WALK_RIGHT = 5'b00010,
						FALL = 5'b00100,
						DIG = 5'b01000,
						SPLATTER = 5'b10000;

	// State Register and Next State Logic
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= WALK_LEFT;
		else
			case (state)
				WALK_LEFT:
					if (bump_right)
						state <= WALK_RIGHT;
					else if ((bump_left && ground) || (bump_left && !ground && state != FALL) || (bump_left && !ground && state == FALL && aaah))
						state <= FALL;
					else if (dig && ground)
						state <= DIG;
					else
						state <= WALK_LEFT;
				WALK_RIGHT:
					if (bump_left)
						state <= WALK_LEFT;
					else if ((bump_right && ground) || (bump_right && !ground && state != FALL) || (bump_right && !ground && state == FALL && aaah))
						state <= FALL;
					else if (dig && ground)
						state <= DIG;
					else
						state <= WALK_RIGHT;
				FALL:
					if (ground)
						state <= WALK_LEFT;
					else if (state == FALL && aaah)
						state <= SPLATTER;
					else
						state <= FALL;
				DIG:
					if (!ground || (state == DIG && !dig))
						state <= FALL;
					else
						state <= DIG;
				SPLATTER:
					state <= SPLATTER;
				default:
					state <= WALK_LEFT;
			endcase
	end

	// Output Logic
	always @(state, ground, dig, aaah) begin
		case (state)
			WALK_LEFT:
				walk_left = 1;
				walk_right = 0;
				digging = 0;
				aaah = 0;
			WALK_RIGHT:
				walk_left = 0;
				walk_right = 1;
				digging = 0;
				aaah = 0;
			FALL:
				walk_left = 0;
				walk_right = 0;
				digging = 0;
				aaah = 1;
			DIG:
				walk_left = 0;
				walk_right = 0;
				digging = 1;
				aaah = 0;
			SPLATTER:
				walk_left = 0;
				walk_right = 0;
				digging = 0;
				aaah = 0;
			default:
				walk_left = 1;
				walk_right = 0;
				digging = 0;
				aaah = 0;
		endcase
	end

endmodule
